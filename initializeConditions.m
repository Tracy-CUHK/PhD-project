function [conditions, images]=initializeConditions(wptr, radius, distance, replication)
% initializeConditions.m
global fixationSize;

conditions=struct([]);
treatments=CombineFactors([2,2]); % 2 * 2 = 4 experiment conditions
wrect=Screen('Rect', wptr); % Get the rect size of the window
fixationSize=min(wrect(3), wrect(4))*3/100; % Define the size of fixation cross
if ~mod(fixationSize, 2)
    fixationSize=fixationSize+1;
end
fixptr=Screen('OpenOffscreenWindow', wptr, 255, [0,0,fixationSize, fixationSize]); % Create an offscreen window (fixptr) to draw fixtation cross on it
DrawFixation(fixptr); % Draw the fixation cross on the offscreen window
offptr=Screen('OpenOffScreenWindow', wptr, 255, [0, 0, 6*radius+2*distance, 2*radius]); % Create an offscreen window (offptr) to draw central circle stimulus on it
DrawCentralStim(offptr, radius, distance); % Draw the central circle on the offscreen window
offptr1=Screen('OpenOffScreenWindow', wptr, 255, [0, 0, 6*radius+2*distance, 2*radius]); % Create an offscreen window (offptr1) to draw central circle stimulus together with initialize a beep cue

% LIRU added on 20170407 ---------------------
%cueWithSound(offptr1, radius, distance, y, Fs);
% LIRU added on 20170407 --------------------

cue=cueWithSound(offptr1, radius, distance); % Draw the central circle on the offscreen and set the value for beep cue
for i=1:size(treatments, 1) % enter FOR loop to define each of four experiment conditions
    conditions(i,1).Attribute=treatments(i,1); % the first column means "Gap" or "Overlap" attribute of the experiment
    conditions(i,1).Direction=treatments(i,2); % the second column means "left" or "right" side appearance of target
offptr2=Screen('OpenOffScreenWindow', wptr, 255, [0, 0, 6*radius+2*distance, 2*radius]); % Create an offscreen window (offptr2) for "Gap" or "Overlap" interval
%offptr3=Screen('OpenOffScreenWindow', wptr, 255, [0, 0, 6*radius+2*distance, wrect(4)-2*radius]); % Create an offscreen window (offptr3) for drawing the target
%trect2=AlignRect([0, 0, long, long], [0, 0, 6*radius+2*distance, wrect(4)-2*radius], 3, 4);
%trect3=AlignRect([0, 0, 2*radius, 2*radius], [0, 0, 6*radius+2*distance, wrect(4)-2*radius], 5, 5);
    if treatments(i,1)==1 
         if treatments(i,2)==1 % For "Gap" & "Left" condition
             trect=[369.5, 502.5, 425.5, 577.5];
             %trect=AlignRect([0, 0, 2*radius, 2*radius], [0, 0, 6*radius+2*distance, wrect(4)-2*radius], 5, 1); % Set the rect area to be on the left side
         else
            trect=[1494.5, 502.5, 1550.5, 577.5];
            %trect=AlignRect([0, 0, 2*radius, 2*radius], [0, 0, 6*radius+2*distance, wrect(4)-2*radius], 5, 3); % For "Gap" & "Right" condition, set the rect area to be on the right side
         end
    else       % For "Overlap" condition
         DrawCentralStim(offptr2, radius, distance); % The central circle stimulus was kept on during the "Overlap" interval
         % DrawCentralStim2(offptr3, trect3); % The central circle stimulus was kept on the screen together with the appearance of target
         if treatments(i,2)==1
             trect=[369.5, 502.5, 425.5, 577.5];
             %trect=AlignRect([0, 0, 2*radius, 2*radius], [0, 0, 6*radius+2*distance, wrect(4)-2*radius], 5, 1); % Set the rect area to be on the left side
         else
             trect=[1494.5, 502.5, 1550.5, 577.5];
             %trect=AlignRect([0, 0, 2*radius, 2*radius], [0, 0, 6*radius+2*distance, wrect(4)-2*radius], 5, 3); % Set the rect area to be on the right side
         end
    end
    %DrawTarget(offptr3, trect);
    %Screen('FillOval', offptr3, [0, 0, 0], trect); % Draw the target on the offscreen window (offptr3)
    %Screen('FillRect', offptr3, [0, 0, 0], trect2);
    conditions(i,1).radius=radius;
    conditions(i,1).fixptr=fixptr;
    conditions(i,1).centralStimPtr=offptr;
    conditions(i,1).cuePtr=offptr1;
    conditions(i,1).sound=cue.sound;
    conditions(i,1).gapPtr=offptr2;
    %conditions(i,1).stimPtr=offptr3;
    conditions(i,1).nstrect=CenterRect([0,0,fixationSize, fixationSize], wrect); % Define the rect area for drawing Fixation cross
    conditions(i,1).dstrect=CenterRect([0, 0, 6*radius+2*distance, 2*radius], wrect); 
    %conditions(i,1).stimtrect=CenterRect([0, 0, 6*radius+2*distance, wrect(4)-2*radius], wrect);
    conditions(i,1).stimtrect=trect;
    
    % load images
    %global images;
    imname = dir('images\*.jpg');
    im_num = length(imname);
    if (im_num <= 0)
        disp('ERROR: Not any images in images/');
        exit();
    end
    im_temp = imread(['images/' imname(1).name], 'jpg');
    [x,y,z] = size(im_temp);
    images(:,:,:,:) = zeros(x,y,z,im_num,'uint8');
    for i = 1 : im_num
        imgArrayItr = imread(['images/0' num2str(i) '.jpg']);
        images(:,:,:,i) = imgArrayItr; 
    end    
end
conditions=Shuffle(repmat(conditions,replication,1)); % repat the matrice and then randomize the order of row
return
        
        
        
        