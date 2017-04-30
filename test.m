[wptr, wrect]=Screen('OpenWindow', 1, 255, [ ]);
[trials, xx]=initializeConditions(wptr, 18.75, 525, 20, 4);

imgArray = imread('images/01.jpg', 'jpg');

radius = 18.75;
distance = 525;
trial = trials(1);

fixationSize=min(wrect(3), wrect(4))*3/100; % Define the size of fixation cross
if ~mod(fixationSize, 2)
    fixationSize=fixationSize+1;
end

offptr2=Screen('OpenOffScreenWindow', wptr, 255, [0, 0, 6*radius+2*distance, 2*radius]);
DrawCentralStim(offptr2, radius, distance); 
Screen('CopyWindow', offptr2, wptr, [], trial.dstrect ); 
% Screen('CopyWindow', offptr2, wptr, [], trial.stimtrect); % Show the target on right or left side
Screen('Flip', wptr);
WaitSecs(0.5);

Screen('FillOval', wptr, [0, 0, 0], CenterRect([0, 0, 2*radius, 2*radius], wrect));
texid = Screen('MakeTexture', wptr, imgArray);
Screen('DrawTexture', wptr, texid, [], trial.stimtrect);
Screen('Flip', wptr);
WaitSecs(0.5);

beginTime=fastrak('now'); % Get local SDK time using tetio functions
Screen('Flip', wptr); 
WaitSecs(0.5);
WaitSecsFromBegin(beginTime, 0.6); % last for 2s here
endTime = fastrak('now');
disp(endTime - beginTime);

Screen('Close', wptr);

% texid = Screen('MakeTexture', offptr2, imgArray);
% Screen('DrawTexture', trial.stimPtr, texid, [], trial.stimtrect);