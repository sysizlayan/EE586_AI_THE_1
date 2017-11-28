function [ map, elapsed_time, visitedNodes, openedNodes ] = BFS_withMemory( StartNode )
    %Breadth_first_search to solve the Sliding puzzle problem
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    
    SearchAlgorithm = 'BFS';
    
    queue = Queue(StartNode);  % Initialize a queue with starting node
    
    CurrentState.Iteration = 0;  % Init iteration counter
    VisitedNodes = zeros(1,PuzzleSize*PuzzleSize);  % Hold the visited nodes to prevent loops in graph
    VisitedListPosition = 1;
    
    map = [];
    elapsed_time = 0;
    isSolved = 0;  % The variable holding if the puzzle is solved or not
    tic
    %Row-wise iteration on queue, holding iteration number
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION && queue.QueuePosition<=length(queue.QueueArray))
        
        %% Pop a node from the queue
        Node = pop(queue);
        
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
            openedNodes = queue.QueuePosition;
            isSolved = 1;
            return
            
        %% If the visited node is not goal, process it
        else
            % Find successors of the node
            Successors = successor_withoutHeuristic(Node);
            
            % For each successor, from 2 to 4 possible
            for i= 1:length(Successors)
                
                %If the node is in visited list, do nothing
                if(~ismember(Successors(i).State, VisitedNodes, 'rows'))
                    % Otherwise, make backpointer of successor the current
                    % node
                    Successors(i).BackPointer = Node;
                    
                    % Add the successor to the queue
                    push(queue, Successors(i));
                end
            end
                
        end
        %% Increase iteratrion after the loop
        CurrentState.Iteration = CurrentState.Iteration+1;
        if(mod(CurrentState.Iteration,1000)==0)
            display(CurrentState.Iteration,'Iteration');
        end
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

