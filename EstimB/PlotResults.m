function PlotResults

load('Resultados.mat')

Ts = 15; %In minutes
Us=11.1111;
bw=bWnArray*(Us/sqrt(60*Ts));

bw
distributionFitter(bw);
stop






N = size(bWnArray,1);
Nbin = 50;

%histogram(TauWnArray(100:N),Nbin)

b_min = min(bWnArray(100:N))
b_max = max(bWnArray(100:N))

delta_b = (b_max-b_min)/Nbin;

pdf = zeros(Nbin,2);

for n = 1:Nbin
    pdf(n,1) = b_min + delta_b*(n-1/2);
end

for i = 100:N
    n = round( (bWnArray(i,1)-b_min)/delta_b+1/2 );
    n = max(n,1);
    n = min(n,Nbin);
    
    pdf(n,2) = pdf(n,2) + 1;
    
end

pdf(:,2) = pdf(:,2)/(sum(delta_b*pdf(:,2)));

bar(pdf(:,1)*Us/sqrt(60*Ts),pdf(:,2)/Ts)

xlabel('b_w (ms^{-3/2})','FontSize',15)
ylabel('PDF (s^{3/2} m^{-1})','FontSize',15)

print('Histogram','-dpng',figure(1))