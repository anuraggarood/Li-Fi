function varargout = trans_gui_lifi(varargin)
% TRANS_GUI_LIFI MATLAB code for trans_gui_lifi.fig
%      TRANS_GUI_LIFI, by itself, creates a new TRANS_GUI_LIFI or raises the existing
%      singleton*.
%
%      H = TRANS_GUI_LIFI returns the handle to a new TRANS_GUI_LIFI or the handle to
%      the existing singleton*.
%
%      TRANS_GUI_LIFI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANS_GUI_LIFI.M with the given input arguments.
%
%      TRANS_GUI_LIFI('Property','Value',...) creates a new TRANS_GUI_LIFI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trans_gui_lifi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trans_gui_lifi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trans_gui_lifi

% Last Modified by GUIDE v2.5 17-Mar-2017 17:48:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trans_gui_lifi_OpeningFcn, ...
                   'gui_OutputFcn',  @trans_gui_lifi_OutputFcn, ...
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


% --- Executes just before trans_gui_lifi is made visible.
function trans_gui_lifi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trans_gui_lifi (see VARARGIN)

% Choose default command line output for trans_gui_lifi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trans_gui_lifi wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global s
s=serial('COM8','BaudRate',4800);
%set(s,'Terminator','CR');
fopen(s);




% --- Outputs from this function are returned to the command line.
function varargout = trans_gui_lifi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a b c im s
[a,b]=uigetfile('*jpg','load images');
c=strcat(b,a);
im=imread(c);

axes(handles.axes1);
im=rgb2gray(im);
imshow(im);

fprintf('initlize');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im s

a=size(im,1);
b=size(im,2);
if (a>=255)
    a=250;
    im=imresize(im,[a b]);
end

if(b>=255)
    b=250;
    im=imresize(im,[a,b]);
end
    
 fwrite(s,a); 
pause(0.01);

 fwrite(s,b); 
pause(0.01);

for i=1:a
    for j=1:b
    fwrite(s,im(i,j));    
    disp(im(i,j));
    pause(0.01);
    
    end
end

%fprintf(s,'%s','done');




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s video z a1
a1=[];
filename = 'rhinos.avi';
video= VideoReader(filename);
frame=video.NumberOfFrames;

if (frame>=10)
    frame=10;
end
fwrite(s,frame);
pause(0.01);
for i=1:frame
    z=read(video,i);
    z=rgb2gray(z);
    
    a=size(z,1);
b=size(z,2);
if (a>=25)
    a=25;
    z=imresize(z,[a b]);
end

if(b>=25)
    b=25;
    z=imresize(z,[a,b]);
end
a1(:,:,k)=z;
    
 fwrite(s,a); 
pause(0.01);

 fwrite(s,b); 
pause(0.01);

for i=1:a
    for j=1:b
    fwrite(s,z(i,j));    
    disp(z(i,j));
    pause(0.01);
    
    end
end

%fprintf(s,'%s','done');

end
axes(handles.axes1);
for k=1:frame
imshow(a1(:,:,k));
end
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s
fclose(s);
delete(s);
