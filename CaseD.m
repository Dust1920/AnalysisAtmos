load("Pars.mat");

% PLOT=zeros(9,length(Z));
% 
% for i=1:length(Z)
%    PLOT(:,i)=Bou(Z(i),Par); 
% end

% hold on
% plot(PLOT(5,:)*Ths,Z*Ls) %Thetav_env
% plot(PLOT(8,:)*Ths,Z*Ls) %Thetav_parcel
% plot(PLOT(4,:)*Ths,Z*Ls) %Thetae_env
% xline(Te*Ths)            %Thetae0
% title("Temperaturas Potenciales")
% ylabel("Z (Km)")
% xlabel("Temperatura (K)")
% hold off
% 

%  hold on
%  plot(PLOT(9,:)*Vs/(Ts*60),Z*Ls,'r')
%  xline(0,':')
%  yline(2,':b')
%  yline(3,':b')
%  hold off


%PlotPhi=zeros(1,length(Z));
% 
% for i=1:length(Z)
% i
% PlotPhi(i)=Phi(Z(i),Ls);
% 
% end 
% 
% 
% Energy=zeros(length(Z),length(W));
% 
% for i=1:1:length(Z)
%     i
%     for j=1:1:length(W)
%         j
%    Energy(i,j)=E(Z(i),W(j));   
%     end
% end





%Caso Determinista

tau_w=7.5; %min
tau_w=tau_w/Ts;

k=length(T)-1;
Zt=zeros(1,k);
Wt=zeros(1,k);
Zt(1)=10/Ls;
Wt(1)=w0;

b_w=0.491*0;
b_w=(b_w*sqrt(60*Ts))/Vs;
Btn=1;

randn('state',100)

    for j=1:k
        Zt(j+1)=Zt(j)+DeltaT*Wt(j);
        q=Bou(Zt(j),Par);
        Wt(j+1)=Wt(j)+DeltaT*q(9)-1/tau_w*DeltaT*Wt(j)+Btn*b_w*sqrt(DeltaT)*randn();
    end

    hold on
plot(Wt*Vs,Zt*Ls,'b');
    hold off

   


