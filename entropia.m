function [ hh,efekt ] = entropia(l_znak,kod)
%wyliczenie wektora prawdopodobienstwa wystepowania znaku

probab=((l_znak)./sum(l_znak));
%obliczenie entropii oraz dlugosci kodu
for i=1:length(l_znak)
    L(i)=probab(i)*length(kod{i});
    H(i)=-(probab(i)*log2(probab(i)));
end
L=sum(L);

hh=sum(H);
%wyznaczenie efektywnosci ciagu kodowego
efekt=(hh*100)/L;

end

