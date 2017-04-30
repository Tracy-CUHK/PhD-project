function DrawTarget(wptr, trect)
% DrawTarget.m

imgArray = imread('target.jpg');
texid = Screen('MakeTexture', wptr, imgArray);
Screen('DrawTexture', wptr, texid, [], trect);