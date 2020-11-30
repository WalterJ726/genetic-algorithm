function [T] = Temp_S(temp1_5,temp_6,temp_7,temp8_9,temp10_11,s)
%  1之前
s=s-10
kk=30
if s < 40.25+kk
    x = 40.25+kk
    a = inv([10,-10,1;x^2,x,1;2*x,1,0])*[0;temp1_5-25;0]
    T = a(1)*s^2+a(2)*s+25+a(3)
end
%   1-5
if s>=40.25+kk && s<182.25
    T = temp1_5
end
% 5-6前半
if s>=182.25 && s<200
    a = (temp_6-temp1_5)/2/(17.75^2)
    T = a*(s-182.25)^2+temp1_5
end
% 5-6后半
if s>=200 && s<217.75
    x = 2.5+15.25
    a = [x^2 x;2*x 1]\[temp_6-(temp_6+temp1_5)/2;0]
    T = a(1)*(s-200)^2+a(2)*(s-200)+(temp_6+temp1_5)/2
end 
% 6-7前半
if s>=217.75 && s<235.5
    a = (temp_7-temp_6)/2/(17.75^2)
    T = a*(s-217.75)^2+temp_6
end
% 6-7后半
if s>=235.5 && s<253.25
    x = 2.5+15.25
    a = inv([x^2 x;2*x 1])*[temp_7-(temp_6+temp_7)/2;0]
    T = a(1)*(s-235.5)^2+a(2)*(s-235.5)+(temp_6+temp_7)/2
end 


% 7-8前半
if s>=253.25 && s<271
    a = (temp8_9-temp_7)/2/(17.75^2)
    T = a*(s-253.25)^2+temp_7
end
% 7-8后半
if s>=271 && s<288.75
    x = 2.5+15.25
    a = inv([x^2 x;2*x 1])*[(temp8_9-(temp8_9+temp_7)/2);0]
    T = a(1)*(s-271)^2+a(2)*(s-271)+(temp8_9+temp_7)/2
end 
% %   8-9
if s>=288.75 && s<324.25
    T = temp8_9
end

% % >>>9 完美拟合
k3 = 200
k_c = 340
if s>=324.25 
    a = (temp10_11-temp8_9)/(50^2)
    T = a*(s-324.25)^2+temp8_9
    if s>k_c
        b = 2*a*(k_c-324.25)
        a2 = (25-b*k3)/k3^2
        T = a2*(s-k_c)^2+b*(s-k_c)+a*(k_c-324.25)^2+temp8_9
    
end



end

