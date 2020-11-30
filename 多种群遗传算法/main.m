%% 画MPGA的图
time = 1;
figure(1);
while time <= 5
time = time + 1;
[gen Yy] = MPGA();
plot(1:gen,Yy)
hold on;
grid on;
xlabel('进化代数')
ylabel('最优解变化')
title('MPGA进化过程')
xlim([1,gen])
end
hold off;
legend({'1','2','3','4','5'})
saveas(gcf,char("MPGA迭代图比较"), 'jpg');

clear all;
clc;
%% 画SGA的图
time = 1;
figure(2);
while time <= 5
time = time + 1;
[gen Yy] = SGA();
plot(1:gen,Yy);

legend(string(time));
% legend(char(time));
% ansX= [ansX; Xx];
% ansY = [ansY;Yy];
hold on;
grid on;
xlabel('进化代数')
ylabel('最优解变化')
title('SGA进化过程')
xlim([1,gen])
end
hold off;
legend({'1','2','3','4','5'})
saveas(gcf,char("SGA迭代图比较"), 'jpg');