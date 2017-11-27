classdef NodeClass
    %NODECLASS is a class which holds a puzzle
    %   Takes an row-array of puzzlesize^2 
    %   Initializes the node
    
    properties
        BackPointer  % Holds predecessor, required for the map from the bottom
        State  % Holds state of the puzzle
        Depth  % Holds position of from the top, required for DFS and IDFS
        HueristicScore  % Holds the heuristic score for A-star
    end
    
    methods
        % Constructor Method
        function obj = NodeClass(PuzzleArray)
            obj.BackPointer = [];
            obj.State= PuzzleArray;
            obj.Depth = 0;
            obj.HueristicScore = 0;
        end
        
        %% Takes the current state and returns successors list
        function Successors = successor_withoutHeuristic(node)
            global PuzzleSize
            PositionOfBlank = find(node.State == -1);  % Finds the index of the blank
            
            % Required variable to check right or lef movement is valid
            RightOrLeftValidity = mod(PositionOfBlank, PuzzleSize);
            
            Successors = [];
            %% UP
            if(PositionOfBlank>PuzzleSize)  % Upward movement of blank is valid
                %Create a copy of the node
                node1 = NodeClass(node.State);
                % Take target number to blank position, upward movement
                node1.State(PositionOfBlank) = node.State(PositionOfBlank-PuzzleSize);
                % Make moved number blank
                node1.State(PositionOfBlank-PuzzleSize) = -1;
                
                Successors = [Successors;node1];  % Append to the successors list
            end
            %% RIGHT
            if(RightOrLeftValidity ~= 0)  % Movement to right is valid
                %Create a copy of the node
                node2 = NodeClass(node.State);
                % Take target number to blank position,
                % movement to the right
                node2.State(PositionOfBlank) = node.State(PositionOfBlank+1);
                % Make moved number blank
                node2.State(PositionOfBlank+1) = -1;
                Successors = [Successors;node2];  % Append to the successors list
            end
            %% DOWN
            if(PositionOfBlank<PuzzleSize*PuzzleSize-PuzzleSize+1)  % Downward movement is valid
                %Create a copy of the node
                node3 = NodeClass(node.State);
                % Take target number to blank position
                % Downward movement 
                node3.State(PositionOfBlank) = node.State(PositionOfBlank+PuzzleSize);
                % Make moved number blank
                node3.State(PositionOfBlank+PuzzleSize) = -1;
                Successors = [Successors;node3];  % Append to the successors list
            end
            
            %% LEFT
            if(RightOrLeftValidity ~= 1)  % Movement to left is valid
                %Create a copy of the node
                node4 = NodeClass(node.State);
                % Take target number to blank position
                % Movement to the left
                node4.State(PositionOfBlank) = node.State(PositionOfBlank-1);
                % Make moved number blank
                node4.State(PositionOfBlank-1) = -1;
                Successors = [Successors;node4];  % Append to the successors list
            end
        end
    end
    
end

