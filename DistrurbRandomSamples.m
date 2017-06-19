function [newLabels ,newTargets] = DistrurbRandomSamples(labels, targets, percentage, sigma )
    
    labelsSize = size(labels);
    total = labelsSize(end);
    count = floor(total*percentage);
    labelsSize(end) = count;
    
    targetsSize = size(targets);
    targetsSize(end) = count;
    
    newLabels = zeros(labelsSize);
    newTargets = zeros(targetsSize);
    
    for i = 1:count
        index             = randi(total);
        label             = min(max(labels(:,index) + randn(size(labels(:,index)))*sigma,0),255);
        newLabels(:,i)    = label;
        newTargets(:,i)   = targets(:,index);
    end
end