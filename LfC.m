function[p]=LfC()
eps=0.0001;
za=0.2;
zb=0.3;
z0=0;
i=0;
while abs(BPhi(za)-BPhi(zb))>eps
    z0=(za+zb)/2;
    if BPhi(za)*BPhi(z0)<0
    zb=z0;
    else
        za=z0;
    end
    i=i+1;
end
p=zeros(1,2);
p(1)=z0;
p(2)=i;
end
