function [ H,efekt] = entropia(slownik,probab)
L=0;    %wstêpne zdefiniowanie entropii i d³ugoœci kodu, a nastêpnie wyliczenie tych wartoœci
H=0;
for i=1:length(probab)
    L=L+probab(i)*length(slownik{i,1});
    H=H+-(probab(i)*log2(probab(i)));
end
%wyznaczenie efektywnosci ciagu kodowego
efekt=(H*100)/L;

end

