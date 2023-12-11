%Codigo V4

%Escalas

Ls=10; %Km
Ths=3; %K
Qs=1000; %g/Kg
Ts=15; %min

%Escala complementaria
Vs=(Ls*1000)/(Ts*60);

%Condiciones Iniciales
   %Altura
    z0=0.5; %Km
    z0=z0/Ls;
   %Velocidad
    w0=0;
    w0=w0/Vs;
   %Tiempo
   DeltaT=Ts*10^(-2);
   DeltaT=DeltaT/Ts;
   
   LfC()
   %Area de trabajo
        %Altura
        Z0=0; %Km
        Z0=Z0/Ls;
        ZF=15; %Km
        ZF=ZF/Ls; 
        %Velocidad
        W0=-50; %m/s
        W0=W0/Vs;
        WF=50; %m/s
        WF=WF/Vs;
        %Tiempo
        Ti=0;    %min
        Ti=Ti/Ts;
        Tf=3000;  %min
        Tf=Tf/Ts;
        
        dZ=0.01;
        dZ=dZ/Ls;
        dV=1;
        dV=dV/Vs;
        
        Z=Z0:dZ:ZF;
        W=W0:dV:WF;
        T=0:DeltaT:Tf;
          
   
   
   
%Parametros

 %Thetaenv
 T0=300; %K
 T0=T0/Ths;

 B=3; %K/Km
 B=B*Ls/Ths;

 %Qvenv/Qvs
 qv0=16;
 qv0=qv0/Qs;
 qvs0=28;
 qvs0=qvs0/Qs;
 
 %ThetaEenv
 L=2.5*10^6; %J/Kg
 Cp=10^3; %J/(Kg*K)
 Cp=Cp*Ths;
 LCP=L/Cp;
 
 %ThetaVenv
 epsilon=0.6;
 
 %ThetaV
 p=T0+B*z0;
 Qv=FQv(z0,qv0);
 Te=p+LCP*Qv;
 Qt=Qv;
 z0
 p
 Qt
 %Bouyancy
 g=9.81; %m/s^2
 g=g*60*Ts/Vs;
 
 Par=zeros(1,10);
 Par(1)=T0;
 Par(2)=B;
 Par(3)=qv0;
 Par(4)=qvs0;
 Par(5)=LCP;
 Par(6)=epsilon;
 Par(7)=-1000;
 Par(8)=Te;
 Par(9)=Qt;
 Par(10)=g;
 
 
 save Pars.mat