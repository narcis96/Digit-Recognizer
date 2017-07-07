trainFile       = './trainSet/train.csv';
testFile        = './testSet/test.csv';
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
percentage = 80/100;
[newTrainVectors, newTrainLabels] = AddTests(testFile, newTestsFile, classes, percentage); %1...max
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];

disp(size(trainVectors));
disp(size(trainLabels));

percentage = 25/100;
sigma = 0.3;
minValue = 0;
maxValue = 255;
[newTrainVectors, newTrainLabels] = DistrurbRandomSamples(trainVectors, trainLabels, percentage, sigma, minValue, maxValue);
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];

[trainVectors,trainLabels] = ShuffleTrainData(trainVectors, trainLabels);

disp(size(trainVectors));
disp(size(trainLabels));

%read tests
tests = csvread(testFile, 1, 0);
tests = tests';
disp(size(tests));

arhitectures = 4;
partitions = 3;
minPerceptrons = 35;
maxPerceptrons = 50;
minLayers = 3;
maxLayers = 5;
[arhitecture,performance] = ChoseBest(trainVectors, trainLabels, arhitectures, minPerceptrons, maxPerceptrons, minLayers, maxLayers, partitions);
net = Train(trainVectors, trainLabels, arhitecture);

%K = 10;
%output2 = KNearestNeighbor(trainVectors',tests', K);
%value = 0.5;
%output2 = sim(net,tests);
%output2 = output2 > value;

%write
nrTests = size(tests,2);
[~, answers] = max(sim(net,tests));


final = zeros(nrTests,2);
final(:,1) = 1:nrTests;
final(:,2) = answers;

writetable(table([1:nrTests]', answers'), outputFile);
writetable(table([1:nrTests]', answers'), strcat('./tests/',outputFile));
