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
percentage = 85/100;
[newTrainVectors, newTrainLabels] = AddTests(testFile, newTestsFile, classes, percentage); %1...max
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];
disp(size(trainVectors));
disp(size(trainLabels));


percentage = 25/100;
sigma = 0.3;
[newTrainVectors, newTrainLabels] = DistrurbRandomSamples(trainVectors, trainLabels, percentage, sigma);
trainVectors = [trainVectors newTrainVectors];
trainLabels = [trainLabels newTrainLabels];

disp(size(trainVectors));
disp(size(trainLabels));

%read tests
tests = csvread(testFile, 1, 0);
tests = tests';
disp(size(tests));

arhitectures = 3;
partitions = 3;
minPerceptrons = 50;
maxPerceptrons = 150;
minLayers = 3;
maxLayers = 5;
[arhitecture,performance] = ChoseBest(trainVectors, trainLabels, arhitectures, minPerceptrons, maxPerceptrons, minLayers, maxLayers, partitions);
net = Train(trainVectors, trainLabels, arhitecture);

value = 0.5;
output1 = sim(net,tests);
output1 = output1 > value;


value = 0.5;
output2 = sim(net,tests);
output2 = output2 > value;

%x = [1;2;3];
%y = [1 2 3]; 
%gene_weights = @(x) round(rand(size(x)));
%gene_weights = [1 2 3];
%knn = ClassificationKNN.fit(x, y, 'DistanceWeight', gene_weights);
%Mdl = fitcknn(x,y,'NumNeighbors',5,'Standardize',2);

%write
nrTests = size(tests,2);
answers = vec2ind(output1) - 1;

final = zeros(nrTests,2);
final(:,1) = 1:size(final,1);
final(:,2) = answers;

csvwrite(outputFile,final);
csvwrite(strcat('./tests/',outputFile),final);