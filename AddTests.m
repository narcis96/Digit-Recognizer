function [newLabels, newTargets ] = AddTests(testDataFile, newTestsFile, targetCount, percentage)
    assert(0 < percentage && percentage <= 1);
    tests = csvread(testDataFile, 1, 0);
    tests = tests';
    
    newtests = csvread(newTestsFile, 1, 0);
    n = floor(size(newtests,1) * percentage);
    
    newLabels = tests(:,newtests(1:n,1));
    newTargets = full(ind2vec(newtests(1:n,2)' + 1)); %in this problem, labels is between 0,9
    newTargets = [newTargets; zeros(targetCount - size(newTargets,1), size(newTargets,2))];%add zeros 
end

