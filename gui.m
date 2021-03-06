function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 02-Jun-2014 18:30:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;






function podaj_ciag_Callback(hObject_podaj_ciag, eventdata, handles)
% hObject    handle to podaj_ciag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of podaj_ciag as text
%        str2double(get(hObject,'String')) returns contents of podaj_ciag as a double




% --- Executes during object creation, after setting all properties.
function podaj_ciag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to podaj_ciag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in generuj.
function generuj_Callback(hObject, eventdata, handles)
% hObject    handle to generuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

znakii=get(handles.podaj_ciag,'String');    %pobranie wpisanego ci�gu
if isempty(znakii)                          %sprawdzenie czy podano ci�g, wywo�anie funkcji
    zeruj(handles);                         %czyszcz�cej wszelkie pola i wy�wietlenie b��du
    set(handles.err,'visible','on');
    set(handles.err,'string','Nie podano �adnego ci�gu kodowego');
    return;
else
    set(handles.err,'visible','off');
end
[kod,slownik,odkod]=HUFF(znakii);  %wykonanie funkcji kodowania
                                    %oraz zawartej na ko�cu dekodowania
                                    %dekodowania
set(handles.kod,'String',cell2mat(kod));        %wy�wietlenie kodu
set(handles.odkodowany,'string',odkod);   
    
probab=cell2mat(slownik(:,3))';
probab=probab./sum(probab);

[H,efekt]=entropia(slownik(:,2),probab);   %funkcja entropia oraz wpisanie zmiennych do okien
for i=1:size(slownik,1)                         %ustalenie macierzy s�ownika oraz 
                                                    %wpisanie w okno
    sloownik{i}=[slownik{i,1},' (',sprintf('%.4f',probab(i)),') -> ', slownik{i,2}];
end
set(handles.slownik,'String',sloownik);   
set(handles.entropia,'string',sprintf('%.3f',H));
set(handles.efektywnosc,'string',sprintf('%.2f [%%]',efekt));
set(handles.dl_kodu,'string',length(cell2mat(kod)));
    
clear all;


% --- Executes on button press in gneruj_slow.
function gneruj_slow_Callback(hObject, eventdata, handles)
% hObject    handle to gneruj_slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
znaki=get(handles.podaj_ciag,'string'); 
if isempty(znaki)                       
    zeruj(handles);                     
    set(handles.err,'visible','on');
    set(handles.err,'string','Nie podano �adnego ci�gu kodowego');
    return;
else
    set(handles.err,'visible','off');
end

[odkod,kod,l_znak,symbole,ciagii]=DEF(znaki);

slowniczek(1,:)=ciagii;         %%przygotowanie macierzy do przekazania do funkcji entropia
for i=1:length(l_znak)
    slowniczek(i,2)={l_znak(i)};
end
set(handles.kod,'string',cell2mat(kod));    %wy�wietlenie danych na ekran
set(handles.odkodowany,'string',odkod);
set(handles.dl_kodu,'string',length(cell2mat(kod)));

probab=cell2mat(slowniczek(:,2))';  %obliczanie prawdopodobie�stwa wyst�pie� znak�w
probab=probab./sum(probab);
set(handles.entropia,'string','');
set(handles.efektywnosc,'string','');

for i=1:length(symbole)                         %ustalenie macierzy s�ownika oraz 
                                                    %wpisanie w okno
        slownik{i}=[symbole{i},' (',sprintf('%.4f',probab(i)),') -> ', ciagii{i}];
end
    set(handles.slownik,'String',slownik);
    
clear all;

% --- Executes on button press in gen_slow_2.
function gen_slow_2_Callback(hObject, eventdata, handles)
% hObject    handle to gen_slow_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
znaki=get(handles.podaj_ciag,'string');
sloownik=get(handles.user_slow,'String');
if isempty(znaki)
    zeruj(handles);
    set(handles.err,'visible','on');
    set(handles.err,'string','Nie podano �adnego ci�gu kodowego');
    return;
else
    set(handles.err,'visible','off');
end
if (isempty(sloownik) && ~isempty(znaki))       %sprawdzenie czy zosta�y wprowadzone dane do s�ownika
    zeruj(handles);                             %je�li nie - wywo�anie funkcji jak poprzednio.
    set(handles.err,'visible','on');
    set(handles.err,'string','S�ownik jest pusty');
    return;
else
    set(handles.err,'visible','off');
end
[kod,odkod,slownik]=DEF2(znaki,sloownik,handles);   %wykonanie funkcji koduj�cej i odkodowuj�cej
if (kod{1} == 2)                    %oraz sprawdzenie, czy funkcja zosta�a zako�czona poprawnie
    zeruj(handles);
    return;
end
                     %%przygotowanie tablicy do przekazania do funkcji entropia
for i=1:size(slownik,1)
    slowniczek{i}=[slownik{i,1},' (',sprintf('%.4f',slownik{i,3}),') -> ', slownik{i,2}];
end

set(handles.slownik,'string',slowniczek);
set(handles.kod,'string',cell2mat(kod));
set(handles.odkodowany,'string',odkod);
set(handles.dl_kodu,'string',length(cell2mat(kod)));
[H,efekt]=entropia(slownik(:,2),cell2mat(slownik(:,3))');
set(handles.entropia,'string',sprintf('%.3f',H));
set(handles.efektywnosc,'string',sprintf('%.2f [%%]',efekt));

clear all;

% --- Executes on button press in add_slow.
function add_slow_Callback(hObject, eventdata, handles)
% hObject    handle to add_slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
licznik=get(handles.licznik,'value');  
znak=get(handles.znak,'String');
user_slow{licznik,1}=znak;      %pobranie znaku i jego prawdopodobie�stwa oraz dodanie
prawdopodobienstwo=get(handles.prawdopodobienstwo,'String');    %do w�a�ciwego s�ownika
user_slow{licznik,2}=prawdopodobienstwo;
if licznik>1
    slow=get(handles.user_slow,'String');
end
slow{licznik}=[user_slow{licznik,1},' -> ',user_slow{licznik,2}];
licznik=licznik+1;
set(handles.licznik,'Value',(licznik)); 
set(handles.user_slow,'String',slow);


% --- Executes on button press in clc_slow.
function clc_slow_Callback(hObject, eventdata, handles)
% hObject    handle to clc_slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.licznik,'Value',1);
set(handles.user_slow,'String','');     %wyczyszczenie s�ownika wprowadzonych danych
clear all;



% --- Executes on selection change in odkodowany.
function odkodowany_Callback(hObject, eventdata, handles)
% hObject    handle to odkodowany (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns odkodowany contents as cell array
%        contents{get(hObject,'Value')} returns selected item from odkodowany


% --- Executes during object creation, after setting all properties.
function odkodowany_CreateFcn(hObject, eventdata, handles)
% hObject    handle to odkodowany (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in kod.
function kod_Callback(hObject_kod, eventdata, handles)
% hObject    handle to kod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns kod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from kod


% --- Executes during object creation, after setting all properties.
function kod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function slownik_Callback(hObject, eventdata, handles)

function slownik_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function znak_Callback(hObject, eventdata, handles)

function znak_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prawdopodobienstwo_Callback(hObject, eventdata, handles)

function prawdopodobienstwo_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in user_slow.
function user_slow_Callback(hObject, eventdata, handles)
% hObject    handle to user_slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns user_slow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from user_slow


% --- Executes during object creation, after setting all properties.
function user_slow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to user_slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
