function [ map, elapsed_time, visitedNodes, openedNodes ] = A_star( StartNode, HeuristicFunc )
%A-star algorithm solving puzzle problem
%takes startingn node and wanted heuristic function as input
    global GoalState
    global CurrentState
    global PuzzleSize
    global MAX_NUMBER_OF_ITERATION
    global isSolved
    global SearchAlgorithm
    global HeuristicFunction 
    
    SearchAlgorithm = 'A_STAR';
    HeuristicFunction = HeuristicFunc;
    
    %% Check if the heuristic is correct
    assert((strcmp(HeuristicFunc,'Manhattan')||strcmp(HeuristicFunc,'Misplaced')),'The heuristic function is not valid');

    OpenList = StartNode;  % Initialize a list with starting node
    OpenListPosition = 1;
    ClosedList = NodeClass(zeros(1,PuzzleSize*PuzzleSize));  % Initialize an empty list
	ClosedListPosition = 0;
    Node = [];
    CurrentState.Iteration = 0;  % Init iteration counter
    
    map = [];
    elapsed_time = 0;
    visitedNodes = 0;
    openedNodes = 0;
    isSolved = 0;  % The variable holding if the puzzle is solved or not
    tic
    %Row-wise iteration on queue, holding iteration number, openQueue is
    %not empty
    while(CurrentState.Iteration<= MAX_NUMBER_OF_ITERATION && ~isempty(OpenList))
        
        %% Find the minimum-heuristic node in the list
        min = 10000000;  % Random large number, larger than maks possible heuristic score
        min__heur_position = -1;  %index of the node with minimum heuristic
        for i = 1:length(OpenList)
            if(OpenList(i).HeuristicScore<min)
                min = OpenList(i).HeuristicScore;
                min__heur_position = i;
            end
        end
        
        Node = OpenList(min__heur_position);  %% Attain the min-heuristic node
        
        %% Remove the min-heuristic node from the list
        if(min__heur_position~=length(OpenList) && length(OpenList)~=1)
            OpenList(min__heur_position:end-1)=OpenList(min__heur_position+1:end);
            OpenList(end) = [];
        elseif(min__heur_position==length(OpenList))
            OpenList(end) = [];
        elseif(length(OpenList)==1) % IF just 1 member is available, make the list empty
            OpenList = [];
        end
        
        % Find successors of the min-heuristic node, their heuristic score
        % is also calculated
        Successors = successor_withHeuristic(Node);
        
        for i=1:length(Successors)
            
            %% For backtracing, make parent, current node
            Successors(i).BackPointer = Node; 
            Successors(i).Depth = Node.Depth +1 ;
            Successors(i).HeuristicScore = Successors(i).HeuristicScore + Successors(i).Depth;
            %% If the successor node is goal, calculate the map and other metrics
            %%then return
            if(isequal(Successors(i).State, GoalState))
                elapsed_time = toc;  % Store the elapsed time

                % To find the map, traceback the path using backpointers
                map_tmp = backTrace(Successors(i));

                % The map is downwards, flip it to get actual map and add final
                % state
                map = [flip(map_tmp)'; Successors(i)];

                 % Store the number of visited nodes for comparison
                visitedNodes = ClosedListPosition-1;
                openedNodes = length(OpenList) + ClosedListPosition-1;
                isSolved = 1;
                return
            else
                % For each element of openlist
                for j = 1:length(OpenList)
                    % Check if the current node is in the open list
                    if(isequal(Successors(i).State,OpenList(j).State))
                        % If there are smaller heuristics for same state
                        if(OpenList(j).HeuristicScore<Successors(i).HeuristicScore)
                            % Skip this successor
                            continue; 
                        end
                    end
                end
                % For each element of closedlist
                for j = 1:length(ClosedList)
                    % Check if the current node is in the closed list
                    if(isequal(Successors(i).State,ClosedList(j).State))
                        % If there are smaller heuristics for same state
                        if(ClosedList(j).HeuristicScore<Successors(i).HeuristicScore)
                            % Skip this successor
                            continue; 
                        end
                    end
                end
                
                % If the successor has minimum heuristic and does not
                % available in both list add it to the openlist
                OpenList(end+1)=Successors(i);
            end
        end
        % Add the processed node to the closed list
        ClosedListPosition = ClosedListPosition +1; 
        ClosedList(ClosedListPosition) = Node;
        
         %% Increase iteration after the loop
        CurrentState.Iteration = CurrentState.Iteration+1;
        if(mod(CurrentState.Iteration,1000)==0)
            display(CurrentState.Iteration,'Iteration');
        end
    end
end



%% The function takes the node and finds the map using back pointers
function map = backTrace(Node)
    map = []; 
    %%Iterate until reaching empty backpointer
    while ~isequal(Node.BackPointer,[])
        Node = Node.BackPointer;
       
        map = [map,Node];
    end
end
