function [ map, elapsed_time, visitedNodeNumber , totalNodes] = IDDFS( StartNode )
    %Breadth_first_search to solve the Sliding puzzle problem
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    global UnvisitedStack
    
    SearchAlgorithm = 'IDDFS';
    CurrentState.Iteration = 0;  % Init iteration counter
    
    map = [];
    elapsed_time = 0;
    visitedNodeNumber=0;
    totalNodes = 0;
    isSolved = 0;  % The variable holding if the puzzle is solved or not
    
    
    CurrentState.Iteration = 0;  % Init iteration counter
    tic  %% Start the clock
    
    UnvisitedStack = Stack(StartNode);  % Initialize start stack with start node
    %Row-wise iteration on stack, holding iteration number, take upmost
    %element in each iteration
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION)  % Limit the number of iterations
        for DepthLimit=1:1000  % Increase the depth in each step
            [ map, ~, visitedNodes_tmp, totalNodes_tmp ] = DFS_for_IDDFS(DepthLimit);
            totalNodes = totalNodes + totalNodes_tmp;
            visitedNodeNumber = visitedNodeNumber + visitedNodes_tmp;  % Cumulate the number of visited nodes
            if(isSolved == 1)  % If the map has found
                elapsed_time = toc;
                
                delete(UnvisitedStack);
                return % End the function here
            end
        end
    end
end

