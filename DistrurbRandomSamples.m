function [newLabels ,newTargets] = DistrurbRandomSamples(labels, targets, count, sigma )
    
    newLabels = zeros(size(labels,1),count);
    newTargets = zeros(size(targets,1),count);
    
    for i = 1:count
        index             = randi(size(labels,2));
        label             = min(max(labels(:,index) + randn(size(labels(:,index)))*sigma,0),255);
        newLabels(:,i)    = label;
        newTargets(:,i)   = targets(:,index);
    end
end