function b=BPhi(z)
load('Pars.mat','Par');    
b=Bou(z,Par);
b=b(9);