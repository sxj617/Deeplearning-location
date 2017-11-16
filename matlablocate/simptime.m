function [tp,ts]=simptime(r,d)
d1=10;
d2=30;
v1s=2;
v2s=3.45;
v3s=4.1;
v1p=3.5;
v2p=6;
v3p=7.5;
if d<d1;
    tp=((r.^2+d.^2).^0.5)/v1p;
    ts=((r.^2+d.^2).^0.5)/v1s;
elseif d<d2
    h=d-d1;
    fxp=@(z)h*v2p*z/(1-v2p.^2.*z.^2).^0.5+d1*v1p*z/(1-v1p.^2.*z.^2).^0.5-r;
    fxs=@(z)h*v2s*z/(1-v2s.^2.*z.^2).^0.5+d1*v1s*z/(1-v1s.^2.*z.^2).^0.5-r;
    zp=dich_solve(fxp,0,1./v2p-10^-15);
    zs=dich_solve(fxs,0,1./v2s-10^-15);
    tp=h/(v2p.*(1-v2p.^2.*zp.^2).^0.5)+d1/(v1p.*(1-v1p.^2.*zp.^2).^0.5);
    ts=h/(v2s.*(1-v2s.^2.*zs.^2).^0.5)+d1/(v1s.*(1-v1s.^2.*zs.^2).^0.5);
else
    h=d-d2;
    fxp=@(z)h*v3p*z/(1-v3p.^2.*z.^2).^0.5+...
        (d2-d1)*v2p*z/(1-v2p.^2.*z.^2).^0.5+d1*v1p*z/(1-v1p.^2.*z.^2).^0.5-r;
    fxs=@(z)h*v3s*z/(1-v3s.^2.*z.^2).^0.5+...
        (d2-d1)*v2s*z/(1-v2s.^2.*z.^2).^0.5+d1*v1s*z/(1-v1s.^2.*z.^2).^0.5-r;
    zp=dich_solve(fxp,0,1./v3p-10^-15);
    zs=dich_solve(fxs,0,1./v3s-10^-15);
    tp=h/(v3p.*(1-v3p.^2.*zp.^2).^0.5)+...
        +(d2-d1)/(v2p.*(1-v2p.^2.*zp.^2).^0.5)+d1/(v1p.*(1-v1p.^2.*zp.^2).^0.5);
    ts=h/(v3s.*(1-v3s.^2.*zs.^2).^0.5)+...
        +(d2-d1)/(v2s.*(1-v2s.^2.*zp.^2).^0.5)+d1/(v1s.*(1-v1s.^2.*zs.^2).^0.5);
end