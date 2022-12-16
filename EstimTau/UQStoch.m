function UQStoch

%% Scales:
Ths = 3; %In kelvin
qs = 1000; % In g/kg
Us = 11.11; %in m/s
Ls = 10; %In km
Ts = 15; %In minutes

%% Parameters:
%Dimensions and time
T = 15*4*50; %In minutes
T = T/Ts;
% Thermodinamic parameters
epsbar = 0.6; LH = 25/3; 
theta0 = 300; % In kelvin
theta0 = theta0/Ths;
g = 9.81; %in m/s^2
g = g/(9.81)*794.61; %Non-dimensional
B = 3; %In K/km
B = B*Ls/Ths;
% Moisture
qv0 = 16; %In g/kg;
qv0 = qv0/qs;
qvs0 = 22+6; %In g/kg;
qvs0 = qvs0/qs;
%Data of parcel and ebvironment
z_int = 0.5; %In km, this is where theta_e and qt intersect
z_int = z_int/Ls;
qv_int = FQv(z_int,qv0);
Thetae_parcel0 = theta0+B*z_int+LH*theta0*qv_int;
Qt_parcel0 = qv_int;
% Initial position of particle
z0 = 0.5; %in km
z0 = z0/Ls;
w0 = 0; %in m/s
w0 = w0/Us;
% Stochastic parameters
dt = 10*10^(-3);
Nt = round(T/dt);
R = 1; %For the stochastic forcing
Nbr = Nt*R;        % Nt EM steps of size dt = R*dt
%Potsc = (10^8)/15/60;

WeakEnt = 10;
tau_w_exact = 0.05*WeakEnt; %.25; %0.1; %
D_w = .11/5/1*WeakEnt; %In units of m^2/s, up to scales %0.05; %
b_w_exact = sqrt(2*D_w)/tau_w_exact; %Coefficient in the Fokker-Plank eqn

if  dt > min(tau_w_exact/10)
    min(tau_w/10)
    error('reduce time step')
end

%% Compute the Tmean_exact

Ns = 5000; %Number of samples to compute Tmean

dW = sqrt(dt)*randn(Nbr,Ns);         % Brownian increments

z_esc = 4/Ls; %Targeted height

Tmean_exact = FTmeanExact(tau_w_exact,b_w_exact,z_esc,B,qv0,qvs0,theta0,g,epsbar,LH,Qt_parcel0,Thetae_parcel0,Nt,z0,w0,dt,dW,Ns);

%% Computation of the solution and the error


tau_w_n = .1*tau_w_exact;

randn('state',100);

beta = .5; %2; %10; %Explorar mas
delta = 0.15; 

%Phi = PhiFunction(tau_w_n,b_w_exact,z_esc,Tmean_exact,B,qv0,qvs0,theta0,g,epsbar,LH,Qt_parcel0,Thetae_parcel0,Nt,z0,w0,dt,dW,Ns);

NoSteps = 10000;
Phi_min = 10^4;
tau_w_min = tau_w_n;
tau_w_avg_plot = tau_w_n;

N_avg = 100;
i_avg = 0;
tau_w_avg = 0;
iter = 0;
for Step = 1: NoSteps % && error_u_L2_1 > 0.04*10^(-2)/1
    Step
    
    xi_k = beta*randn;
    
    tau_w_star = sqrt(1-2*delta)*tau_w_n + sqrt(2*delta)*xi_k;
    
    while tau_w_star < 0
        xi_k = beta*randn;
        tau_w_star = sqrt(1-2*delta)*tau_w_n + sqrt(2*delta)*xi_k;
    end
    
    %plot(x,B_star)
    %stop
    
    Phi_n = PhiFunction(tau_w_n,b_w_exact,z_esc,Tmean_exact,B,qv0,qvs0,theta0,g,epsbar,LH,Qt_parcel0,Thetae_parcel0,Nt,z0,w0,dt,dW,Ns);
    
    Phi_star = PhiFunction(tau_w_star,b_w_exact,z_esc,Tmean_exact,B,qv0,qvs0,theta0,g,epsbar,LH,Qt_parcel0,Thetae_parcel0,Nt,z0,w0,dt,dW,Ns);

    alpha_tau_w_star_n = min(1,exp(Phi_n-Phi_star));
    
    t = rand;
    
    if alpha_tau_w_star_n >= t && tau_w_star > 0
        tau_w_n = tau_w_star;
        
        if Phi_n < Phi_min
            tau_w_min = tau_w_n;
            Phi_min = Phi_n;
        end
        
        if i_avg < N_avg
            i_avg
            tau_w_avg = tau_w_avg + tau_w_n/N_avg;
            i_avg = i_avg+1;
        else
            i_avg = 0;
            tau_w_avg_plot = tau_w_avg;
            tau_w_avg = 0;
        end
        
        iter = iter +1;
        
        %clf
        figure(1)
        hold on
        plot(iter,tau_w_avg_plot,'r *')
        plot(iter,tau_w_min,'r o')
        plot(iter,tau_w_n,'r +')
        plot(iter,tau_w_exact,'b +')
        %plot(x(3:N+1,1),B_n(3:N+1,1),'b -',x,B_exact,'r -')
        title(num2str(Phi_n))
        legend('tau_w avg','tau_w min','tau_w_n','tau_w exact')
        print('test','-depsc',figure(1))

        TauWAvgArray(iter,1) = tau_w_avg_plot;
        TauWminArray(iter,1) = tau_w_min;
        TauWnArray(iter,1) = tau_w_n;

        Phi_nArray(iter,1) = Phi_n;
        Phi_minArray(iter,1) = Phi_min;

    end
    
    Phi_min
    Phi_n
    
    
    %B_n_step(:,Step) = B_n;
    %ErrorStep(Step,1) = error_u_L2_1;
end

save('Resultados.mat','TauWAvgArray','TauWminArray','TauWnArray','Phi_nArray','Phi_minArray')

% Step_star = 1;
% Error_star = 10^4;
% for Step = 1 : NoSteps
%     if ErrorStep(Step,1) < Error_star
%         Step_star = Step;
%         Error_star = ErrorStep(Step,1);
%     end
% end

