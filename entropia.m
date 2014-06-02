function [ H,efekt,probab ] = entropia(slownik,probab)
%wyliczenie wektora prawdopodobienstwa wystepowania znaku
slownik;
probab;
%probab=cell2mat(slownik(:,2))';
%probab=probab./sum(probab);
L=0;H=0;
for i=1:length(probab)
    L=L+probab(i)*length(slownik{i,1});
    H=H+-(probab(i)*log2(probab(i)));
end
%wyznaczenie efektywnosci ciagu kodowego
efekt=(H*100)/L;

end

