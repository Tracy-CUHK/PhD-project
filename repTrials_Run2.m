function [leftEyeAll, rightEyeAll,timeStampAll, localtimeStampAll, trialInfoAll, pno_data]=repTrials_Run2(wptr, trials)
%repTrial_Run2.m

tetio_startTracking; % Start tracking! Not sure if I put this in the right place?
di_stream = fst_startTracking('127.0.0.1', 7234);
WaitSecs(1.0);
leftEyeAll = [];
rightEyeAll = [];
timeStampAll = [];
localtimeStampAll = [];
trialInfoAll = [];

while true
    
for i=1:6  % Just present 6 trials for demo
    pno_data = HandData(di_stream);
    index=randi(length(trials)); 
    [fixtime, centraltime, cuetime, gaptime, targettime, endtime]=oneTrial2(wptr, trials(index, 1), 2.0); % callback function for each trial
    trialInfo = horzcat(i, index, trials(index, 1).Attribute, trials(index, 1).Direction, fixtime, centraltime, cuetime, gaptime, targettime, endtime);
    trialInfoAll = vertcat(trialInfoAll, trialInfo(1, :));
end
tetio_stopTracking;  % Stop eyetracking.. 
[lefteye, righteye, timestamp] = tetio_readGazeData;
numGazeData = size(lefteye, 2);
leftEyeAll = vertcat(leftEyeAll, lefteye(:, 1:numGazeData));
rightEyeAll = vertcat(rightEyeAll, righteye(:, 1:numGazeData));
timeStampAll = vertcat(timeStampAll, timestamp(:,1));

for n=1:size(timeStampAll, 1)
    templocaltimeStamp = tetio_remoteToLocalTime(int64(timeStampAll(n))); % convert to local time stamp
    localtimeStampAll = vertcat(localtimeStampAll, templocaltimeStamp);
end
% localDiff = double(localtimeStampAll(1)) - double(stimEventStampAll(1)); % test the clock offset
tetio_disconnectTracker; 
tetio_cleanUp;
justSaySomething(wptr, 'Press any key to continue...', 0);
WaitSecs(1.0);
return