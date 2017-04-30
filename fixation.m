function fixation(wptr)
% DrawFixation.m

offptr=Screen('OpenOffscreenWindow', wptr, 255, [0,0,fixationSize, fixationSize]);
Screen('DrawLine', offptr, 0, fixationSize/2, 0, fixationSize/2, fixationSize, 3);
Screen('DrawLine', offptr, 0, 0, fixationSize/2, fixationSize, fixationSize/2, 3);
fix.ptr=offptr;
fix.rect=[0,0,fixationSize, fixationSize];
return