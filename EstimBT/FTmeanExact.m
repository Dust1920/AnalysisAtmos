function Tmean_exact = FTmeanExact(tau_w,b_w,z_esc,B,qv0,qvs0,theta0,g,epsbar,LH,Qt_parcel0,Thetae_parcel0,Nt,z0,w0,dt,dW,Ns)


%% Numerics

%Phi function is the error in the mean

Tmean_exact = 0;
N_samples = 0;

for ins = 1 : Ns

    Escape = 0;
    
    z_old = z0;
    w_old = w0;
    
    it = 1; %To count the time lapsed

    while Escape == 0 && it < Nt

        %Euler-Maruyama method:
        F = Evolution(z_old,w_old,B,qv0,qvs0,theta0,g,epsbar,LH,tau_w,Qt_parcel0,Thetae_parcel0);

        % Evolution, including the stochastic forcing

        z_new = z_old+dt*F(1,1);
        w_new = w_old+dt*F(2,1)+b_w*dW(it,ins);

        z_old = z_new;
        w_old = w_new;
        
        it = it+1;
        
        if z_new > z_esc
            Escape = 1;
        end
        
    end
    
    if it < Nt %This means it was able to escape before the time limit
        Tmean_exact = Tmean_exact + (it-1)*dt;
        N_samples = N_samples+1;
    end
    
end

if N_samples > 0
    Tmean_exact = Tmean_exact/N_samples;
else
    Tmean_exact = 10^4;
end


