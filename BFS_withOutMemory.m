function [ map, elapsed_time, queue_size ] = BFS_withMemory( StartNode )
    %Breadth_first_search to solve the Sliding puzzle problem
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    
    SearchAlgorithm = 'BFS';
    
    Queue = StartNode;  % Initialize queue with first element
    QueuePosition = 1;  % To hold the position on the queue
    CurrentState.Iteration = 0;  % Init iteration counter
    VisitedNodes = zeros(1,PuzzleSize*PuzzleSize);  % Hold the visited nodes to prevent loops in graph
    map = [];
    elapsed_time = 0;
    tic
    %Row-wise iteration on queue, holding iteration number
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION && QueuePosition<=length(Queue))
        
        %% Pop a node from the queue
        Node = Queue(QueuePosition);
        QueuePosition = QueuePosition + 1;  % Iterate on queue
        
        %% Cancel storing the visited nodes
        %VisitedNodes(length(VisitedNodes) + 1,:) = Node.State;
        
        %% If the visited node is goal, calculate the map and other metrics
        %%then return
        if(isequal(Node.State, GoalState))
            elapsed_time = toc;  % Store the elapsed time
            
            % To find the map, traceback the path using backpointers
            map_tmp = backTrace(Node);
            
            % The map is downwards, flip it to get actual map and add final
            % state
            map = [flip(map_tmp)'; Node];
            
            % Store the number of nodes for comparison
            queue_size = length(Queue);
            isSolved = 1;
            return
            
        %% If the visited node is not goal, process it
        else
            % Find successors of the node
            Successors = successor_withoutHeuristic(Node);
            
            % For each successor
            for i= 1:length(Successors)
                
                %If the node is in visited list, do nothing
                if(~ismember(Successors(i).State, VisitedNodes, 'rows'))
                    % Otherwise, make backpointer of successor the current
                    % node
                    Successors(i).BackPointer = Node;
                    
                    % Add the successor to the queue
                    Queue(length(Queue) + 1) = Successors(i);
                end
            end
                
        end
        %% Increase iteratrion after the loop
        CurrentState.Iteration = CurrentState.Iteration+1;  
    end
end

%% The function takes the node and finds the map using back pointers
function map = backTrace(Node)
    index = 1;
    while ~isequal(Node.BackPointer,[])
        Node = Node.BackPointer;
       
        map(index) = Node;
        index = index + 1;
    end
end

