function Total_cost = main_cost(modules,pio)
modl=modules;
mod2=pio;
x= [modl(:,[2])]';
y= [modl(:,[3])]';
H= [modl(:,[4])]';
W= [modl(:,[5])]';
X= max(x)-min(x);
Y= max(y)-min(y);
area=X*Y;
disp(area);
for i=1:100
    asp(i)=  abs(H(i)-W(i)) / max([H(i) W(i)]);
    IO(i)=min([x(i) y(i)]); 
end
Wire=.5*(X+Y);
PIO= sum(IO);
Aspt_penalty=sum(asp);
Total_cost=abs(1*area+10*Aspt_penalty+3*Wire+6*PIO);
end




