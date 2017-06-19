function [arhitecture, perf] = ChoseBest(trainVectors, trainLabels, arhitectures, minP, maxP, minLayers, maxLayers, partitions)
    arhitecture = [];
    perf = 1;
    for i = 1:arhitectures
         hiddenLayers = sort(minP + randi(maxP, 1, minLayers + randi(maxLayers-minLayers)),'descend');
         disp(hiddenLayers);        
         
         currentPerformance = TestPerformance(trainVectors, trainLabels, hiddenLayers ,partitions);
         disp(currentPerformance);
         
         if currentPerformance < perf
            perf = currentPerformance;
            arhitecture = hiddenLayers;
         end
    end

end

