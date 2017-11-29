function [ map, elapsed_time, visitedNodes ] = IDDFS( StartNode )
    %Breadth_first_search to solve the Sliding puzzle problem
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    
    
    
    CurrentState.Iteration = 0;  % Init iteration counter
    
    map = [];
    elapsed_time = 0;
    elapsed_time_tmp = 0;
    visitedNodes=0;
    visitedNodes_tmp = 0;
    isSolved = 0;  % The variable holding if the puzzle is solved or not
    
    
    %tic  %% Start the clock
    %Row-wise iteration on stack, holding iteration number, take upmost
    %element in each iteration
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION)  % Limit the number of iterations
        for DepthLimit=1:100  % Increase the depth in each step
            [ map, elapsed_time_tmp, visitedNodes_tmp ] = DFS_limitedDepth(StartNode, DepthLimit);
            elapsed_time = elapsed_time + elapsed_time_tmp;  % Cumulate the time of each depth iteration
            visitedNodes = visitedNodes + visitedNodes_tmp;  % Cumulate the number of visited nodes
            if(isSolved == 1)  % If the map has found
                SearchAlgorithm = 'IDDFS';
                return % End the function here
            end
        end
    end
end

