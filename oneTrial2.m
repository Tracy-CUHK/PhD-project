function [fixtime, centraltime, cuetime, gaptime, targettime, endtime, timeDiff]=oneTrial2(wptr, trial, time, y, Fs, imgArray)
% oneTrial2.m

Screen('CopyWindow', trial.fixptr, wptr, [], trial.nstrect); % Show fixation cross on the center of screen
fixtime=tetio_localTimeNow(); % Get local SDK time using tetio functions
Screen('Flip', wptr); % Flip
WaitSecs(0.5); % last for 0.5 s
Screen('CopyWindow', trial.centralStimPtr, wptr, [], trial.dstrect); % Show the central circle stimulus
centraltime=tetio_localTimeNow(); % Get local SDK time using tetio functions
Screen('Flip', wptr);
WaitSecs(0.45); % last for 0.45 s

% phrase sound, beep sound and show target 50ms
Screen('CopyWindow', trial.cuePtr, wptr, [], trial.dstrect); % Show the central circle stimulus together with beeper cue
Screen('Flip', wptr);
beginTime = fastrak('now'); % Get local SDK time using tetio functions
player = audioplayer(y, Fs);
play(player);
WaitSecsFromBegin(beginTime, 0.05);
gaptime=fastrak('now');

% phrase gap
beginTime = fastrak('now'); 
Screen('CopyWindow', trial.gapPtr, wptr, [], trial.dstrect); % Show the "Gap" or "Overlap" interval
Screen('Flip', wptr);
WaitSecs(0.2); % last for 0.2s
endTime = fastrak('now'); 

% phrase target
beginTime=fastrak('now'); % Get local SDK time using tetio functions
cuetime = beginTime;
if trial.Attribute == 2
    wrect=Screen('Rect', wptr);
    Screen('FillOval', wptr, [0, 0, 0], CenterRect([0, 0, 2 * trial.radius, 2 * trial.radius], wrect));
end
Screen('FillRect', wptr, [0, 0, 0], [1830, 1000, 1850, 1020]);
texid = Screen('MakeTexture', wptr, imgArray);
Screen('DrawTexture', wptr, texid, [], trial.stimtrect);
Screen('Flip', wptr); 
WaitSecsFromBegin(beginTime, time); % last for 2s here

% end
Screen('Flip', wptr); 
WaitSecs(0.8);

% diff device time correctron
targettime=tetio_localTimeNow();
remotetio = tetio_localToRemoteTime(int64(targettime));
pctime = fastrak('now');
timeDiff = int64(remotetio - pctime);
endtime=tetio_localTimeNow();

return
