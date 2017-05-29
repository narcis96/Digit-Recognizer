function [output, net] = Train(trainVectors, trainLabels, tests)
    hiddenLayerSize = 50;
    net = patternnet([hiddenLayerSize  hiddenLayerSize hiddenLayerSize hiddenLayerSize hiddenLayerSize]);

    % Set up Division of Data for Training, Validation, Testing
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 10/100;
    net.divideParam.testRatio = 10/100;


    % Train the Network
    [net,tr] = train(net,trainVectors,trainLabels);

    output = sim(net,tests);
end

