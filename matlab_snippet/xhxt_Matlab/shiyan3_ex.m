function varargout = shiyan3_ex(varargin)
% SHIYAN3_EX M-file for shiyan3_ex.fig
%      SHIYAN3_EX, by itself, creates a new SHIYAN3_EX or raises the existing
%      singleton*.
%
%      H = SHIYAN3_EX returns the handle to a new SHIYAN3_EX or the handle to
%      the existing singleton*.
%
%      SHIYAN3_EX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHIYAN3_EX.M with the given input arguments.
%
%      SHIYAN3_EX('Property','Value',...) creates a new SHIYAN3_EX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shiyan3_ex_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shiyan3_ex_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shiyan3_ex

% Last Modified by GUIDE v2.5 09-Dec-2011 10:53:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shiyan3_ex_OpeningFcn, ...
                   'gui_OutputFcn',  @shiyan3_ex_OutputFcn, ...
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


% --- Executes just before shiyan3_ex is made visible.
function shiyan3_ex_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shiyan3_ex (see VARARGIN)

% Choose default command line output for shiyan3_ex
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shiyan3_ex wait for user response (see UIRESUME)
% uiwait(handles.shiyan3_ex);


% --- Outputs from this function are returned to the command line.
function varargout = shiyan3_ex_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

a = [1 -0.5 2];
b = [1 0.4 1];

axes(handles.axes_zero_pole);
zplane(b,a);
title('系统零极点图');

% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string','1 -0.5 2');

function edit_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a as text
%        str2double(get(hObject,'String')) returns contents of edit_a as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject,'string','1 0.4 1');


function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes on button press in pb_zero_pole.
function pb_zero_pole_Callback(hObject, eventdata, handles)
% hObject    handle to pb_zero_pole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = str2num(get(handles.edit_a,'string'));
b = str2num(get(handles.edit_b,'String'));

if length(a)==0 | length(b)==0
    warndlg('请输入完整参数！','警告');
    return
end

axes(handles.axes_zero_pole);
zplane(roots(b),roots(a));
title('系统零极点图');

% --- Executes on button press in pb_back.
function pb_back_Callback(hObject, eventdata, handles)
% hObject    handle to pb_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);
shiyan3;

% --- Executes on button press in pb_exit.
function pb_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pb_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pb_zero_pole.
function pb_zero_pole_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pb_zero_pole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
