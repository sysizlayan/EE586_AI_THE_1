function out = displayMap( map, elapsed_time, queue_size )
%Display map, takes the arrays of numbers and converts them to 8 puzzles
%   Output is nothing
    global CurrentState
    global PuzzleSize
    
    display(CurrentState.Iteration,'Total Iteration');
    display(elapsed_time,'Time Elapsed(seconds)');
    display(queue_size,'Number of Opened Nodes');
    display(length(map),'Total Moves');
    
    for i=1:length(map)
        puzzle = vec2mat(map(i).State,PuzzleSize);  % Convert row vectors to puzzles
        if(i == length(map))
            display(puzzle, 'GOAL');
        else
            display(puzzle, strcat('Move #',num2str(i-1),''));
        end
    end


end

