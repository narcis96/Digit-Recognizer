function [newLabels, newTargets ] = AddTests(testDataFile, newTestsFile, targetCount, percentage)
    tests = csvread(testDataFile, 1, 0);
    tests = tests';
    
    newtests = csvread(newTestsFile, 1, 0);
    n = size(newtests,1);
    
    newLabels = zeros(size(tests,1),n);
    newTargets = zeros(targetCount,n);

    
    n = floor(n * percentage);
    
    for i = 1:n
        index = newtests(i,1);
        target = newtests(i,2); 
        
        newLabels(:,i) = tests(:,index);
        newTargets(target + 1,i) = 1; 
    end
end

