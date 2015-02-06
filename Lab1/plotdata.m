time = rawdata(:,1);
response = rawdata(:,2);
step = 10*(time>=1);
error = step - response;

hold all;
plot(time,response);
plot(time,step);
plot(time,error);

legend('Response','Step','Error')
xlabel('Time (s)')
ylabel('Position (degrees)')
title(['System response with Kp=' num2str(Kp)])
ylim([(min(min([response step error])) - 1) (max(max([response step error])) + 1)]);