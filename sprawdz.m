function [spr]=sprawdz(lista,tekst,handles)
n=length(lista);
m=length(tekst);
k=n-m;
if k<0
    k=-1;
elseif k>0
    k=1;
else
    k=0;
end
switch k
    case -1
        spr=-1;
        set(handles,'string','Wprowadzono znak spoza s³ownika ');
    case 1
       spr=1;
       set(handles,'string','Za du¿o danych w s³owniku ');
    case 0
        licznik=0;
        for i=1:n
            for j=1:n
                if strcmp(lista(i),tekst(j))
                    licznik=licznik+1;
                end
            end
        end
        if licznik==n
            spr=0;
        else
            spr=1;
            set(handles,'string','Wprowadzono znak spoza s³ownika ');
        end
    otherwise
        spr=100;
        set(handles,'string','Wyst¹pi³ nieokreœlony b³¹d ');
end

end