now1=fastrak('now');
tetio_startTracking;
now2=fastrak('now');
WaitSecs(60.0);
now3=fastrak('now');
[lefteye, righteye, timestamp, trigSignal] = tetio_readGazeData;
now4=fastrak('now');

interval1=timestamp(1)-now1;
interval2=timestamp(1)-now2;
a=size(timestamp, 1);
interval3=timestamp(a)-now3;
interval4=timestamp(a)-now4;
tetio_stopTracking; 