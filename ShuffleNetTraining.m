%% import network
load lgraph_1.mat
%% import data
ds = imageDatastore("HandImages",IncludeSubfolders=true,LabelSource="foldernames");
%% augmentation
augmenter=imageDataAugmenter("RandXReflection",1,"RandRotation",[-20 20]);
%% separate data
[train,test]=splitEachLabel(ds,0.9,"randomized");
resized_train = augmentedImageDatastore([224 224],train,"DataAugmentation",augmenter);
% resized_test = augmentedImageDatastore([224 224],test);
%% create teaching options
opts=trainingOptions("sgdm");
%% train network
zakNet9=trainNetwork(resized_train,lgraph_1,opts);
%% upload net
save('zakNet9.mat','zakNet9');
%%
save('zaknetTestData.mat',"test")