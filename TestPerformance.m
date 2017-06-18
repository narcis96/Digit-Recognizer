function [ net, perf] = TestPerformance(trainVectors, trainLabels, hiddenLayers, nrTest)
    net = [];
    perf = 0;
    best = 1;
    count = 10000;
    sigma = 0.3;
        
    for i = 1:nrTest
        [currentNet, ~] = Train(trainVectors, trainLabels, hiddenLayers);        
        
        [testVectors, testLabels] = DistrurbRandomSamples(trainVectors, trainLabels, count, sigma);
        result = sim(currentNet,testVectors);
        currentPerformance = mean(abs(testLabels-result));
        if currentPerformance < best
            best = currentPerformance;
            net = currentNet;
        end
        perf = perf + currentPerformance;
        
        
        
    end
    perf = perf/nrTest;
end

