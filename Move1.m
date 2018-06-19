function [new_modules,new_polish] =  Move1(old_polish)
polisz=size(old_polish);
Kk=polisz(2);
for i=1:Kk
    
    if old_polish(i)<0
       if Kk<149
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