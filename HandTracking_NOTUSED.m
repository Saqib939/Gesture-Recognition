

clc
close all;
clear all

cam = webcam;
figure;
hold on

while ishandle(1)  % Continue the loop until the figure is closed
    frame = cam.snapshot;   
    newframe = HS3fun(frame);

    blobAnalysis = vision.BlobAnalysis('MinimumBlobArea', 5000, 'MaximumBlobArea', 500000);
    [area, centroid, bbox] = blobAnalysis(newframe);
    
    % Filter blobs based on area and keep only the largest one
    [~, maxIdx] = max(area);
    maxBbox = bbox(maxIdx, :);

    label = 'hand';
    imnew = insertObjectAnnotation(frame, 'rectangle', maxBbox, num2str(label), 'LineWidth', 3, 'FontSize', 24);
    imshow(imnew);

    pause(0.1);  % Adjust the pause duration as needed
end

clear cam;  % Release the webcam when the loop is terminated
