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


disp(size(trainVectors));
disp(size(trainLabels));

%read tests
tests = csvread(testFile, 1, 0);
tests = tests';
disp(size(tests));

arhitectures = 5;
nrTests = 3;
[net2,performance2] = ChoseBest(trainVectors, trainLabels, arhitectures, nrTests);
[net,performance] = ChoseBest(trainVectors, trainLabels, arhitectures, nrTests);

value = 0.5;
output1 = sim(net,tests);
output1 = output1 > value;

nrTests = size(tests,2);
answers = vec2ind(output1) - 1;

%gene_weights = @(x) round(rand(size(x)));
%ClassificationKNN.fit(x, y, 'DistanceWeight', gene_weights);


%write
final = zeros(nrTests,2);
final(:,1) = 1:size(final,1);
final(:,2) = answers;

csvwrite(outputFile,final);
csvwrite('.\tests\submission.csv',final);