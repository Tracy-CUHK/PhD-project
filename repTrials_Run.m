function [leftEyeAll, rightEyeAll, timeStampAll, trialInfoAll, eventMarkerAll, fastrak_start, fastrak_stop, handtimestampAll, handDataAll]=repTrials_Run(wptr, trials, images, trialperblock)
%repTrial_Run.m

fastrak('start');
tetio_startTracking; % Start tracking! Not sure if I put this in the right place?
WaitSecs(1.0);

leftEyeAll = [];
rightEyeAll = [];
timeStampAll = [];
trialInfoAll = [];
eventMarkerAll = [];
handtimestampAll = [];
handDataAll = [];

[y, Fs] = beep_gen;
for i=1:5  % Just present 6 trials for demo
    index=randi(length(trials)); 
%     index = i;
    [sx,sy,sz,num] = size(images);
    imgArray = images(:,:,:,randi(num));
    
    % reset trackers data
    % tetio_readGazeData;
    % fastrak('reset');
    
    oneTrial2(wptr, trials(index, 1), 8.0, y, Fs, imgArray); % callback function for each trial
    
end

justSaySomething2(wptr, 'Please press any key to start the experiment.', 1, [255 0 0]);
WaitSecs(0.5);

for i = 1:length(trials)
    WaitSecs(0.5);
    
    [sx,sy,sz,num] = size(images);
    imgArray = images(:,:,:,randi(num));
    
    % reset trackers data
    tetio_readGazeData;
    fastrak('reset');
    
    [fixtime, centraltime, cuetime, gaptime, targettime, endtime, timeDiff]=oneTrial2(wptr, trials(i,1), 8.0, y, Fs, imgArray); % callback function for each trial
    
    % get tetio(eye tracker data) 
    [lefteye, righteye, timestamp, trigSignal] = tetio_readGazeData;
    num=size(lefteye,1);
    numGazeData=size(lefteye,2);
    tempmatrice=ones(num,1)*i;
    lefteye_temp=horzcat(tempmatrice, lefteye);
    righteye_temp=horzcat(tempmatrice, righteye);
    timestamp_temp1=int64(timestamp) - timeDiff;
    timestamp_temp2=horzcat(tempmatrice, timestamp_temp1);
    trigSignal_temp=horzcat(tempmatrice, trigSignal);
    
    trialInfo = horzcat(i, trials(i, 1).Attribute, trials(i, 1).Direction, fixtime, centraltime, cuetime, gaptime, targettime, endtime);
    trialInfoAll = vertcat(trialInfoAll, trialInfo(1, :));
    
    leftEyeAll = vertcat(leftEyeAll, lefteye_temp(:, 1:(numGazeData+1)));
    rightEyeAll = vertcat(rightEyeAll, righteye_temp(:, 1:(numGazeData+1)));
    timeStampAll = vertcat(timeStampAll, timestamp_temp2(:,1:2));
    eventMarkerAll = vertcat(eventMarkerAll, trigSignal_temp(:,1:2));
    
    % get fastrak (finger data)
    %------ add  on 20170419 -------%
    [fastrak_start, fastrak_stop, handmotion_origin] = fastrak('getData');
    %fastrak('reset');
    numHandPara=size(handmotion_origin, 1);
    numHandData=size(handmotion_origin, 2);
    handmatrice=ones(numHandPara,1)*i;
    handtimestamp_temp1 = int64(handmotion_origin(:,7));
    handtimestamp_temp2 = horzcat(handmatrice, handtimestamp_temp1);
    handtimestampAll = vertcat(handtimestampAll, handtimestamp_temp2(:, 1:2));
    
    handmotion_temp1=horzcat(handmatrice, handmotion_origin(:, 1:(numHandData-1)));
    handDataAll = vertcat(handDataAll, handmotion_temp1(:, 1:numHandData));
    %------ add  on 20170419 -------%
    
    if mod(i, trialperblock) == 0 && i < length(trials)
        tips=['Part_' num2str(floor(i/trialperblock)) '/' ...
            num2str(ceil(length(trials)/trialperblock)) ...
            ' finished. \n\n Please take a break. \n\n Any key to continue!'];
        justSaySomething2(wptr, tips, 1, [255 0 0]);
    end
    
end
    
    
% [fastrak_start, fastrak_stop, handmotion] = fastrak('getData');
fastrak('stop');
tetio_stopTracking;  % Stop eyetracking.. 
%[lefteye, righteye, timestamp, trigSignal] = tetio_readGazeData;
%numGazeData = size(lefteye, 2);
%leftEyeAll = vertcat(leftEyeAll, lefteye(:, 1:numGazeData));
%rightEyeAll = vertcat(rightEyeAll, righteye(:, 1:numGazeData));
%timeStampAll = vertcat(timeStampAll, timestamp(:,1));
%eventMarkerAll = vertcat(eventMarkerAll, trigSignal(:,1));
%timeStampAll = int64(timeStampAll) - timeDiff;
% handtimestampAll= int64(handmotion(:,7));

tetio_disconnectTracker;
tetio_cleanUp;
justSaySomething(wptr, 'You finish this session', 0);
WaitSecs(1.0);
return