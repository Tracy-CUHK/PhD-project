% Gap-overlap paradigm with looking only

clear all;
KbName('UnifyKeyNames');
subinfo=getSubInfo;
if isempty(subinfo)
    return;
end
try
    [wptr, wrect]=Screen('OpenWindow', 1, 255, [ ]);
    trials=initializeConditions(wptr, 30, 600, 4);
    repTrials_Run(wptr, trials);
    sca;
catch
    psychrethrow(psychlasterror);
    sca;
end
return;
    