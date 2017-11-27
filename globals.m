% This holds edge count of the puzzle
global PuzzleSize  

% This holds the algorithm to be used to solve the graph
global SearchAlgorithm  

% To prevent high memory usage
global MAX_NUMBER_OF_ITERATION  

% The variable holding if the puzzle is solved or not
global isSolved

global CurrentState
global GoalState

dummy_puzzle = [3,4,6,1,-1,8,7,2,5];
%dummy_puzzle = [1,2,3,4,5,6,7,-1,8];

PuzzleSize = 3;
MAX_NUMBER_OF_ITERATION = 10000000;
CurrentState.Iteration = 0;

%% THE GOAL!
GoalState = [linspace(1,PuzzleSize*PuzzleSize-1,PuzzleSize*PuzzleSize-1),-1];
