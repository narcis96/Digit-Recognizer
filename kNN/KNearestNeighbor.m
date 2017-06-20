function [answers] = KNearestNeighbor (trainVectors, trainLabels, K)    
    [neighbors,distances ] = knnsearch(trainVectors, trainLabels,'k', K, 'distance', 'mahalanobis');
    answers = neighbors(:,1);
end

