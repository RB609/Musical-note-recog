
function [check,wH] = harmonics (center,F,net,lf)
if center>lf
    threshold= .8;
    rcenter= round(center); 
    f= (F((rcenter-20):(rcenter+20)))';     %41 samples
    f= f/max(f);                            % normalize samples
    f=f';
    check = net(f);
     
    if check>threshold
        check=1;
        [temp1 wH]=max(f);
    else
        check=0;
        wH=0;
    end
else
    check=0;
    wH=0;
end
