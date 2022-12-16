load('Times.mat');
Tb=max(Times)+0.5;
Ta=min(Times)-0.5;

RIQ=iqr(Times);
SM=2*RIQ/(length(Times)^(1/3));

TimesAjust=ceil((Times-Ta)/SM);
PDF=zeros(1,66);
for i=TimesAjust
    PDF(i)=PDF(i)+1;
end

%bar(PDF)
%histogram(Times,66)
%distributionFitter(Times)
%bar(PDF/5000);
%histogram((Times/60),60);

gamcdf(100,1.46504,92.4293)

% histogram(Times,Ninterval);

% Th=Times/60;
% Spaces=50;
% 
% Ti=0;
% Tf=50;
% TVEC=1:Tf;
% 
% trep=zeros(1,Spaces);
% for i=1:Spaces
%   s=round(Th(i),0)+1;
%  trep(s)=trep(s)+1;   
% end
% 
% trepr=trep/sum(trep);
% Prob=1-trepr/max(trepr);
% 
% hold on
% 
% plot(trepr)
% xlabel("t")
% ylabel("PDF")
% %plot(Prob)
% hold off

% S=zeros(length(trepr),1);
% for i=1:length(trepr)
%     
%    S(i)=trepr(i); 
%     
% end
% 
% te=fitdist(S,'exponential');
% lambda=mean(te);
% 
% y = exppdf(TVEC,lambda);
% 
% plot(y)

