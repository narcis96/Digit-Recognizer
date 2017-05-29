%{
fid = fopen('train-images.idx3-ubyte','r');
A = fread(fid);
disp(size(A));

fid = fopen('train-labels.idx1-ubyte','r');
A = fread(fid);
disp(size(A));
%}

trainFile       = 'train.csv';
testFile        = 'test.csv';
newTestsFile    = 'newtests.csv';

%read
originalLabels = csvread(trainFile, 1, 1);
originalLabels = originalLabels';

originalTargets = csvread(trainFile, 1, 0, [1 0 size(originalLabels,2) 0]);
originalTargets = originalTargets';

trainVectors = originalLabels;
classes = max(originalTargets) - min(originalTargets) + 1;
trainLabels = zeros(classes,size(originalTargets,2)); %1...max
for i = 1:size(originalTargets,2)
    trainLabels(originalTargets(i) + 1,i) = 1;
end

disp(size(trainVectors));
disp(size(trainLabels));
disp(originalTargets([1:15]));
disp(trainLabels(:,[1:15]));


%add samples for train
count = 1000;
sigma = 0.15;
[newTrainVectors, newTrainLabels] = AddTests(testFile, newTestsFile, classes); %1...max
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];

[newTrainVectors, newTrainLabels] = DistrurbRandomSamples(trainVectors, trainLabels, count, sigma);

%read tests
tests = csvread(testFile, 1, 0);
tests = tests';
disp(size(tests));
[output1,net1] = Train(trainVectors, trainLabels, tests);
[output2,net2] = Train(trainVectors, trainLabels, tests);
[output3,net3] = Train(trainVectors, trainLabels, tests);
[output4,net4] = Train(trainVectors, trainLabels, tests);
value = 0.5;
nrTests = size(tests,2);

output1 = output1 > value;
output2 = output2 > value;
output3 = output3 > value;
output4 = output4 > value;

answers = zeros(nrTests,1);
for i = 1:nrTests
    curent = output1(:,i);
    curent = curent + output2(:,i);
    curent = curent + output3(:,i);
    [val, idx] = max(curent);
    if val > 0
        answers(i,1) = idx(1) - 1;
    else
        curent = output4(:,i);
        [val, idx] = max(curent);
        answers(i,1) = idx(1) - 1;
    end
end
%disp(answers([1:15])); 



%write
final = zeros(nrTests,2);
final(:,2) = answers;
final(:,1) = 1:size(final,1);

csvwrite('submission.csv',final);
csvwrite('.\tests\submission.csv',final);