function varargout = shiyan3(varargin)
% SHIYAN5 M-file for shiyan5.fig
%      SHIYAN5, by itself, creates a new SHIYAN5 or raises the existing
%      singleton*.
%
%      H = SHIYAN5 returns the handle to a new SHIYAN5 or the handle to
%      the existing singleton*.
%
%      SHIYAN5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHIYAN5.M with the given input arguments.
%
%      SHIYAN5('Property','Value',...) creates a new SHIYAN5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shiyan5_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shiyan5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shiyan5

% Last Modified by GUIDE v2.5 09-Dec-2011 10:47:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shiyan3_OpeningFcn, ...
                   'gui_OutputFcn',  @shiyan3_OutputFcn, ...
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


% --- Executes just before shiyan5 is made visible.
function shiyan3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shiyan5 (see VARARGIN)

% Choose default command line output for shiyan5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shiyan5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shiyan3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_enter.
function pb_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pb_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);
shiyan3_ex;

% --- Executes on button press in pb_back.
function pb_back_Callback(hObject, eventdata, handles)
% hObject    handle to pb_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);
xhxt_main;

% --- Executes on button press in pb_help.
function pb_help_Callback(hObject, eventdata, handles)
% hObject    handle to pb_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
