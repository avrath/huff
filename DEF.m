function [zdekodowany,kod,ilosc_znakow,znaki,slownik]=DEF(tekst)

global ZAKODOWANE_ZNAKI   %zmienne globalne potrzebne do wymiany danych z funckj¹ 'kodowanie'
   
bez_powt=unique(tekst); 

for i=1:length(bez_powt)    
    ilosc_znakow(i) = length(find(tekst == bez_powt(i)));
    znaki{i} = bez_powt(i);
end




%znaki, ktore moga wystapic
znaki2={'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '!' '"' '#' '$' '%' '&' '''' '(' ')' '^' '+' ',' '-' '.' '/' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' ':' ';' '<' '=' '>' '?' '@' ' '};
pozycja=0;
for i=1:length(bez_powt)
    for j=1:length(znaki2)
        if strcmp(znaki(i),znaki2(j))
            pozycja(i)=j;
        end
    end
end

%kody kolejnych znakow, ktore moga wystapic
ZAKODOWANE_ZNAKI={ 
    '10111110' 
    '011000000'
    '011011110'
    '101101011'
    '101101111'
    '0110001111'
    '0110001000'
    '101101010'
    '011011000'
    '1111101110'
    '01100011100'
    '0110100101'
    '10110110'
    '011010001'
    '0110100100'
    '111110010'
    '1111101111110'
    '111110011'
    '11111010'
    '00110010'
    '01101111100'
    '011011111010'
    '0110100111'
    '01101111101101'
    '0110001001'
    '011011111011111'
    '0001'
    '0110101'
    '10001'
    '11110'
    '0111'
    '000001'
    '111111'
    '00111'
    '1100'
    '1011011100'
    '01101101'
    '00001'
    '001101'
    '1101'
    '1110'
    '000000'
    '01101100101'
    '1001'
    '1010'
    '0010'
    '011001'
    '0011000'
    '101100'
    '0110111111'
    '101110'
    '1011011101'
    '0110111110111100'
    '11111000'
    '0110111110111101001001'
    '01100011101'
    '01101111101111011'
    '01101111101100'
    '011010000'
    '01101001100'
    '01101001101'
    '111110111110'
    '011011111011110101'
    '100001'
    '10110100'
    '100000'
    '01101111101110'
    '1011110'
    '01101110'
    '00110011'
    '011000101'
    '011000110'
    '01100001'
    '111110110'
    '0110110011'
    '011000001'
    '10111111'
    '01101100100'
    '11111011110'
    '01101111101111010011'
    '011011111011110100101'
    '0110111110111101000'
    '1111101111111'
    '0110111110111101001000'
    '010'
    };

for i=1:length(tekst)              %kodowanie tekstu na postawie 'sztywno' ustawionych kodow
    for k=1:length(znaki2)          
        if znaki2{k} == tekst(i)
            kod{i} = ZAKODOWANE_ZNAKI{k};
            break
        end
    end
end

for i=1:length(bez_powt)           %towrzenie slownika wystepujacych w tekscie znakow
    for k=1:length(znaki2)          
        if znaki2{k} == bez_powt(i)
            slownik{1,i} = ZAKODOWANE_ZNAKI{k};
            break
        end
    end
end
zdekodowany=dekodowanie(kod, znaki2);
end
