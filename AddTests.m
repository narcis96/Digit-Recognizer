function [newLabels, newTargets ] = AddTests(testDataFile, newTestsFile, targetCount)
    tests = csvread(testDataFile, 1, 0);
    tests = tests';
    
    newtests = csvread(newTestsFile, 1, 0);
    n = size(newtests,1);
    
    newLabels = zeros(size(tests,1),n);
    newTargets = zeros(targetCount,n);
    
    for i = 1:n
        index = newtests(i,1);
        label = newtests(i,2); 
        newlabel = zeros(targetCount,1);
        newlabel(label) = 1;
        
        newLabels(i) = tests(:,index);
        newTargets(i) = newlabel; 
    end
end

