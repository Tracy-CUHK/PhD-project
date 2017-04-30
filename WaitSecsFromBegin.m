%begin time get by fastrak('now')
function WaitSecsFromBegin(begintime, sec)
    waittime = (sec * 1000000 - (fastrak('now') - begintime)) / 1000000;
    WaitSecs(waittime);
end