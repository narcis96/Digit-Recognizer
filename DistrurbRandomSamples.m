function [newLabels ,newTargets] = DistrurbRandomSamples(labels, targets, count, sigma )
    Value = 500000000;
    
    newLabels = zeros(size(labels,1),count);
    newTargets = zeros(size(targets,1),count);
    
    for i = 1:count
        index           = 1 + mod(randi(Value),size(labels,2));
        label           = labels(:,index) + max(min(randn(size(labels(:,index)))*sigma,sigma),-sigma);
        newLabels(:,i)    = label;
        newTargets(:,i)   = targets(:,index);
    end
end