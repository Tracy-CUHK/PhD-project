function oneTrial(wptr, trial, time)
% oneTrial.m

Screen('CopyWindow', trial.fixptr, wptr, [], trial.nstrect);
Screen('Flip', wptr);
WaitSecs(0.5);
Screen('CopyWindow', trial.centralStimPtr, wptr, [], trial.dstrect);
Screen('Flip', wptr);
WaitSecs(0.45);
Screen('CopyWindow', trial.cuePtr, wptr, [], trial.dstrect);
Screen('Flip', wptr);
if ~isnan(trial.sound)
    Beeper(500, 1, 0.05);
end
WaitSecs(0.05);
Screen('CopyWindow', trial.gapPtr, wptr, [], trial.dstrect);
Screen('Flip', wptr);
WaitSecs(0.2);
Screen('CopyWindow', trial.stimPtr, wptr, [], trial.dstrect);
Screen('Flip', wptr);
WaitSecs(time);
Screen('Flip', wptr);
return
