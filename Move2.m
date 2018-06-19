function [new_modules,new_polish] =  Move2(old_polish)
polisz=size(old_polish);
Kk=polisz(2);
for i=1:Kk
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