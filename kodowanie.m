function kodowanie(drzewo, znak)

global ZAKODOWANE_ZNAKI;
global ii;

if isa(drzewo, 'cell')   
   kodowanie(drzewo{1}, [znak 0])    
   kodowanie(drzewo{2}, [znak 1])    
else
   ii=ii+1;
   ZAKODOWANE_ZNAKI{ii} = char('0'+znak);  
end