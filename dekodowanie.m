function [zdekodowany] = dekodowanie(kod, posortowane_znaki)
global ZAKODOWANE_ZNAKI;

kod_string=cat(2, kod{:});            
kk=1;
iii=1;
for i=1:length(kod_string)
    if kk>i 
        kk=i;
    end
    for k=1:length(ZAKODOWANE_ZNAKI)
        if strcmpi(kod_string(kk:i),ZAKODOWANE_ZNAKI{k}) 
            zdekodowany(iii)=posortowane_znaki{k};
            iii=iii+1;
            i=i+length(ZAKODOWANE_ZNAKI{k})-1;
            kk=i+1;
            break
        end
            
            
   
    end
end
end
