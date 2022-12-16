function PlotResults


load('Resultados.mat')

Us = 11.11; %in m/s
Ts = 15; %In minutes

TauWnArray = TauWnArray*Ts; %In minutes
bWnArray = bWnArray*(Us/sqrt(Ts*60)); %m/s/s^{-1/2}

N = size(TauWnArray,1);
Nb = 40;

% figure(1)
% X = [TauWnArray(100:N),bWnArray(100:N)];
% hist3(X,'CDataMode','auto','FaceColor','interp','Nbins',[Nb Nb])
% xlabel('\tau_w')
% ylabel('b_w')
% zlabel('PDF')

tau_min = min(TauWnArray(100:N))
tau_max = max(TauWnArray(100:N))

delta_tau = (tau_max-tau_min)/Nb;

b_min = min(bWnArray(100:N))
b_max = max(bWnArray(100:N))

delta_b = (b_max-b_min)/Nb;

x_axis = zeros(Nb,1);
y_axis = zeros(Nb,1);
pdf = zeros(Nb,Nb);

for ny = 1:Nb
    for nx = 1:Nb
        x_axis(nx,1) = tau_min + delta_tau*(nx-1/2);
        y_axis(ny,1) = b_min + delta_b*(ny-1/2);
    end
end

for i = 100:N
    nx = round( (TauWnArray(i,1)-tau_min)/delta_tau+1/2 );
    nx = max(nx,1);
    nx = min(nx,Nb);
    
    ny = round( (bWnArray(i,1)-b_min)/delta_b+1/2 );
    ny = max(ny,1);
    ny = min(ny,Nb);
    
    pdf(nx,ny) = pdf(nx,ny) + 1;    
end

integral = sum(sum(delta_tau*delta_b*pdf));

pdf = pdf/integral;

format shortg
sprintf('XMin: %5f xMax: %5f', [min(x_axis) max(x_axis)])
sprintf('yMin: %5f yMax: %5f', [min(y_axis) max(y_axis)])

ax2 = bar3(transpose(pdf));

% set(gca,'XTickLabel',x_axis)
% set(gca,'YTickLabel',y_axis)

xlabel('\tau_w (min)','FontSize',15)
ylabel('b_w (m/s s^{-1/2})','FontSize',15)
zlabel('PDF (min^{-1} (m/s s^{-1/2})^{-1})','FontSize',15)

axis([0 40 0 40 0 8])

pdf_max = max(max(pdf))

xticks([0:10:40])
xticklabels({num2str(tau_min),num2str(tau_min+delta_tau*10),num2str(tau_min+delta_tau*20),num2str(tau_min+delta_tau*30),num2str(tau_min+delta_tau*40)})

yticks([0:10:40])
yticklabels({num2str(b_min),num2str(b_min+delta_b*10),num2str(b_min+delta_b*20),num2str(b_min+delta_b*30),num2str(b_min+delta_b*40)})

zticks([0:2:8])
zticklabels({'0',num2str(pdf_max/8*2),num2str(pdf_max/8*4),num2str(pdf_max/8*6),num2str(pdf_max/8*8)})


print('Histogram2DTauwBw','-dpng',figure(1))
