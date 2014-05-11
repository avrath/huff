function kodowanie(drzewo, znak)

%uzycie zmiennych globalnych, poniewaz potrzeba zeby byly znane
%poszczegolnym rekurencyjnym wywolaniom funkcji

global ZAKODOWANE_ZNAKI;
global ii;

if isa(drzewo, 'cell')   %sprawdzenie czy komorka, czy konkretna wartosc
   kodowanie(drzewo{1}, [znak 0])    % rekurencja, wbijanie sie 'glebiej' az nie bedzie juz
   kodowanie(drzewo{2}, [znak 1])    % komorek i przypisywanie '0' lub '1'
else
   ii=ii+1;
   ZAKODOWANE_ZNAKI{ii} = char('0'+znak);  %jesli wartosc, to tylko przypisanie '0' lub '1'
end