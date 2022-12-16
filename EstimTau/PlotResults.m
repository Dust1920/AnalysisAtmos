function PlotResults

load('Resultados.mat')


Ts = 15; %In minutes

Tau=TauWnArray*Ts;

for i=1:length(Tau)
    if Tau(i)==min(Tau)
   i     
    end
end
Tau(1)=[];

distributionFitter(Tau);

stop


%plot(TauWnArray(2:end))

N = size(TauWnArray,1);
Nbin = 50;

%histogram(TauWnArray(100:N),Nbin)

tau_min = min(TauWnArray);
tau_max = max(TauWnArray);

delta_tau = (tau_max-tau_min)/Nbin;

pdf = zeros(Nbin,2);

for n = 1:Nbin
    pdf(n,1) = tau_min + delta_tau*(n-1/2);
end

for i = 100:N
    n = round( (TauWnArray(i,1)-tau_min)/delta_tau+1/2 );
    n = max(n,1);
    n = min(n,Nbin);
    
    pdf(n,2) = pdf(n,2) + 1;
    
end

pdf(:,2) = pdf(:,2)/(sum(delta_tau*pdf(:,2)));

bar(pdf(:,1)*Ts,pdf(:,2)/Ts)

xlabel('\tau_w (min)','FontSize',15)
ylabel('PDF (min^{-1})','FontSize',15)

print('Histogram','-dpng',figure(1))
