    % Define the path to the folder containing said images
    % folderPath = 'NewGestureData\thumbsup';
    folderPath= 'MoreAugmentedImages\thumbsup';
    % List all image files in the folder
    imageFiles = dir(fullfile(folderPath, '*.png'));
    
    % Loop through each image file
    for i = 1:length(imageFiles)
        % Read the image
        img = imread(fullfile(folderPath, imageFiles(i).name));
        
        % Perform geometric transforms (e.g., scaling)
        scaleFactor = rand(1) * (2.0 - 0.5) + 0.5; % Random scaling factor between 0.5 and 2.0
        scaledImg = imresize(img, scaleFactor); % Scale by a random factor
        
        % Perform flipping (e.g., horizontal flip)
        if randi(2) == 1
            flippedImg = flip(img, 2); % Horizontal flip
        else
            flippedImg = img; % No flip
        end
        
        % Perform rotating
        rotationAngle = randi([-50, 50]); % Random angle between -50 and 50 degrees
        rotatedImg = imrotate(img, rotationAngle); % Rotate by a random angle
        
        % Inject more noise (e.g., Gaussian noise)
        noiseMean = 0; % Mean of Gaussian noise
        noiseVariance = rand(1) * (0.05 - 0.01) + 0.01; % Random variance between 0.01 and 0.05
        noisyImg = imnoise(img, 'gaussian', noiseMean, noiseVariance); % Add Gaussian noise

        % Save augmented images to the same folder
        imwrite(scaledImg, fullfile(folderPath, ['scaled_' imageFiles(i).name]));
        imwrite(flippedImg, fullfile(folderPath, ['flipped_' imageFiles(i).name]));
        imwrite(rotatedImg, fullfile(folderPath, ['rotated_' imageFiles(i).name]));
        imwrite(noisyImg, fullfile(folderPath, ['noisy_' imageFiles(i).name]));
    end


