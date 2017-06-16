function [output, net] = Train1(trainVectors, trainLabels, tests)
    S1 = 50;
    [R,Q] = size(trainVectors);
    [S2,Q] = size(trainLabels);
    net = newff(minmax(trainVectors),[70 60 S2],{'logsig', 'tansig','tansig'},'trainscg'); 
    net.IW{1,1} = rand(size(net.IW{1,1}))*0.1;net.b{1} = rand(size(net.b{1}))*0.1;
    net.LW{2,1} = rand(size(net.LW{2,1}))*0.1;net.b{2} = rand(size(net.b{2}))*0.1;
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 75/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    % Train the Network
    [net,tr] = train(net,trainVectors,trainLabels);

    output = sim(net,tests);
end

