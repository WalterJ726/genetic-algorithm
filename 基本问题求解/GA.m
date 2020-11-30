%% 定义遗传算法参数
%     NIND;        %个体数目
%     MAXGEN;      %最大遗传代数
%     PRECI;       %变量的二进制位数
%     GGAP;      %代沟
%     pc;         %交叉概率
%     pm;        %变异概率

cor_matrix = [
    40 25 7 0.95 0.7 0.05
    50 25 7 0.95 0.7 0.01
    40 50 7 0.95 0.7 0.01
    40 100 7 0.95 0.7 0.01
    40 200 7 0.95 0.7 0.01
    40 50 10 0.95 0.7 0.05
    40 25 10 0.95 0.6 0.05
    40 30 10 0.90 0.7 0.01
    40 30 7 0.90 0.6 0.01
    40 25 7 0.90 0.6 0.01
    ]

%% 进化过程
for i = 1:length(cor_matrix)
    trace = cal_trace(cor_matrix(i,1), cor_matrix(i,2),...
        cor_matrix(i,3), cor_matrix(i,4), cor_matrix(i,5), cor_matrix(i,6), i)
end

 
function trace = cal_trace(NIND, MAXGEN, PRECI, GGAP, pc, pm, order)
T_part5 = 175;
T_part6 = 195;
T_part7 = 235;
T_part9 = 255;
T_part10 = 25;

%% 画出函数图
lbx=T_part5 - 10;ubx=T_part5 + 10; %函数自变量x范围175
lby=T_part6 - 10;uby=T_part6 + 10; %函数自变量y范围195
lbz=T_part7 - 10;ubz=T_part7 + 10; %函数自变量z范围235
lba=T_part9 - 10;uba=T_part9 + 10;%函数自变量a范围255
lbb=65;       ubb=100; %函数自变量b的范围65-100
trace=zeros(6,MAXGEN);                        %寻优结果的初始值
FieldD=[PRECI PRECI PRECI PRECI PRECI
    lbx lby lbz lba lbb
    ubx uby ubz uba ubb
    1 1 1 1 1
    0 0 0 0 0
    1 1 1 1 1
    1 1 1 1 1
    ];                      %区域描述器
Chrom=crtbp(NIND,PRECI*5);                      %初始种群
%% 优化
gen=0;                                  %代计数器
XY=bs2rv(Chrom,FieldD);                 %计算初始种群的十进制转换
X=XY(:,1);Y=XY(:,2);Z=XY(:,3);A=XY(:,4);B=XY(:,5);
ObjV = zeros(20,1);
a = zeros(20,1);
for i = 1:length(X)
    speed = B(i);
    temp_stove = [X(i) Y(i) Z(i) A(i)];
    S = fit(speed, temp_stove);
    ObjV(i) = S;
end

while gen<MAXGEN
    ObjVSel = [];
    FitnV=ranking(ObjV);                              %分配适应度值
    SelCh=select('rws',Chrom,FitnV,GGAP);              %选择
    SelCh=recombin('xovsp',SelCh,pc);                  %重组
    SelCh=mut(SelCh,pm);                               %变异
    XY=bs2rv(SelCh,FieldD);               %子代个体的十进制转换
    X=XY(:,1);Y=XY(:,2);Z=XY(:,3);A=XY(:,4);B=XY(:,5);
    for i = 1:length(X)
        speed = B(i);
        temp_stove = [X(i) Y(i) Z(i) A(i)];
        S = fit(speed, temp_stove);
        ObjVSel = [ObjVSel; S];
    end
    %计算子代的目标函数值
    [Chrom,ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel); %重插入子代到父代，得到新种群
    XY=bs2rv(Chrom,FieldD);
    gen=gen+1;                                             %代计数器增加
    %获取每代的最优解及其序号，Y为最优解,I为个体的序号
    [ans,I]=min(ObjV);
    trace(1:5,gen)=XY(I,:);                       %记下每代的最优值
    trace(6,gen)=ans;                               %记下每代的最优值
end
%% 保存训练数据
filename = "simulate_5D_GA_" + string(order);
save(filename)
end
