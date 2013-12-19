function varargout = shiyan1_ex(varargin)
% SHIYAN1_EX M-file for shiyan1_ex.fig
%      SHIYAN1_EX, by itself, creates a new SHIYAN1_EX or raises the existing
%      singleton*.
%
%      H = SHIYAN1_EX returns the handle to a new SHIYAN1_EX or the handle to
%      the existing singleton*.
%
%      SHIYAN1_EX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHIYAN1_EX.M with the given input arguments.
%
%      SHIYAN1_EX('Property','Value',...) creates a new SHIYAN1_EX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shiyan1_ex_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shiyan1_ex_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shiyan1_ex

% Last Modified by GUIDE v2.5 28-Sep-2004 15:57:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shiyan1_ex_OpeningFcn, ...
                   'gui_OutputFcn',  @shiyan1_ex_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before shiyan1_ex is made visible.
function shiyan1_ex_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shiyan1_ex (see VARARGIN)

% Choose default command line output for shiyan1_ex
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shiyan1_ex wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shiyan1_ex_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
n=[-20:20];
% 

set(handles.popmenu_xh1,'value',1);
axes(handles.axes_xh1);
stem(n,(n==0));

set(handles.popmenu_xh2,'value',1);
axes(handles.axes_xh2);
stem(n,(n==0));


% --- Executes during object creation, after setting all properties.
function popmenu_xh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popmenu_xh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% set(hObject,'value',1);


% --- Executes on selection change in popmenu_xh1.
function popmenu_xh1_Callback(hObject, eventdata, handles)
% hObject    handle to popmenu_xh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popmenu_xh1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popmenu_xh1

xhid=get(hObject,'value');
axes(handles.axes_xh1);
set(handles.text6,'string','频率');
n=[-20:20];
n1=[-10:10];
switch xhid
    case 1
         stem(n,(n==0));
         set(handles.edit_am1,'string',1);
         set(handles.edit_freq1,'string',' ');
         set(handles.edit_phase1,'string',0);
    case 2
        stem(n,(n>=0));
        set(handles.edit_am1,'string',1);
        set(handles.edit_freq1,'string',' ');
        set(handles.edit_phase1,'string',0);
    case 3
        stem(n,sin(pi/4*n));
        set(handles.edit_am1,'string',1);
        set(handles.edit_freq1,'string','0.125');
        set(handles.edit_phase1,'string',0);
    case 4
        stem(n1,exp(0.125*n1));
        set(handles.text6,'string','指数');
        set(handles.edit_am1,'string',1);
        set(handles.edit_freq1,'string','0.125 ');
        set(handles.edit_phase1,'string',0);
    case 5
        stem(n,sawtooth(2*pi*0.1*n));
        set(handles.edit_am1,'string',1 );
        set(handles.edit_freq1,'string',0.1);
        set(handles.edit_phase1,'string',0);
    case 6
        stem(n,square(2*pi*0.1*n));
        set(handles.edit_am1,'string',1);
        set(handles.edit_freq1,'string',0.1);
        set(handles.edit_phase1,'string',0);
end

% --- Executes during object creation, after setting all properties.
function popmenu_xh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popmenu_xh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'value',1);

% --- Executes on selection change in popmenu_xh2.
function popmenu_xh2_Callback(hObject, eventdata, handles)
% hObject    handle to popmenu_xh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popmenu_xh2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popmenu_xh2
xhid=get(hObject,'value');
axes(handles.axes_xh2);
set(handles.text9,'string','频率');
n=[-20:20];
n1=[-10:10];
switch xhid
    case 1
         stem(n,(n==0));
         set(handles.edit_am2,'string',1);
         set(handles.edit_freq2,'string',' ');
         set(handles.edit_phase2,'string',0);
    case 2
        stem(n,(n>=0));
        set(handles.edit_am2,'string',1);
        set(handles.edit_freq2,'string',' ');
        set(handles.edit_phase2,'string',0);
    case 3
        stem(n,sin(pi/4*n));
        set(handles.edit_am2,'string',1);
        set(handles.edit_freq2,'string','0.125');
        set(handles.edit_phase2,'string',0);
    case 4
        stem(n1,exp(0.125*n1));
        set(handles.text9,'string','指数');
        set(handles.edit_am2,'string',1);
        set(handles.edit_freq2,'string','0.125');
        set(handles.edit_phase2,'string',0);
   case 5
        stem(n,sawtooth(2*pi*0.1*n));
        set(handles.edit_am2,'string',1 );
        set(handles.edit_freq2,'string',0.1);
        set(handles.edit_phase2,'string',0);
    case 6
        stem(n,square(2*pi*0.1*n));
        set(handles.edit_am2,'string',1);
        set(handles.edit_freq2,'string',0.1);
        set(handles.edit_phase2,'string',0);
end

% --- Executes during object creation, after setting all properties.
function edit_phase1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


set(hObject,'string',0);

function edit_phase1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase1 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase1 as a double


% --- Executes during object creation, after setting all properties.
function edit_freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string',' ');


function edit_freq1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq1 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq1 as a double


% --- Executes during object creation, after setting all properties.
function edit_am1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_am1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string',1);


function edit_am1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_am1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_am1 as text
%        str2double(get(hObject,'String')) returns contents of edit_am1 as a double

% --- Executes during object creation, after setting all properties.
function edit_phase2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string',0);

function edit_phase2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase2 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase2 as a double


% --- Executes during object creation, after setting all properties.
function edit_freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string',' ');

