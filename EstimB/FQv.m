%Gerardo Hernandez Duenas
function q = FQv(z,qvs0)

a0 = 18.04; a1 = 3.27; a2=0.1; a4 = 3.48;
pz = (1-a1*log(1+a2*z))^a4;

q = (qvs0/pz)*exp(-a0*( 1/((1-a1*log(1+a2*z))*(1+a2*z))-1 ));

%q = q*(1+z)^2;