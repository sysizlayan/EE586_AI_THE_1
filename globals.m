% This holds edge count of the puzzle
global PuzzleSize  

% This holds the algorithm to be used to solve the graph
global SearchAlgorithm
%%Possible Values
% BFS_withMemory
% DFS_limitedDepth
% A_STAR
% IDDFS

%This hold the function to be used as heuristic, which can be 'Manhattan'
%or ' Misplaced'
global HeuristicFunction
%%Possible Values
% Misplaced
% Manhattan

global MaxDepth


% To prevent high memory usage
global MAX_NUMBER_OF_ITERATION  

% The variable holding if the puzzle is solved or not
global isSolved

% Total number of montecarlo simulation for one movement from goal state
global MonteCarloNumber

% Total number of movement from goal state for simulation
global MovementNumber

global CurrentState
global GoalState


PuzzleSize = 3;
MAX_NUMBER_OF_ITERATION = 100000;
SearchAlgorithm = 'A_STAR';
MaxDepth = 100;
CurrentState.Iteration = 0;
HeuristicFunction = 'Manhattan';
MonteCarloNumber = 20; % Slow computer
MovementNumber = 7; % actual distance from goal
isSolved = 0;
%% THE GOAL!
GoalState = [linspace(1,PuzzleSize*PuzzleSize-1,PuzzleSize*PuzzleSize-1),-1];

assert((strcmp(SearchAlgorithm,'BFS_withMemory')) ||(strcmp(SearchAlgorithm,'DFS_limitedDepth')) || (strcmp(SearchAlgorithm,'A_STAR')) || (strcmp(SearchAlgorithm,'IDDFS')), 'Algorithm is not correct!' )

%% Insert your puzzle here as row vector, use -1 for blank
wanted_puzzle = [3,4,6,1,-1,8,7,2,5];

puzzle = NodeClass(wanted_puzzle);