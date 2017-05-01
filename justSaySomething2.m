function justSaySomething2(wptr, something, waitornot, color)
% justSaySomething2.m

if nargin < 3
    waitornot=0;
    color=0;
end
if nargin < 4
    color=0;
end

DrawFormattedText(wptr, something, 'center', 'center', color);
Screen('Flip', wptr);
while KbCheck; end
if waitornot
    KbWait;
end
end