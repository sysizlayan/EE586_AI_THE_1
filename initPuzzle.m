function succ = initPuzzle( puzzle )
%ÝNÝTPUZZLE, takes a array of integers to initialize a puzzle
%   give an array which have puzzle_size^2 number of elements to init puzzle 

global PuzzleSize
global CurrentState
global VisitedNodes

assert(length(puzzle)==PuzzleSize*PuzzleSize,'The number of elements is not appropriate!');

CurrentState.puzzle.numbers = puzzle;
CurrentState.puzzle.parent = [];
CurrentState.puzzle.score = 0;
VisitedNodes = CurrentState.puzzle.numbers;

end

