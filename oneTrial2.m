function [fixtime, centraltime, cuetime, gaptime, targettime, endtime, timeDiff]=oneTrial2(wptr, trial, time, y, Fs)
% oneTrial2.m

Screen('CopyWindow', trial.fixptr, wptr, [], trial.nstrect); % Show fixation cross on the center of screen
fixtime=tetio_localTimeNow(); % Get local SDK time using tetio functions
Screen('Flip', wptr); % Flip
WaitSecs(0.5); % last for 0.5 s
Screen('CopyWindow', trial.centralStimPtr, wptr, [], trial.dstrect); % Show the central circle stimulus
centraltime=tetio_localTimeNow(); % Get local SDK time using tetio functions
Screen('Flip', wptr);
WaitSecs(0.45); % last for 0.45 s
Screen('CopyWindow', trial.cuePtr, wptr, [], trial.dstrect); % Show the central circle stimulus together with beeper cue
cuetime=tetio_localTimeNow(); % Get local SDK time using tetio functions
Screen('Flip', wptr);
if ~isnan(trial.sound)
    sound(y, Fs);
    %Beeper(500, 1, 0.05);
end
WaitSecs(0.05); % last for 0.05s
Screen('CopyWindow', trial.gapPtr, wptr, [], trial.dstrect); % Show the "Gap" or "Overlap" interval
gaptime=tetio_localTimeNow();
Screen('Flip', wptr);
WaitSecs(0.2); % last for 0.2s
Screen('CopyWindow', trial.stimPtr, wptr, [], trial.stimtrect); % Show the target on right or left side
imgArray = imread('target.jpg');
texid = Screen('MakeTexture', wptr, imgArray);
Screen('DrawTexture', wptr, texid, [], trial.stimtrect);
targettime=tetio_localTimeNow();
remotetio = tetio_localToRemoteTime(int64(targettime));
pctime = fastrak('now');
timeDiff = int64(remotetio - pctime);
Screen('Flip', wptr);
WaitSecs(time); % last for 2s here
endtime=tetio_localTimeNow();
Screen('Flip', wptr); 
WaitSecs(0.8);
return
