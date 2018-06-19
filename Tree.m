clc;
clear;
module=xlsread('modules.xlsx');
net_list=xlsread('net_list.xlsx');
A= reshape(net_list.',[],1);
new= nonzeros(A);
NZ=new';
m=1;
NZsize=size(NZ);
for i=1:NZsize(2)
    k = rem(i,2);
    if k ~= 0 
        if m ~= 1
            m=m+1;
            charray(m)= NZ(i);
        end
        charray(m)= NZ(i);
    else
        m=m+1;
        charray(m)= NZ(i);
        m=m+1;
        charray(m)=';'; 
    end
end
disp(charray);
sz=size(charray);
charray(sz(2)+1)=1;
disp(charray);
  netlist = [1    18;31    54;95    18;71    23; 2    13; 9    39;28    37;99     3;77    65;77    79;83    16;63     4;35    92;52    41;61     5;94    87;87    68;76    59;39    36;21     6;42    47;98    13;22    96;74    41;79     7;96     3;32    76;25    59;5    96;32     8;45    92;58     9;57    26;50    10;48    41;88    43;11    39;5    17;53    70;12    41;78    25;13    23;30    31;89     4;14    40;68    74;94    24;84    97;78    15;68    81;16    28;14    87;16    21;14    30;81    22;57    72;20    99;17    44;76    87;90    98;18    44;13    46;24    99;66    19;25    46;79     8;48    16;25    20;62    99;48    80;75    39;48    53;10    60;21    15;78    72;45    71;22    97;56    75;23    64;79    19;31    29;69    30;24    42;31    45;57    49;61    42;25    26; 4    98;12    26;65    36;56    36;57    48;27    62;18    56;30    28;84    85;90    60;55    17;66    70;27    29;82    20;43    30;84    14;27    18;48  1];
C = unique ( [ min(netlist(:,[1,2]),[],2) max(netlist(:,[1,2]),[],2)], 'rows' );
nRows = size(netlist, 1); 
A1=ones(1,nRows);
weights=A1';
EdgeTable=table(netlist,weights,'VariableNames',{'EndNodes' 'Weight'});
disp(EdgeTable);
G = graph(EdgeTable);
plot(G);
title('Input Graph:plotted based on the inputs ');
A = adjacency(G);
[T,pred] = minspantree(G);
plot(T);
title('Minimum spanning tree of this solution');












