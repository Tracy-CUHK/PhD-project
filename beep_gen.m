function [y,Fs]=beep_gen
a=1000; % Amplitude.
f_sine=2000; % Sine frequency
f_samp=16000;  % Sampling frequency
samp_time=0.05; % Sample time in second.

samp_num = floor(samp_time*f_samp);
x=0:1/f_samp:samp_time;
y=a*sin(f_sine*x);

% Output file or mat.
%fid= fopen('beep.txt','w+');
%for i = 1:1:samp_num;
%    fprintf(fid, '%d\n', y(i));
%end
%fclose(fid);
y=y';
Fs=f_samp;
save('beep.mat', 'y', 'Fs');

% Play sound or plot sound wave:
%plot(y);
%sound(y, f_samp);
%obj = audioplayer(y, Fs);
%play(obj);
end