%个体评估
function [pop] = calc_objects( pop,tVal )
%CALC_OBJECTS Summary of this function goes here
%   Detailed explanation goes here
    p_size = size(pop,2);          %种群中解的个数
    for i = 1:p_size
        pop(i).objectVal = calc_object(pop(i).pop,tVal);
    end
end

function [fit] = calc_object(x,t)
   %fit=DCT1(x,t);
   %fit=G2(x,t);
   %fit=DCT3(x,t);
   %fit=dMOP2(x,t);
   %fit=dMOP3(x,t,2);
   fit=dMOP1(x,t);
end

%FDA1 目标函数变化
function [fit]=FDA1(x,t)
    fit=zeros(1,4);
    fit(1)=x(1);
    g=1+9*(sum(x.^2)-x(1)^2);
    H=0.75*sin(0.5*pi*t)+1.25;
    h=1-(fit(1)/g).^H;
    fit(2)=g*h;
    fit(3)=0;
    fit(4)=H;
end

%dMOP1 目标函数变化
function [fit]=dMOP1(x,t)
    fit=zeros(1,3);
    fit(1)=x(1);
    g=1+9*(sum(x.^2)-x(1)^2);
    H=0.75*sin(0.5*pi*t)+1.25;
    h=1-(fit(1)/g).^H;
    fit(2)=g*h;
    fit(3)=-g;
end

%dMOP2 目标函数变化
function [fit]=dMOP2(x,t)
    fit=zeros(1,3);
    fit(1)=x(1);
    G=sin(0.5*pi*t);
    g=1+9*(sum((x-G).^2)-(x(1)-G)^2);
    H=0.75*sin(0.5*pi*t)+1.25;
    h=1-(fit(1)/g).^H;
    fit(2)=g*h;
    fit(3)=-g;
end

%dMOP3 目标函数变化
function [fit]=dMOP3(x,t,r)
    fit=zeros(1,3);
    fit(1)=x(r);
    G=sin(0.5*pi*t);
    g=1+9*(sum((x-G).^2)-(x(r)-G)^2);
    H=0.75*sin(0.5*pi*t)+1.25;
    h=1-sqrt((fit(1)/g));
    fit(2)=g*h;
    fit(3)=-g;
end

%G1 无约束
function [fit]=G1(x,t)
    fit=zeros(1,4);
    fit(1)=t*(x^2);
    fit(2)=(1-t)*(x^2);
    fit(3)=0;
end

%G2 无约束
function [fit]=G2(x,t)
    fit=zeros(1,4);
    fit(1)=t*(x(1)^2+(x(2)-1)^2)+(1-t)*(x(1)^2+(x(2)+1)^2+1);
    fit(2)=t*(x(1)^2+(x(2)-1)^2)+(1-t)*((x(1)-1)^2+x(2)^2+2);
    fit(3)=0;
end

%DCT1  无约束
function [fit]=DCT1(x,t)
    fit=zeros(1,3);
    fit(1)=(1-0.0001.*t.^2)*sum(x.^2)+0.0001.*(t.^2).*sum((x-2).^2);
end

%DCT2 两个约束
function [fit]=DCT2(x,t)
    fit=zeros(1,4);
    fit(1)=t*(x(1)-10)^2+(1-t)*(x(2)-20)^2;
    g(1)=-((1-0.2*t)*(x(1)-5)^2+0.2*t*(x(2)-5)^2-100);
    g(2)=0.2*t*(x(1)-6)^6+(1-0.2*t)*(x(2)-5)^2-82.81;
    fit(2)=g(1);
%   fit(3)=g(2);
    phi=sum(max(g,0));
    fit(3)=phi;
end

%DCT3 两个约束
function [fit]=DCT3(x,t)
    fit=zeros(1,3);
    fit(1)=t*(x(1)^2+x(2)-1)^2+(1-t)*(x(1)+x(2)^2-7)^2;
    g(1)=-(4.84-(1-0.1*t)*x(1)^2-0.1*t*(x(2)-2.5)^2);
    g(2)=-(0.1*t*(x(1)-0.05)^2+(1-0.1*t)*(x(2)-2.5)^2-4.48);
    phi=sum(max(g,0));
    fit(2)=phi;
end



