function [output, net] = Train1(trainVectors, trainLabels, hiddenLayers, tests)
    lastLayer = size(trainLabels, 1);    
    hiddenLayers = [hiddenLayers lastLayer];
    net = newff(minmax(trainVectors),hiddenLayers ,{'logsig', 'logsig', 'tansig','logsig'},'trainscg'); 
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

