function DrawFixation(wptr)
% DrawFixation.m
global fixationSize;
Screen('DrawLine', wptr, 0, fixationSize/2, 0, fixationSize/2, fixationSize, 3);
Screen('DrawLine', wptr, 0, 0, fixationSize/2, fixationSize, fixationSize/2, 3);
return