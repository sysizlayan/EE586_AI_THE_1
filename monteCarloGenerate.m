function generatedPuzzle = monteCarloGenerate(max_movement)
    global GoalState
    
    initialNode = NodeClass(GoalState);
    VisitedNodes = GoalState;  % Hold the visited nodes to prevent loops in graph
    VisitedListPosition = 2;
    
    depth = 0;
    
    while depth <= max_movement
        movement = randi(100); % Take randon integer between 1-100
        Successors = successor_withoutHeuristic(initialNode);
        
        for i=1:length(Successors)
            next = Successors(mod(movement,length(Successors))+1); %take random movement
            
            %% If the node is not visited
            if(~ismember(next.State, VisitedNodes, 'rows'))
                
                %% Store visited nodes to avoid loops
                VisitedNodes(VisitedListPosition,:)=Successors(i).State;
                VisitedListPosition = VisitedListPosition +1;
                depth = depth+1;
                initialNode = next;
                break;
            end
        end
    end

    generatedPuzzle = initialNode;
end
