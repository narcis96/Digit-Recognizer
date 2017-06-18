function [net, perf] = ChoseBest(trainVectors, trainLabels, arhitectures,nrTests)
    net = [];
    perf = 1;
    for i = 1:arhitectures
         hiddenLayers = sort(50 + randi(150, 1, 2 + randi(3)),'descend');
         disp(hiddenLayers);         
         [currentNet, currentPerformance] = TestPerformance(trainVectors, trainLabels, hiddenLayers ,nrTests);
         disp(currentPerformance);
         
         if currentPerformance < perf
            perf = currentPerformance;
            net = currentNet;
         end
    end

end

