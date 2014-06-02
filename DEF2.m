function [kod,zdekodowany]=DEF2(tekst,slownik)
 
global ZAKODOWANE_ZNAKI       
global ii
ii=0;
slownik
for i=1:size(slownik,1)
    b=strsplit(slownik{i},'->');
    ilosc_znakow(i)=str2num(b{2});
    bez_powt(i)=cellstr(b{1});
end

bez_powt %wektor wpisanych znakow 
ilosc_znakow %wektor prawdopodobienstw



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

znaki=posortowane_znaki;
zdekodowany=dekodowanie(kod, posortowane_znaki);


%%% ustalanie "s³ownika" zakodowanych znaków na podstawie wprowadzonego ci¹gu
for i=1:length(l_znak)
    l_znakk(i)={l_znak(i)};     %dopasowanie formatu macierzy
end

slownik(:,1)=(posortowane_znaki)';
slownik(:,2)=(ZAKODOWANE_ZNAKI)';
slownik(:,3)=(l_znakk);
slownik;
end
