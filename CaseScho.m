load("Pars.mat");

Ns=5000;
%Caso Estocástico.

LFC=LfC();
LFC=LFC(1);

tau_w=7.5; %min
tau_w=tau_w/Ts;

b_w=0.491;
b_w=(b_w*sqrt(60*Ts))/Vs;

ZS=zeros(Ns,length(T));
WS=zeros(Ns,length(T));

ZS(:,1)=z0;
WS(:,1)=w0;

randn('state',100);
dW=sqrt(DeltaT)*randn(Ns,length(T)-1);

Btn=1;
for i=1:Ns
    i
    for j=1:(length(T)-1)
    ZS(i,j+1)=ZS(i,j)+DeltaT*WS(i,j);  
    q=Bou(ZS(i,j),Par);
    WS(i,j+1)=WS(i,j)+DeltaT*q(9)-1/tau_w*DeltaT*WS(i,j)+Btn*b_w*dW(i,j);
    end
end

Tvec=zeros(1,Ns);

for i=1:Ns
    for j=1:(length(T)-1)
       if ZS(i,j)>LFC() 
          Tvec(i)=j;
          break
       end
    end
end

Times=Tvec*DeltaT*Ts;
save('TIMES','Times');


Tmid=mean(Tvec)*DeltaT*Ts;



hold on
plot(WS(1,:)*Vs,ZS(1,:)*Ls)
plot(WS(20,:)*Vs,ZS(1,:)*Ls)
plot(WS(80,:)*Vs,ZS(1,:)*Ls)
plot(WS(1999,:)*Vs,ZS(1,:)*Ls)
plot(WS(3000,:)*Vs,ZS(1,:)*Ls)
hold off
