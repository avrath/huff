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

% Last Modified by GUIDE v2.5 11-Apr-2014 23:27:53

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
%{
if (length(znakii)<2)                   %je�li ci�g ma 1 znak -> wsz�dzie
                                        %komunikat o b��dzie
    set(handles.kod,'string','Za krotki kod!');
    set(handles.dl_kodu,'string','Za krotki kod!');
    set(handles.entropia,'string','Za krotki kod!');
    set(handles.efektywnosc,'string','Za krotki kod!');
    set(handles.slownik,'string','Za krotki kod!');
    set(handles.odkodowany,'string','Za krotki kod!');
else
%}
    [kod,slownik,l_znak,znaki,odkod]=HUFF(znakii);  %wykonanie funkcji kodowania
                                    %oraz zawartej na ko�cu dekodowania                                                    %dekodowania
    set(handles.kod,'String',cell2mat(kod));        %wy�wietlenie kodu
    set(handles.odkodowany,'string',odkod);   
 
    for i=1:size(slownik,1)                         %ustalenie macierzy s�ownika oraz 
                                                    %wpisanie w okno
        sloownik{i}=[slownik{i,1},' -> ', slownik{i,2}];
    end
    set(handles.slownik,'String',sloownik);
    
    [H,efekt]=entropia(kod,l_znak,znaki,slownik);   %funkcja entropia oraz wpisanie zmiennych do okien
    set(handles.entropia,'string',H);
    set(handles.efektywnosc,'string',efekt);
    set(handles.dl_kodu,'string',length(cell2mat(kod)));
    
   
    
    clear all;
%end




% --- Executes on button press in gneruj_slow.
function gneruj_slow_Callback(hObject, eventdata, handles)
% hObject    handle to gneruj_slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on selection change in slownik.
function slownik_Callback(hObject, eventdata, handles)
% hObject    handle to slownik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns slownik contents as cell array
%        contents{get(hObject,'Value')} returns selected item from slownik


% --- Executes during object creation, after setting all properties.
function slownik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slownik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

