function DrawCentralStim(wptr, distance)
% central circle stimulus

wrect=Screen('Rect', wptr);
radius=min(wrect(3), wrect(4))*3/100;
if ~mod(radius, 2)
    radius=radius+1;
end
Screen('FillOval', centralptr, [255, 0, 0], [2*radius+distance, 0, 4*radius+distance, 2*radius]);
central.ptr=centralptr;
central.rect=[0, 0, 6*radius+2*distance, 2*radius];
return

