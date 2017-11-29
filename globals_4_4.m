% This holds edge count of the puzzle
global PuzzleSize  

% This holds the algorithm to be used to solve the graph
global SearchAlgorithm

%This hold the function to be used as heuristic, which can be 'Manhattan'
%or ' Misplaced'
global HeuristicFunction 

% To prevent high memory usage
global MAX_NUMBER_OF_ITERATION  

% The variable holding if the puzzle is solved or not
global isSolved

global CurrentState
global GoalState


dummy_puzzle = [1,2,3,4,5,6,7,8,9,-1,11,12,13,10,14,15];
%dummy_puzzle = [1,2,3,4,5,6,7,-1,8];

PuzzleSize = 4;
MAX_NUMBER_OF_ITERATION = 100000;
CurrentState.Iteration = 0;
HeuristicFunction = 'Misplaced';

%% THE GOAL!
GoalState = [linspace(1,PuzzleSize*PuzzleSize-1,PuzzleSize*PuzzleSize-1),-1];

puzz = NodeClass(dummy_puzzle);
