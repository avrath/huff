clear all;
tekst = input('tekst do zakodowania: ', 's'); 

bez_powt=unique(tekst); 
    
for i=1:length(bez_powt)    
    ilosc_znakow(i) = length(find(tekst == bez_powt(i))); 
    znaki{i} = bez_powt(i);  
end

[ilosc_znakow, index]=sort(ilosc_znakow);
for i=1:length(index)
    posortowane_znaki{i}=znaki{index(i)};
end

ilosc_znakow
posortowane_znaki