function [perf] = KFoldCrossValidation(trainVectors, trainLabels, hiddenLayers, partitions)
    perf = 0;
    best = 1;

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
        
        disp(size(currentTrainVectors));
        disp(size(currentTestVectors));
        
        currentNet = Train(currentTrainVectors, currentTrainLabels, hiddenLayers);  
         
        result = sim(currentNet,currentTestVectors);
        currentPerformance = mean(mean(abs(currentTestLabels-result)));
        if currentPerformance < best
            best = currentPerformance;
        end
        perf = perf + currentPerformance;
         
    end
    
    perf = perf/partitions;
end

