function showFix(wptr, wrect, fix, time)
% show fixation

Screen('CopyWindow', fix.ptr, wptr, fix.rect, CenterRect(fix.rect, [wrect(1), wrect(2), wrect(3), wrect(4)]));
Screen('Flip', wptr);
WaitSecs(time);