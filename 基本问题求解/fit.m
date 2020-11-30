function [area] = fit(speed,temp_stove)

% %输入速度
% speed = 78
% %输入温度
% temp_stove = [173,198,230,257]

speed_que1 = speed/60
distance = 50+35.5*11-5
whole_time =distance/speed_que1
Temp_pcb = [25]
pcb_w = 1
delta_Time = 0.5
kesi = 44
time_line =[0:delta_Time:whole_time]


for i = time_line
    location = i*speed_que1
    Temp_machine = Temp_S(temp_stove(1),temp_stove(2),temp_stove(3),temp_stove(4),25,location)
    delta_Temp = (Temp_machine-Temp_pcb(pcb_w))*delta_Time/kesi
    Temp_pcb  = [Temp_pcb Temp_pcb(pcb_w)+delta_Temp]
    pcb_w = pcb_w+1
    
    
         %斜率max值,min值
        if delta_Temp/delta_Time > 3 || delta_Temp/delta_Time<-3
            area =999999
            return ;
        end
       
    
end

    
    %温度上升过程中在150?C~190?C的时间
    Temp_more150 = Temp_pcb(Temp_pcb>150)
    freq_150_190 = Temp_more150(Temp_more150<190)
    time_150_190 = length(freq_150_190)*delta_Time
    if time_150_190<60 ||time_150_190>120
        area = 999999
        return ;
    end
    %温度大于217?C的时间
    freq_217 = Temp_pcb(Temp_pcb>217)
    time_217 = length(freq_217)*delta_Time
    if time_217<40 ||time_217>90
        area = 999999
        return ;
    end
    %峰值温度
    temp_max = max(Temp_pcb)
    if temp_max<240 ||temp_max>250
     area = 999999
        return ;
    end


time_and_temp = [time_line;Temp_pcb(1:length(Temp_pcb)-1)]'
%大于217的面积
area217_t_T = time_and_temp(time_and_temp(:,2)>216.9999,:)
area = 0
for i = [1:length(area217_t_T)-1]
   area = area + ((area217_t_T(i,2)+area217_t_T(i+1,2))/2-217)*delta_Time
end

end

