function [kod,zdekodowany,sloownik]=DEF2(tekst,slownik,handles)

global ZAKODOWANE_ZNAKI       
global ii
ii=0;
for i=1:size(slownik,1)
    b=strsplit(slownik{i},'->');
    ilosc_znakow(i)=str2num(b{2}); %wektor prawdopodobienstw
    str(i)=cellstr(b{1});
end

if (sum(ilosc_znakow)~=1)
    set(handles.err,'visible','on');
    set(handles.err,'string','Suma podanych prawdopodobieñstw ró¿na od 1. ');
    kod={2};
    zdekodowany=0;
    sloownik=0;
    return;
else
    set(handles.err,'visible','off');
    set(handles.err,'string','');  
end
uniq=unique(str);
bez_powt=unique(tekst); %wektor wpisanych znakow 

[n]=sprawdz(uniq,bez_powt,handles.err);
if n~=0
    set(handles.err,'visible','on');    
    kod={2};
    zdekodowany=0;
    sloownik=0;
    return;
else
    set(handles.err,'visible','off');
end
            
       
if (length(bez_powt)>1) %dla kodu zawieraj¹cego te same znaki specjalny przypadek
    
for i=1:length(bez_powt)    
    znaki{i} = bez_powt(i);  
end

[ilosc_znakow, index]=sort(ilosc_znakow);       %Sortowanie znakow i wystapien
for i=1:length(index)
    posortowane_znaki{i}=znaki{index(i)};
end

l_znak=ilosc_znakow;


drzewo = cell(length(ilosc_znakow), 1);

%{
for i = 1:length(ilosc_znakow)
   drzewo{i} = i;              
end
%}

while length(ilosc_znakow) > 2
   [ilosc_znakow, index] = sort(ilosc_znakow);       %Sortowanie ilosci wystapien znakow
   ilosc_znakow(2) = ilosc_znakow(1) + ilosc_znakow(2);   %Dodanie dwoch najmniejszych
   ilosc_znakow(1) = [];                                %Kasowanie komorki zawierajacej mniejsza liczbe
   
   drzewo = drzewo(index);                  %Sortowanie drzewa
   drzewo{2} = {drzewo{1}, drzewo{2}}; 
   drzewo(1) = [];           
end

kodowanie(drzewo, [])     %wywolanie rekurencyjnej funkcji generujacej kod na podstawie tablicy 'drzewo'

for i=1:length(tekst)               
    for k=1:length(posortowane_znaki)       %petla sprawdzajaca po kolei znaki we wprowadzonym tekscie
        if posortowane_znaki{k} == tekst(i)     %i tworzaca tablice odpowiadajacych im kodow
            kod{i} = ZAKODOWANE_ZNAKI{k};
            break
        end
    end
end

else          %wystepuje tylko 1 rodzaj znakow; przypadek specjalny
    for i=1:length(tekst)       
        posortowane_znaki{i}=bez_powt;  
        ZAKODOWANE_ZNAKI{i}=('1');      %przypisujemy "na sztywno" jedynke
    end
    l_znak=1;
    kod=ZAKODOWANE_ZNAKI;
end

zdekodowany=dekodowanie(kod, posortowane_znaki);


%%% ustalanie "s³ownika" zakodowanych znaków na podstawie wprowadzonego ci¹gu
for i=1:length(l_znak)
    l_znakk(i)={l_znak(i)};     %dopasowanie formatu macierzy
end

sloownik(:,1)=(posortowane_znaki)';
sloownik(:,2)=(ZAKODOWANE_ZNAKI)';
sloownik(:,3)=(l_znakk);

end
