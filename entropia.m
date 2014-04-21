function [ hh,efekt ] = entropia(kod,l_znak,znaki,slownik )
%ENTROPIA Summary of this function goes here
%   Detailed explanation goes here
%tekst='ala ma kota';
%[kod,slownik,l_znak,znaki]=HUFF2(tekst);
l_znak;
znaki;
slownik;
probab=((cell2mat(slownik(:,3)))./sum(cell2mat(slownik(:,3))))';

for i=1:length(l_znak)
    L(i)=probab(i)*length(slownik{i,2});
    H(i)=-(probab(i)*log2(probab(i)));
end
ll=sum(L);
hh=sum(H);
efekt=(hh*100)/ll;

end

