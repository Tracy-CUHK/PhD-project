function [fixtime, centraltime, cuetime, gaptime, targettime, endtime, timeDiff]=oneTrial2(wptr, trial, time, y, Fs, imgArray)
% oneTrial2.m

Screen('CopyWindow', trial.fixptr, wptr, [], trial.nstrect); % Show fixation cross on the center of screen
fixtime=int64(fastrak('now')); % Get computer time
Screen('Flip', wptr); % Flip
WaitSecs(0.5); % last for 0.5 s

Screen('CopyWindow', trial.centralStimPtr, wptr, [], trial.dstrect); % Show the central circle stimulus
%centraltime=int64(fastrak('now')); % Get computer time
Screen('Flip', wptr);
centraltime=int64(fastrak('now')); % Get computer time
WaitSecs(0.05); % last for 0.45 s
disp(centraltime-fixtime);

% phrase sound, beep sound and show target 50ms
Screen('CopyWindow', trial.cuePtr, wptr, [], trial.dstrect); % Show the central circle stimulus together with beeper cue
Screen('Flip', wptr);
cuetime = fastrak('now');
player = audioplayer(y, Fs);
play(player);
WaitSecsFromBegin(cuetime, 0.45);
% gaptime=fastrak('now');
overtime=fastrak('now');
disp(overtime-centraltime);
disp(overtime-cuetime);

% phrase gap
Screen('CopyWindow', trial.gapPtr, wptr, [], trial.dstrect); % Show the "Gap" or "Overlap" interval
Screen('Flip', wptr);
gaptime = int64(fastrak('now')); 
WaitSecs(0.2); % last for 0.2s
disp(fastrak('now') - gaptime);

% phrase target
targettime=fastrak('now'); % Get local SDK time using tetio functions
% cuetime = beginTime;
if trial.Attribute == 2
    wrect=Screen('Rect', wptr);
    Screen('FillOval', wptr, [0, 0, 0], CenterRect([0, 0, 2 * trial.radius, 2 * trial.radius], wrect));
end
Screen('FillRect', wptr, [0, 0, 0], [1830, 1000, 1850, 1020]);
texid = Screen('MakeTexture', wptr, imgArray);
Screen('DrawTexture', wptr, texid, [], trial.stimtrect);
Screen('Flip', wptr); 
WaitSecsFromBegin(targettime, time); % last for 2s here
endtime=int64(fastrak('now'));

% end
Screen('Flip', wptr); 
WaitSecs(0.8);

% diff device time correctron
targettime_temp=tetio_localTimeNow();
remotetio = tetio_localToRemoteTime(int64(targettime_temp));
pctime = fastrak('now');
timeDiff = int64(remotetio - pctime);


return
