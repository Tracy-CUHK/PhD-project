function cue=cueWithSound(wptr, radius, distance)
% cueWithSound.m

Screen('FillOval', wptr, [0, 0, 0], [2*radius+distance, 0, 4*radius+distance, 2*radius]);
cue.sound=1;
return