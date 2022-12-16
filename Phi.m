function Int=Phi(z0,Ls)

NRec=10;
H=15; %Km
H=H/Ls;
Int=0;
if z0==H
   Int=0; 
else
    I=(H-z0)/NRec;
    dI=z0:I:H;
    for i=1:length(dI)
    Int=Int+BPhi(dI(i));
    end
    Int=-Int*I;
end

end