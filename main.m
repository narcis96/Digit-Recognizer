trainFile       = 'train.csv';
testFile        = 'test.csv';
newTestsFile    = 'newtests.csv';
outputFile      = 'submission.csv';

%read
originalLabels = csvread(trainFile, 1, 1);
originalLabels = originalLabels';

originalTargets = csvread(trainFile, 1, 0, [1 0 size(originalLabels,2) 0]);
originalTargets = originalTargets';

trainVectors = originalLabels;
classes = max(originalTargets) - min(originalTargets) + 1;
trainLabels = full(ind2vec(originalTargets + 1));

disp(size(trainVectors));
disp(size(trainLabels));


%add samples for train

[newTrainVectors, newTrainLabels] = AddTests(testFile, newTestsFile, classes); %1...max
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];

count = 10000;
sigma = 0.2;
[newTrainVectors, newTrainLabels] = DistrurbRandomSamples(trainVectors, trainLabels, count, sigma);
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];
disp(size(trainVectors));
disp(size(trainLabels));

%read tests
tests = csvread(testFile, 1, 0);
tests = tests';
disp(size(tests));
[output1,net1] = Train(trainVectors, trainLabels, tests);
[output2,net2] = Train(trainVectors, trainLabels, tests);
[output3,net3] = Train(trainVectors, trainLabels, tests);
[output4,net4] = Train(trainVectors, trainLabels, tests);
[output5,net5] = Train(trainVectors, trainLabels, tests);
[output6,net6] = Train(trainVectors, trainLabels, tests);
value = 0.5;
nrTests = size(tests,2);

output1 = output1 > value;
output2 = output2 > value;
output3 = output3 > value;
output4 = output4 > value;
output5 = output5 > value;
output6 = output6 > value;

%left = 100;
%right = 110;
%disp(output1(:,[left:right]));
%disp(output2(:,[left:right]));

answers = zeros(nrTests,1);
for i = 1:nrTests
    curent = output1(:,i);
    curent = curent + output4(:,i);
    curent = curent + output3(:,i);
    curent = curent + output5(:,i);
    curent = curent + output6(:,i);
    [val, idx] = max(curent);
    if val > 0
        answers(i,1) = idx(1) - 1;
    else
        curent = output1(:,i);
        [val, idx] = max(curent);
        answers(i,1) = idx(1) - 1;
    end
end
%disp(answers([1:15])); 



%write
final = zeros(nrTests,2);
final(:,2) = answers;
final(:,1) = 1:size(final,1);

csvwrite(outputFile,final);
csvwrite('.\tests\submission.csv',final);