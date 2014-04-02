clear all;
tekst = input('tekst do zakodowania: ', 's'); 

bez_powt=unique(tekst); %w bez_powt sa te same dane co w tekst, ale bez powtorzen 


for i=1:length(bez_powt)    
    ilosc_znakow(i) = length(find(tekst==bez_powt(i))); %ilosc kolejnych znakow w tekscie
    znaki{i} = bez_powt(i);  
end

[ilosc_znakow, index]=sort(ilosc_znakow)
for i=1:length(index)
    posortowane_znaki{i}=znaki{index(i)};
end