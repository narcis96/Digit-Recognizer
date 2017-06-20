function [trainVectors, trainLabels] = ShuffleTrainData(trainVectors,trainLabels)
    sizeTrainData = size(trainVectors);
    samples = sizeTrainData(end);
    permutation = randperm(samples);
    trainVectors = trainVectors(:,permutation);
    trainLabels = trainLabels(:,permutation);
end

