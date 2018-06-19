function [new_modules,new_polish] =  Move3(old_polish)
k=1;
flag=0;
old=old_polish;
polisz=size(old_polish);
Kk=polisz(2);
for i=2:Kk
    
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