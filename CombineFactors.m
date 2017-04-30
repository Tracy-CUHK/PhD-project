function [R]=CombineFactors(factors)
% CombineFactors.m
% Direction(right, left), Condition(gap, overlap)
% This is an 2*2 experiment
% gap:1; overlap:2
% left:1; right:2
% create [R] = [1, 1; 1, 2; 2, 1; 2, 2]

tmpNum=1;
for i=1:length(factors)
    tmpNum=tmpNum*factors(i);
end
R=zeros(tmpNum, length(factors));
for i=1:size(R,1)
    tmp=tmpNum;
    for j=1:length(factors)
        if j~=1
            tmp=tmp/factors(j-1);
        end
        R(i,j)=ceil((mod(i-1, tmp)+1)/(tmp/factors(j)));
    end
end
return