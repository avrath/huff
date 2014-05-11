function [zdekodowany] = dekodowanie(kod, posortowane_znaki)
global ZAKODOWANE_ZNAKI;

kod_string=cat(2, kod{:});   %string zawierajacy zakodowany tekst
kk=1;
iii=1;
for i=1:length(kod_string)
    if kk>i 
        kk=i;
    end
    for k=1:length(ZAKODOWANE_ZNAKI)
        if strcmpi(kod_string(kk:i),ZAKODOWANE_ZNAKI{k})    %sprawdzenie czy dany kawalek kodu pokrywa
            zdekodowany(iii)=posortowane_znaki{k};          %sie z ktoryms z slow kodowych
            iii=iii+1;
            i=i+length(ZAKODOWANE_ZNAKI{k})-1;
            kk=i+1;
            break
        end
    end
end
end
