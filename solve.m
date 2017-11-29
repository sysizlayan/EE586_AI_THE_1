function [map, elapsed_time, visitedNodeNumber, totalNodes ]  = solve( initial_node, algorithm, heuristic, max_depth, verbose )
% Takes starting algorithm, starting node, heuristic function and depth
% limit then solves a 8-puzzle problem accordingly

    % This holds the algorithm to be used to solve the graph
    global SearchAlgorithm

    %This hold the function to be used as heuristic, which can be 'Manhattan'
    %or ' Misplaced'
    global HeuristicFunction
    
    SearchAlgorithm = algorithm;
    HeuristicFunction = heuristic;
    
    assert((strcmp(algorithm,'BFS_withMemory')) ||(strcmp(algorithm,'DFS_limitedDepth')) || (strcmp(algorithm,'A_STAR')) || (strcmp(algorithm,'IDDFS')), 'Algorithm is not correct!' )
    assert((strcmp(HeuristicFunction,'Manhattan')||strcmp(HeuristicFunction,'Misplaced')),'The heuristic function is not valid');

    if(strcmp(algorithm,'BFS_withMemory'))
        [ map, elapsed_time, visitedNodeNumber, totalNodes ] = BFS_withMemory(initial_node);
    elseif(strcmp(algorithm,'DFS_limitedDepth'))
        [ map, elapsed_time, visitedNodeNumber, totalNodes ] = DFS_limitedDepth(initial_node);
    elseif(strcmp(algorithm,'IDDFS'))
        [ map, elapsed_time, visitedNodeNumber, totalNodes ] = IDDFS(initial_node);
    elseif(strcmp(algorithm,'A_STAR'))
        [ map, elapsed_time, visitedNodeNumber, totalNodes ] = A_star(initial_node,heuristic);
    end
    if(verbose == 1)
        displayMap(map, elapsed_time, totalNodes);
    end
    
end

