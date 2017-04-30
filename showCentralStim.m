function showCentralStim(wptr, wrect, central, time)
% show central stimulus

Screen('CopyWindow', central.ptr, wptr, central.rect, CenterRect(central.rect, [wrect(1), wrect(2), wrect(3), wrect(4)]));
Screen('Flip', wptr);
WaitSecs(time);
Beeper(2000, 1, 0.05);
    
