%Gerardo Hernandez Duenas
%Evolution using one step of Runge-Kutta
%LH = L/(cp*thetao)
function CRK = Evolution(z,w,B,qv0,qvs0,theta0,g,epsbar,LH,tau_w,Qt_parcel0,Thetae_parcel0)

qt = Qt_parcel0;
thetae = Thetae_parcel0;

Theta_env = theta0+B*z;
Qv_env = FQv(z,qv0);
Thetae_env = Theta_env+LH*theta0*Qv_env;
Thetav_env = Thetae_env+(epsbar-LH)*theta0*Qv_env;

Qvs = FQv(z,qvs0);
Qv_parcel = min(qt,Qvs);
Qr_parcel = max(qt-Qv_parcel,0);
Thetav_parcel = thetae+(epsbar-LH)*theta0*Qv_parcel-theta0*Qr_parcel;


CRK=zeros(2,1);

CRK(1,1) = w;
CRK(2,1) = (g/theta0)*(Thetav_parcel-Thetav_env)-w/tau_w;
