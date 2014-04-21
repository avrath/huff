function [ hh,efekt ] = entropia(kod,l_znak,znaki,slownik )
%wyliczenie wektora prawdopodobienstwa wystepowania znaku
probab=((cell2mat(slownik(:,3)))./sum(cell2mat(slownik(:,3))))';

%obliczenie entropii oraz dlugosci kodu
for i=1:length(l_znak)
    L(i)=probab(i)*length(slownik{i,2});
    H(i)=-(probab(i)*log2(probab(i)));
end
ll=sum(L);
hh=sum(H);
%wyznaczenie efektywnosci ciagu kodowego
efekt=(hh*100)/ll;

end

