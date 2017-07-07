function [perf] = KFoldCrossValidation(trainVectors, trainLabels, hiddenLayers, partitions)
    perf = 0;
    
    sz = size(trainVectors);
    total = sz(end);
    
    group = cvpartition(total,'kfold',partitions);
    for i = 1:partitions
        testIndx = find(test(group,i))';
        trainIndx = find(~test(group,i))';
        
        currentTrainVectors = trainVectors(:,trainIndx);
        currentTestVectors = trainVectors(:,testIndx);
        
        currentTrainLabels = trainLabels(:,trainIndx); 
        currentTestLabels = trainLabels(:,testIndx);
        currentTestLabels = vec2ind(currentTestLabels);
        
        disp(size(currentTrainVectors));
        disp(size(currentTestVectors));
        
        currentNet = Train(currentTrainVectors, currentTrainLabels, hiddenLayers);  
         
        result = sim(currentNet,currentTestVectors);
        [~,result] = max(result);
        currentPerformance = sum(result == currentTestLabels) /length(currentTestLabels);
        perf = perf + currentPerformance;
         
    end
    
    perf = perf/partitions;
end