function edit_freq2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq2 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq2 as a double


% --- Executes during object creation, after setting all properties.
function edit_am2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_am2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string',1);

% --- Executes on button press in pb_xh2.
function pb_xh2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_xh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a2 = str2double(get(handles.edit_am2,'String'));
f2 = str2double(get(handles.edit_freq2,'String'));
p2 = str2double(get(handles.edit_phase2,'String'));
n1=[-10:10];
n=[-20:20];
axes(handles.axes_xh2);
xhid = get(handles.popmenu_xh2,'Value');
if p2>-20 & p2<20
switch xhid
    case 1
        stem(n,a2*((n-p1)==0));
    case 2
         stem(n,a2*((n-p1)>=0));
    case 3
        
        stem(n,a2*sin(2*pi*f2*(n-p2)));
        
    case 4
        stem(n1,a2*exp(f2*(n1-p2)));
        
   case 5
        stem(n,a2*sawtooth(2*pi*f2*(n-p2)));
        
    case 6
        stem(n,a2*square(2*pi*f2*(n-p2)));
        
end
end
% --- Executes on button press in pb_xh1.
function pb_xh1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_xh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1 = str2double(get(handles.edit_am1,'String'));
f1 = str2double(get(handles.edit_freq1,'String'));
p1 = str2double(get(handles.edit_phase1,'String'));
n1=[-10:10];
n=[-20:20];
axes(handles.axes_xh1);
xhid = get(handles.popmenu_xh1,'Value');
 if p1>-10 & p1<10
switch xhid
    case 1
         stem(n,a1*((n-p1)==0));
    case 2
         stem(n,a1*((n-p1)>=0));
    case 3
        stem(n,a1*sin(2*pi*f1*(n-p1)));
        
    case 4
        stem(n1,a1*exp(f1*(n1-p1)));
        
   case 5
        stem(n,a1*sawtooth(2*pi*f1*(n-p1)));
        
    case 6
        stem(n,a1*square(2*pi*f1*(n-p1)));
        
end
end

% --- Executes on button press in pb_sigadd.
function pb_sigadd_Callback(hObject, eventdata, handles)
% hObject    handle to pb_sigadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y1,y2]=getsigs(handles);
y=y1+y2;
n=[-20:20];
figure,stem(n,y);

% --- Executes on button press in pb_multi.
function pb_multi_Callback(hObject, eventdata, handles)
% hObject    handle to pb_multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y1,y2]=getsigs(handles);
y=y1.*y2;
n=[-20:20];
figure,stem(n,y);

% --- Executes on button press in pb_split.
function pb_split_Callback(hObject, eventdata, handles)
% hObject    handle to pb_split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=[-10:10];
y=(n>=0);
len=length(n);
for i=1:len
    y1(i)=y(len+1-i);
end
yodd=(y-y1)/2;
yeven=(y+y1)/2;
figure,subplot(2,1,1),stem(n,y);title('the unit step funtion for demo');
subplot(2,2,3),stem(n,yodd);title('the odd part of the function');
subplot(2,2,4),stem(n,yeven);title('the even part of the function');
% --- Executes on button press in pb_back.
function pb_back_Callback(hObject, eventdata, handles)
% hObject    handle to pb_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
shiyan1;

% --- Executes on button press in pb_close.
function pb_close_Callback(hObject, eventdata, handles)
% hObject    handle to pb_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function [y1,y2]=getsigs(handles)

a1 = str2double(get(handles.edit_am1,'String'));
f1 = str2double(get(handles.edit_freq1,'String'));
p1 = str2double(get(handles.edit_phase1,'String'));

a2 = str2double(get(handles.edit_am2,'String'));
f2 = str2double(get(handles.edit_freq2,'String'));
p2 = str2double(get(handles.edit_phase2,'String'));

if isnan(a1)
    a1=1;
end 
if isnan(a2)
    a2=1;
end
if isnan(f1)
    f1=1/2/pi;
end
if isnan(f2)
    f2=1/2/pi;
end
n=[-20:20];
n1=[-10:10];
axes(handles.axes_xh1);
xhid = get(handles.popmenu_xh1,'Value');
switch xhid
    case 1
         y1=a1*((n-p1)==0);
    case 2
         y1=a1*((n-p1)>=0);
    case 3
        y1=a1*sin(2*pi*f1*(n-p1));
    case 4
        y1=a1*exp(f1*(n1-p1));
        y1=[zeros(1,10) y1 zeros(1,10)];
   case 5
        y1=a1*sawtooth(2*pi*f1*(n-p1));
    case 6
        y1=a1*square(2*pi*f1*(n-p1));
end

xhid1 = get(handles.popmenu_xh2,'Value');
switch xhid1
    case 1
         y2=a2*((n-p2)==0);
    case 2
         y2=a2*((n-p2)>=0);
    case 3
        y2=a2*sin(2*pi*f2*(n-p2));
    case 4
        y2=a2*exp(f2*(n1-p2));
        y2=[zeros(1,10) y2 zeros(1,10)];
   case 5
        y2=a2*sawtooth(2*pi*f2*(n-p2));
    case 6
        y2=a2*square(2*pi*f2*(n-p2));
end


% --- Executes during object creation, after setting all properties.
function axes_xh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_xh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_xh1

% n=[-10:10];
% % axes(hObject);
% stem(n,(n==0));
% hold off

% --- Executes during object creation, after setting all properties.
function axes_xh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_xh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_xh2

% n=[-10:10];
% % axes(hObject);
% stem(n,(n==0));
% hold off
