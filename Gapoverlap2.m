%
% EyeTrackingSample
%

clc 
clear all
close all

addpath('functions');
addpath('../tetio');  

% *************************************************************************
%
% Initialization and connection to the Tobii Eye-tracker
%
% *************************************************************************
 
disp('Initializing tetio...');
tetio_init();

% Set to tracker ID to the product ID of the tracker you want to connect to.
trackerId = 'TX300-010106616201';

%   FUNCTION "SEARCH FOR TRACKERS" IF NOTSET
if (strcmp(trackerId, 'NOTSET'))
	warning('tetio_matlab:EyeTracking', 'Variable trackerId has not been set.'); 
	disp('Browsing for trackers...');

	trackerinfo = tetio_getTrackers();
	for i = 1:size(trackerinfo,2)
		disp(trackerinfo(i).ProductId);
	end

	tetio_cleanUp();
	error('Error: the variable trackerId has not been set. Edit the EyeTrackingSample.m script and replace "NOTSET" with your tracker id (should be in the list above) before running this script again.');
end

fprintf('Connecting to tracker "%s"...\n', trackerId);
tetio_connectTracker(trackerId)
	
currentFrameRate = tetio_getFrameRate;
fprintf('Frame rate: %d Hz.\n', currentFrameRate);

% *************************************************************************
%
% Calibration of a participant
%
% *************************************************************************

SetCalibParams; 

disp('Starting TrackStatus');
% Display the track status window showing the participant's eyes (to position the participant).
TrackStatus; % Track status window will stay open until user key press.
disp('TrackStatus stopped');

disp('Starting Calibration workflow');
% Perform calibration
HandleCalibWorkflow(Calib);
disp('Calibration workflow stopped');

% *************************************************************************
%
% Display Gap-overlap experiment
%
% *************************************************************************
close all;

KbName('UnifyKeyNames');
    
fastrak('initAll')
subinfo=getSubInfo;
if isempty(subinfo)
    return;
end
try
    
    [wptr, wrect]=Screen('OpenWindow', 1, 255, [ ]);
    [trials, images]=initializeConditions(wptr, 18.75, 525, 20, 10);
    [leftEyeAll, rightEyeAll, timeStampAll, trialInfoAll, eventMarkerAll,  fastrak_start, fastrak_stop, handtimestampAll, handDataAll]=repTrials_Run(wptr, trials, images, 10);
    
    csvwrite(['Sub' char(subinfo(1)) '.gazedataleft.csv'], leftEyeAll); % % Save gaze data vectors to file
    csvwrite(['Sub' char(subinfo(1)) '.gazedataright.csv'], rightEyeAll);  % % Save gaze data vectors to file
    %fileID1=fopen(['Sub' char(subinfo(1)) '.timestamp.txt'], 'w');
    %fprintf(fileID1, '%16u\r\n', timeStampAll); % Save remote time stamp to file
    %fclose(fileID1);
    % dlmwrite('timestamp.csv', timeStampAll, 'precision', '%17u'); 
    fileID2=fopen(['Sub' char(subinfo(1)) '.trialInfo.txt'], 'w');
    fprintf(fileID2, '%10s %10s %10s %10s %20s %20s %20s %20s %20s %20s\r\n', 'trialNo.', 'Index', 'attribute', 'direction', 'fixtime', 'centraltime', 'cuetime', 'gaptime', 'targettime', 'endtime');
    fprintf(fileID2, '%10d %10d %10d %10d %20d %20d %20d %20d %20d %20d\r\n', trialInfoAll'); % Save stimulus event time stamp to file
    fclose(fileID2);
    %fileID3=fopen(['Sub' char(subinfo(1)) '.localtimestamp.txt'], 'w');
    %fprintf(fileID3, '%16u\r\n', localtimeStampAll); % Save converted local time stamp to file
    %fclose(fileID3);
    fileID4=fopen(['Sub' char(subinfo(1)) '.subjectInfo.txt'], 'w');
    fprintf(fileID4, '%5s %5s %5s %10s %5s\r\n', 'subNo.', 'gender', 'GMFCS', 'birth', 'hand');
    fprintf(fileID4, '%5s %5s %5s %10s %5s\r\n', char(subinfo(1)), char(subinfo(2)), char(subinfo(3)), char(subinfo(4)), char(subinfo(5)));
    fclose(fileID4);
    % dlmwrite('localtimestamp.csv', localtimeStampAll); 
    disp('Program finished.');
    sca;
catch
    psychrethrow(psychlasterror);
    sca;
end
return;