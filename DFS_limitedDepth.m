function [ map, elapsed_time, visitedNodes ] = DFS_limitedDepth( StartNode )
    %Breadth_first_search to solve the Sliding puzzle problem
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    
    SearchAlgorithm = 'DFS';
    
    Stack = StartNode;  % Initialize queue with first element
    StackPosition = 1;  % To hold the position on the queue
    
    DepthLimit = 1000;  % To prevent looping
    
    CurrentState.Iteration = 0;  % Init iteration counter
    VisitedNodes = zeros(1,PuzzleSize*PuzzleSize);  % Hold the visited nodes to prevent loops in graph
    VisitedListPosition = 1;
    
    map = [];
    elapsed_time = 0;
    isSolved = 0;  % The variable holding if the puzzle is solved or not
    
    
    tic  %% Start the clock
    %Row-wise iteration on stack, holding iteration number, take upmost
    %element in each iteration
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION && StackPosition > 0)
        %% Pop a node from the stack
        Node = Stack(StackPosition);
        StackPosition = StackPosition - 1 ;  % Iterate on stack
        
        %% Add the node to the visited nodes list to prevent loops
        VisitedNodes(VisitedListPosition,:) = Node.State;
        VisitedListPosition = VisitedListPosition +1;
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
            visitedNodes = VisitedListPosition;
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
                        StackPosition = StackPosition +1;
                        Stack(StackPosition) = Successors(i);
                    end
                end
            end
        end
        %% Increase iteratrion after the loop
        CurrentState.Iteration = CurrentState.Iteration+1;  
    end
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


