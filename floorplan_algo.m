clc;
clear;
K_b = 8.617*10^(-5); %Boltzmann constant to be used for simulated annealing
index=1;
cut_set=[-5,-6];
m=3;
r = randi([1 100],1,100);
module=xlsread('modules.xlsx');
[x,y]=size(module);
for i=1:x
figure(1)
title('Initial Floorplanning');
rectangle('Position',[module(i,2),module(i,3),module(i,4),module(i,5)]);
text((module(i,2)+module(i,4)/2),(module(i,3)+module(i,5)/2),num2str(i));
end
net_list=xlsread('net_list.xlsx');
pio=xlsread('PIO.xlsx');
inter=[r(1) r(2)];
opt=cut_set(randi([1,2],1,1));
poli(1,:)=[inter opt];
for j=2:100
     while m<100
        inter= [r(m) r(m+1)];
        m=m+2;
        opt=cut_set(randi([1,2],1,1));
        poli(j,:)=[inter opt];
        j=j+1;
     end
end
poli = reshape(poli.',[],1);
polish = poli';
modules=module;
netlist=net_list;
for T=2000:-200:500
    for iteration=1:30
        un_1=1;
        un_2=1;
        un_3=1;
        zip_1=1;
        initial_cost=main_cost(modules,pio);
        X=rand;
        [M,P]=M_1(polish);
        modul=modules(M,:);
        final_cost(index)=main_cost(modul,pio);
        index = index + 1;
        delta_c=final_cost-initial_cost;
        F =  exp(delta_c/(K_b*T));
        if (delta_c<0) | (X<F)
            modules=modul;
            polish=P;
            pp=size(polish);
            pseudo=zeros(pp(2),5);
            pseudo(:,1)=polish;
        for u=1:pp(2)
          if pseudo(u,1)>0
            pseudo(u,:)=modules(un_1,:);
            un_1 = un_1 + 1;
          end
        end
        for i=4:pp(2)
              if polish(i)<0
                   psz=size(pseudo);
                   for h=1:psz(1)
                             if pseudo(h,1)== polish(i)
                                 loc=h;
                             end
                   end
                  if (polish(i)== -5)
                     if (polish(i-1)>0)&(polish(i-2)>0)
                       pseudo(loc-2,2)=min([pseudo(loc-1,2) pseudo(loc-2,2)]);
                       pseudo(loc-2,3)=min([pseudo(loc-1,3) pseudo(loc-2,3)]);
                       pseudo(loc-2,4)=pseudo(loc-1,4) + pseudo(loc-2,4);
                       pseudo(loc-2,5)= max([pseudo(loc-1,5) pseudo(loc-2,5)]);
                     end
                  end
                  if (polish(i)== -6)
                     if (polish(i-1)>0)&(polish(i-2)>0)
                       pseudo(loc-2,2)=min([pseudo(loc-1,2) pseudo(loc-2,2)]);
                       pseudo(loc-2,3)=min([pseudo(loc-1,3) pseudo(loc-2,3)]);
                       pseudo(loc-2,4)=max([pseudo(loc-1,4) pseudo(loc-2,4)]);
                       pseudo(loc-2,5)=pseudo(loc-1,5) + pseudo(loc-2,5);
                      end
                  end
                  pseudo(loc-1,:)=pseudo(loc-2,:);
                  pseudo1 = pseudo( [1:loc-2,loc:end] , : );
                  p1=size(pseudo1);                
                  for iter=1:p1(1)
                     if pseudo1(iter,1)>0
                      z(zip_1,:)=pseudo1(iter,:);   
                      zip_1 = zip_1 + 1;
                     end
                  end
                  modules=z;
              end
        end
        end
        [M P]=M_2(polish);   
        modul=modules(M,:);
        final_cost(index)=main_cost(modul,pio);
        index = index + 1;
        delta_c=final_cost-initial_cost;
        F =  exp(delta_c/(K_b*T));
        if (delta_c<0) | (X<F)
        modules=modul;
        polish=P;
        pp=size(polish);
        pseudo=zeros(pp(2),5);
        pseudo(:,1)=polish;
        for u=1:pp(2)
          if pseudo(u,1)>0   
           pseudo(u,:)=modules(un_2,:);
           un_2 = un_2 + 1;
          end
        end
        for i=1:pp(2)
              if polish(i)<0
                   psz=size(pseudo);
                   for h=1:psz(1)
                             if pseudo(h,1)== polish(i)
                                 loc=h;
                             end
                   end
                  if (polish(i)== -5)
                       pseudo(loc-2,2)=min([pseudo(loc-1,2) pseudo(loc-2,2)]);
                       pseudo(loc-2,3)=min([pseudo(loc-1,3) pseudo(loc-2,3)]);
                       pseudo(loc-2,4)=pseudo(loc-1,4) + pseudo(loc-2,4);
                       pseudo(loc-2,5)= max([pseudo(loc-1,5) pseudo(loc-2,5)]);
                  end
                  if (polish(i)== -6)
                      pseudo(loc-2,2)=min([pseudo(loc-1,2) pseudo(loc-2,2)]);
                       pseudo(loc-2,3)=min([pseudo(loc-1,3) pseudo(loc-2,3)]);
                       pseudo(loc-2,4)=max([pseudo(loc-1,4) pseudo(loc-2,4)]);
                       pseudo(loc-2,5)=pseudo(loc-1,5) + pseudo(loc-2,5);
                  end
                  pseudo(loc-1,:)=pseudo(loc-2,:);
                  pseudo1 = pseudo( [1:loc-2,loc:end] , : );
                  p1=size(pseudo1);
                  for iter=1:p1(1)
                     if pseudo1(iter,1)>0
                      z(zip_1,:)=pseudo1(iter,:);   
                      zip_1 = zip_1 + 1;
                     end
                  end
                  modules=z;
              end
        end
        end
        [M P]=M_3(polish);
        modul=modules(M,:);
        final_cost(index)=main_cost(modul,pio);
        index = index + 1;
        delta_c=final_cost-initial_cost;
        F =  exp(delta_c/(K_b*T));
        if (delta_c<0) | (X<F)
            modules=modul;
            polish=P;
            pp=size(polish);
            pseudo=zeros(pp(2),5);
            pseudo(:,1)=polish;
        for u=1:pp(2)
          if pseudo(u,1)>0
            pseudo(u,:)=modules(un_3,:);
            un_3 = un_3 + 1;
          end
        end
        for i=2:pp(2)
              if polish(i)<0
                   psz=size(pseudo);
                   for h=1:psz(1)
                             if pseudo(h,1)== polish(i)
                                 loc=h;
                             end
                   end
                  if (polish(i)== -5)
                     if (polish(i-1)>0)&(polish(i)<0)
                       pseudo(loc-2,2)=min([pseudo(loc-1,2) pseudo(loc-2,2)]);
                       pseudo(loc-2,3)=min([pseudo(loc-1,3) pseudo(loc-2,3)]);
                       pseudo(loc-2,4)=pseudo(loc-1,4) + pseudo(loc-2,4);
                       pseudo(loc-2,5)= max([pseudo(loc-1,5) pseudo(loc-2,5)]);
                     end
                  end
                  if (polish(i)== -6)
                     if (polish(i-1)>0)&(polish(i)<0)
                       pseudo(loc-2,2)=min([pseudo(loc-1,2) pseudo(loc-2,2)]);
                       pseudo(loc-2,3)=min([pseudo(loc-1,3) pseudo(loc-2,3)]);
                       pseudo(loc-2,4)=max([pseudo(loc-1,4) pseudo(loc-2,4)]);
                       pseudo(loc-2,5)=pseudo(loc-1,5) + pseudo(loc-2,5);
                      end
                  end
                  pseudo(loc-1,:)=pseudo(loc-2,:);
                  pseudo1 = pseudo( [1:loc-2,loc:end] , : );
                  p1=size(pseudo1);
                  for iter=1:p1(1)
                     if pseudo1(iter,1)>0
                      z(zip_1,:)=pseudo1(iter,:);   
                      zip_1 = zip_1 + 1;
                     end
                  end
                  modules=z;
              end
        end
        end
    end
end
disp('initial cost');
disp(initial_cost);
disp('final cost');
disp(final_cost(end));
figure
plot(final_cost);
title('Simulated Annealing Result')
xlabel('Number of Iterations');
ylabel('Cost');

function Total_cost = main_cost(modules,pio)
modl=modules;
mod2=pio;
x= modl(:,2)';
y= modl(:,3)';
H= modl(:,4)';
W= modl(:,5)';
X= max(x)-min(x);
Y= max(y)-min(y);
area=X*Y;
for i=1:100
    asp(i)=  abs(H(i)-W(i)) / max([H(i) W(i)]);
    IO(i)=min([x(i) y(i)]); 
end
Wire=.5*(X+Y);
PIO= sum(IO);
penalty=sum(asp);
Total_cost=abs(1*area+10*penalty+3*Wire+6*PIO);
end
% Move 1  Swapping the two adjacent operands
function [new_modules,new_polish] =  M_1(old_polish)
polisz=size(old_polish);
for i=1:polisz(2)
    if old_polish(i)<0
       if polisz(2)<149
           if (old_polish(i-1)>0)&(old_polish(i+1)>0)
               tmp=old_polish(i-1);
               old_polish(i-1)=old_polish(i+1);
               old_polish(i+1)=tmp;
           end
       end
    end
end
new_polish=old_polish;
Ab=new_polish(new_polish >= 0);
new_modules=Ab;
end
% Complement chain of non zero length
function [new_modules,new_polish] =  M_2(old_polish)
polisz=size(old_polish);
for i=1:polisz(2)
    if old_polish(i)<0
        if old_polish(i)== -5
            old_polish(i)= -6;
        else if old_polish(i)== -6
                old_polish(i)= -5;
            end
        end
    end 
end   
new_polish=old_polish;
Ab=new_polish(new_polish >= 0);
new_modules=Ab;
end
%swap adjacent operand and operator
function [new_modules,new_polish] =  M_3(old_polish)
polisz=size(old_polish);
for i=2:polisz(2)
    if old_polish(i)<0
       if (old_polish(i-1)>0)
           tmp=old_polish(i-1);
           old_polish(i-1)=old_polish(i);
           old_polish(i)=tmp;
        end
    end
end
new_polish=old_polish;
Ab=new_polish(new_polish >= 0);
new_modules=Ab;
end
