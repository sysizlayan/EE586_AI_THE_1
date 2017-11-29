globals  % Initialize everything for the simulation

%% Generate Puzzles to be solved
monteCarloMatrix = NodeClass(GoalState);
monteCarloRow = [];
for movement = 1:MovementNumber
    monteCarloRow = [];
    for i = 1:MonteCarloNumber
        one_puzzle = monteCarloGenerate(movement);
        monteCarloRow = [monteCarloRow one_puzzle];
    end
    if(movement == 1)
        monteCarloMatrix = monteCarloRow;
    else
        monteCarloMatrix = [monteCarloMatrix;monteCarloRow];
    end
end

resultingElapsedTime = zeros(MovementNumber,MonteCarloNumber);
resultingVisitedNode = zeros(MovementNumber,MonteCarloNumber);
resultingTotalNode = zeros(MovementNumber,MonteCarloNumber);


for i = 1:MovementNumber
    for j = 1:MonteCarloNumber
        [ resultingElapsedTime(i,j), resultingVisitedNode(i,j), resultingTotalNode(i,j) ] = solve(monteCarloMatrix(i,j),'A_STAR','Manhattan',0,0);
    end
    display(i);
end
astar = figure;
subplot(1,3,1)
bar3(resultingElapsedTime,'stacked');
zlabel('Elapsed Time(s)');
ylabel('Movement from goal state');
title('A Star with Manhattan')
subplot(1,3,2)
bar3(resultingVisitedNode,'stacked');
zlabel('The number of Opened Nodes');
ylabel('Movement from goal state');
title('A Star with Manhattan')
subplot(1,3,3)
bar3(resultingTotalNode,'stacked');
zlabel('Maximum Memory Consumption(Number)');
ylabel('Movement from goal state');

title('A Star with Manhattan')
saveas(astar,'astar7.png');


for i = 1:MovementNumber
    for j = 1:MonteCarloNumber
        [ resultingElapsedTime(i,j), resultingVisitedNode(i,j), resultingTotalNode(i,j) ] = solve(monteCarloMatrix(i,j),'BFS_withMemory','Manhattan',0,0);
    end
    display(i);
end
bfs = figure;
subplot(1,3,1)
bar3(resultingElapsedTime,'stacked');
zlabel('Elapsed Time(s)');
ylabel('Movement from goal state');
title('BFS with memory')
subplot(1,3,2)
bar3(resultingVisitedNode,'stacked');
zlabel('The number of Opened Nodes');
ylabel('Movement from goal state');
title('BFS with memory')
subplot(1,3,3)
bar3(resultingTotalNode,'stacked');
zlabel('Maximum Memory Consumption(Number)');
ylabel('Movement from goal state');
title('BFS with memory')

saveas(bfs,'bfs7.png');


for i = 1:MovementNumber
    for j = 1:MonteCarloNumber
        [ resultingElapsedTime(i,j), resultingVisitedNode(i,j), resultingTotalNode(i,j) ] = solve(monteCarloMatrix(i,j),'IDDFS','Manhattan',0,0);
    end
    display(i);
end
iddfs = figure;
subplot(1,3,1)
bar3(resultingElapsedTime,'stacked');
zlabel('Elapsed Time(s)');
ylabel('Movement from goal state');
title('IDDFS')
subplot(1,3,2)
bar3(resultingVisitedNode,'stacked');
zlabel('The number of Opened Nodes');
ylabel('Movement from goal state');
title('IDDFS')
subplot(1,3,3)
bar3(resultingTotalNode,'stacked');
zlabel('Maximum Memory Consumption(Number)');
ylabel('Movement from goal state');
title('IDDFS')

saveas(iddfs,'iddfs7.png');

