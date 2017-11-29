function [ map, elapsed_time, visitedNodeNumber, totalNodes] = DFS_for_IDDFS(DepthLimit )
    %Depth_first_search to solve the Sliding puzzle problem
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global UnvisitedStack
    
    % To save time always begin with unvisited nodes
    stack = UnvisitedStack; 
    
    %Storage stack for next iteration, initizalized empty
    unvisStack = Stack(NodeClass(zeros(1,PuzzleSize*PuzzleSize)));  
    
    VisitedNodes = zeros(1,PuzzleSize*PuzzleSize);  % Hold the visited nodes to prevent loops in graph
    
    map = [];
    elapsed_time = 0;
    visitedNodeNumber = 0;
    totalNodes = 0;
    %Row-wise iteration on stack, holding iteration number, take upmost
    %element in each iteration
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION && stack.StackPosition > 0)  % Iterate while stack is not empty
        %% Pop a node from the stack
        Node = pop(stack);
        
        %% Add the node to the visited nodes list to prevent loops
        VisitedNodes(end+1,:) = Node.State;
        
        %% If the visited node is goal, calculate the map and other metrics
        %%then return
        if(isequal(Node.State, GoalState))
            elapsed_time = toc;  % Store the elapsed time
            
            % To find the map, traceback the path using backpointers
            map_tmp = backTrace(Node);
            
            % The map is downwards, flip it to get actual map and add final
            % state
            map = [flip(map_tmp)'; Node];
            
            % Store the number of visited nodes for comparison
            visitedNodeNumber = length(VisitedNodes);
            
            
            % Store the number of total nodes for comparison
            totalNodes = visitedNodeNumber + stack.StackPosition;
            
            isSolved = 1;
            return
        
            
        %% Until here it is almost same with BFS except using stack instead of queue
        
        %% If the visited node is not goal, process it
        else
            %% If the node is within the depth limit, process its successors otherwise ignore the node
            if(Node.Depth<=DepthLimit) 
                % Find successors of the node
                Successors = successor_withoutHeuristic(Node);

                % For each successor, from 2 to 4 possible
                for i= 1:length(Successors)

                    %If the node is in visited list, do nothing
                    if(~ismember(Successors(i).State, VisitedNodes, 'rows'))
                        % Otherwise, make backpointer of successor the current
                        % node
                        Successors(i).BackPointer = Node;

                        % Increase the depth
                        Successors(i).Depth = Node.Depth+1;

                        % Add successor to the stack
                        push(stack,Successors(i));
                    end
                end
            else
                push(unvisStack,Node);  %Unvisited nodes is stored for nezt deepening
            end
            
        end
        %% Increase iteration after the loop
        CurrentState.Iteration = CurrentState.Iteration+1;
        if(mod(CurrentState.Iteration,1000)==0)
            display(CurrentState.Iteration,'Iteration');
        end
    end
    
    UnvisitedStack = unvisStack; % Save unvisited nodes for the next deepening
    visitedNodeNumber = length(VisitedNodes);
end

%% The function takes the node and finds the map using back pointers
function map = backTrace(Node)
    map = []; 
    %%Iterate until reaching empty backpointer
    while ~isequal(Node.BackPointer,[])
        Node = Node.BackPointer;
       
        map = [map,Node];
    end
end
