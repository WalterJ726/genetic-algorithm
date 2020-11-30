load('simulate_5D_GA_3.mat')
i = 1:50;
T_part5 = trace(1,:);
T_part6 = trace(2,:);
T_part7 = trace(3,:);
T_part9 = trace(4,:);
T_part10 = trace(5,:);
S = trace(6,:);

figure(1);
% subplot(2,3,1);
plot(i,T_part5);
title('小温区1-5进化过程')
xlabel('进化次数');ylabel('最优解变化');
filename = "小温区1-5" + "迭代曲线图";
saveas(gcf,char(filename), 'jpg');


figure(2);
plot(i,T_part6);
title('小温区6进化过程')
xlabel('进化次数');ylabel('最优解变化');
filename = "小温区6" + "迭代曲线图";
saveas(gcf,char(filename), 'jpg');


figure(3);
plot(i,T_part7);
title('小温区7进化过程')
xlabel('进化次数');ylabel('最优解变化');
filename = "小温区7" + "迭代曲线图";
saveas(gcf,char(filename), 'jpg');

figure(4);
% subplot(2,3,4);
plot(i,T_part9);
title('小温区8-9进化过程')
xlabel('进化次数');ylabel('最优解变化');
filename = "小温区8-9" + "迭代曲线图";
saveas(gcf,char(filename), 'jpg');

figure(5);
% subplot(2,3,5);
plot(i,T_part10);
title('速度进化过程')
xlabel('进化次数');ylabel('最优解变化');
filename = "速度" + "迭代曲线图";
saveas(gcf,char(filename), 'jpg');

figure(6);
% subplot(2,3,6);
plot(i,S);
title('面积进化过程')
xlabel('进化次数');ylabel('最优解变化');
filename = "面积" + "迭代曲线图";
saveas(gcf,char(filename), 'jpg');

figure(2);
plot(i, S);
title('面积进化过程')
xlabel('进化次数');ylabel('最优解变化');
saveas(gcf,'迭代曲线图', 'jpg');
