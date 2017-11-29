function [ map, elapsed_time, visitedNodes ] = A_star( StartNode, HeuristicFunc )
%A-star algorithm solving puzzle problem
%takes startingn node and wanted heuristic function as input
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    
    SearchAlgorithm = 'A_STAR';
%% Check if the heuristic is correct
assert((STRCMP(HeuristicFunc,'Manhattan')||STRCMP(HeuristicFunc,'Misplaced')),'The heuristic function is not valid');



end

