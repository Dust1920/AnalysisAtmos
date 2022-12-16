function S=Bou(z,param)
nZ=length(z);
%1 Theta0
%2 B
%3 qv0
%4 qvs0
%5 LCP
%6 epsilon
%7 Qv
%8 Te
%9 Qt
%10 g
S=zeros(9,nZ);
    for i=1:nZ
    S(1,i)=param(1)+param(2)*z(i); %Thetaenv
    S(2,i)= FQv(z(i),param(3)); %Qvenv
    S(3,i)= FQv(z(i),param(4)); %Qvs
    S(4,i)= S(1,i)+ param(5)*S(2,i); %ThetaEenv
    S(5,i)= S(4,i)+param(1)*(param(6)-param(5)/param(1))*S(2,i);%ThetaVenv
    S(6,i)=min(param(9),S(3,i)); %Qv
    S(7,i)=max(param(9)-S(3,i),0);%Ql
    S(8,i)=param(8)+param(1)*(param(6)-param(5)/param(1))*S(6,i)-param(1)*S(7,i);%ThetaV
    S(9,i)=param(10)/param(1)*(S(8,i)-S(5,i));
    end
end

