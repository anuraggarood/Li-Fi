function varargout = recive_optical(varargin)
% RECIVE_OPTICAL MATLAB code for recive_optical.fig
%      RECIVE_OPTICAL, by itself, creates a new RECIVE_OPTICAL or raises the existing
%      singleton*.
%
%      H = RECIVE_OPTICAL returns the handle to a new RECIVE_OPTICAL or the handle to
%      the existing singleton*.
%
%      RECIVE_OPTICAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECIVE_OPTICAL.M with the given input arguments.
%
%      RECIVE_OPTICAL('Property','Value',...) creates a new RECIVE_OPTICAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recive_optical_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recive_optical_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recive_optical

% Last Modified by GUIDE v2.5 17-Mar-2017 22:42:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recive_optical_OpeningFcn, ...
                   'gui_OutputFcn',  @recive_optical_OutputFcn, ...
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


% --- Executes just before recive_optical is made visible.
function recive_optical_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recive_optical (see VARARGIN)

% Choose default command line output for recive_optical
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recive_optical wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global s 
set(handles.text1,'String','Wait System initilize');
fprintf('Wait System initilize\n');
s=serial('COM7','Baudrate',4800);
%set(s,'Terminator','CR');
fopen(s);
set(handles.text1,'String','System initilize done');
fprintf('System initilize Dne\n');
% --- Outputs from this function are returned to the command line.
function varargout = recive_optical_OutputFcn(hObject, eventdata, handles) 
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
global s a

    a=[];
    i=1;
    j=1;
    set(handles.text1,'String','datarecving start');
    fprintf('Data reading Start \nnow start the transmitter');
    
    while(s.BytesAvailable==0)
    end

    c=fread(s,[1 1],'uint8');
    disp(c)
    while(s.BytesAvailable==0)
    end
        b=fread(s,[1 1],'uint8');
    disp(b)
    while 1
        if(s.BytesAvailable>0)
           a(i,j)=fread(s,[1 1],'uint8');
           disp(a(i,j));
           disp(i);
           disp(j);
          if(i==c && j==b)
              disp(i);
              disp(j);
               break;
           end
           if(j==b)
               i=i+1;
               j=0;
           end
            j=j+1;
           
           
        end
    end
    set(handles.text1,'string','displaying data');
    axes(handles.axes1);
    imshow(a/255);
    disp(a);
    imwrite((a/255),'test.jpg');

    
            
    
    
    


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s
fclose(s);
delete(s);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s disp_video
    
    a=[];
    i=1;
    j=1;
    
    fprintf('Data reading Start \nnow start the transmitter');
    
    while(s.BytesAvailable==0)
    end

    frame=fread(s,[1 1],'uint8');
    disp(frame);
    
    for k=1:frame
        while(s.BytesAvailable==0)
        end

    c=fread(s,[1 1],'uint8');
    disp(c)
    while(s.BytesAvailable==0)
    end
        b=fread(s,[1 1],'uint8');
    disp(b)
    while 1
        if(s.BytesAvailable>0)
           a(i,j,k)=fread(s,[1 1],'uint8');
           disp(a(i,j,k));
           
          if(i==c && j==b)
              
               break;
           end
           if(j==b)
               i=i+1;
               j=0;
           end
            j=j+1;
           
           
        end
    end
    end
    disp_video=a;
    axes(handles.axes1);
    for k=1:frame
        
        imshow(disp_video(:,:,k));
    end
    
    


