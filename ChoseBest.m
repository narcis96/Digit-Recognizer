function [arhitecture, perf] = ChoseBest(trainVectors, trainLabels, arhitectures, minP, maxP, minLayers, maxLayers, partitions)
    assert(minp < maxP);
    assert(minLayers < maxLayers);
    
    arhitecture = [];
    perf = 1;
    for i = 1:arhitectures
         hiddenLayers = sort(minP + randi((maxP-minP), 1, minLayers + randi(maxLayers-minLayers)),'descend');
         disp(hiddenLayers);        
         
         performance = KFoldCrossValidation(trainVectors, trainLabels, hiddenLayers ,partitions);
         disp(performance);
         
         if performance < perf
            perf = performance;
            arhitecture = hiddenLayers;
         end
    end

end

