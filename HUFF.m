clear all;
tekst = input('tekst do zakodowania: ', 's'); 

global ZAKODOWANE_ZNAKI    
global ii
ii=0;


bez_powt=unique(tekst);  

if (length(bez_powt)>1) 
    
for i=1:length(bez_powt)    
    ilosc_znakow(i) = length(find(tekst == bez_powt(i))); 
    znaki{i} = bez_powt(i);  
end

[ilosc_znakow, index]=sort(ilosc_znakow);
for i=1:length(index)
    posortowane_znaki{i}=znaki{index(i)};
end




drzewo = cell(length(ilosc_znakow), 1);


for i = 1:length(ilosc_znakow)
   drzewo{i} = i;              
end


while length(ilosc_znakow) > 2
   [ilosc_znakow, index] = sort(ilosc_znakow);
   ilosc_znakow(2) = ilosc_znakow(1) + ilosc_znakow(2);  
   ilosc_znakow(1) = [];           
   
   drzewo = drzewo(index);            
   drzewo{2} = {drzewo{1}, drzewo{2}}; 
   drzewo(1) = [];           
end

kodowanie(drzewo, []) 

for i=1:length(tekst)               
    for k=1:length(posortowane_znaki)
        if posortowane_znaki{k} == tekst(i)
            kod{i} = ZAKODOWANE_ZNAKI{k};
            break
        end
    end
end

else 
    for i=1:length(tekst) 
    posortowane_znaki{i}=bez_powt;
    ZAKODOWANE_ZNAKI{i}=('1');  
    %kod{i}=ZAKODOWANE_ZNAKI{i};
    end
    
    kod=ZAKODOWANE_ZNAKI
end

zdekodowany=dekodowanie(kod, posortowane_znaki);
