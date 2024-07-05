    alex = alexnet;
    layers = alex.Layers;
    layers(23) = fullyConnectedLayer(7);
    layers(25) = classificationLayer;
    
    % Specify the target size for resizing
    targetSize = [227, 227];  % Adjust the size as needed
    
    allimages=imageDatastore('Augmented_HandImages\','IncludeSubfolders', true, 'LabelSource', 'foldernames');
    
    % Resize images to the specified target size
    allimages.ReadFcn = @(filename)imresize(imread(filename), targetSize);

[train, test] = splitEachLabel(allimages, 0.8, 'randomized');

% 
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 20, 'MiniBatchSize', 64);
NewNet3 = trainNetwork(train, layers, opts);

% Measuring accuracy
predictedLabels = classify(NewNet3, test);
accuracy = mean(predictedLabels == test.Labels);
% Display accuracy
disp(['Accuracy: ', num2str(accuracy * 100), '%']);

% Compute confusion matrix
C = confusionmat(test.Labels, predictedLabels);

% Display or plot confusion matrix
figure;
confusionchart(C, categories(test.Labels));
