function [arhitecture, perf] = ChoseBest(trainVectors, trainLabels, arhitectures, minP, maxP, minLayers, maxLayers, partitions)
    assert(minP < maxP);
    assert(minLayers < maxLayers);
    
    arhitecture = [];
    perf = 0;
    scores = []; 
    layers = []; 
    for i = 1:arhitectures
         hiddenLayers = sort(minP + randi((maxP-minP), 1, minLayers + randi(maxLayers-minLayers)),'descend');
         disp(hiddenLayers);        
         
         performance = KFoldCrossValidation(trainVectors, trainLabels, hiddenLayers ,partitions);
         disp(performance);
         scores = [scores performance];
         layers = [layers sum(hiddenLayers)];
         if performance > perf
            perf = performance;
            arhitecture = hiddenLayers;
         end
         figure;
         plot(layers, scores, '.-');
         xlabel('number of hidden neurons');
         ylabel('categorization accuracy');
         title('Number of hidden neurons vs. accuracy');
    end
end

