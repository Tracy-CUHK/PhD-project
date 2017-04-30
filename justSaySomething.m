function justSaySomething(wptr, something, color)
%justSaySomething.m

oldTextColor=Screen('TextColor', wptr);
DrawFormattedText(wptr, something, 'center', 'center', color);
Screen('Flip', wptr);
Screen('TextColor', wptr, oldTextColor);
