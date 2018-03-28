function varargout = GUIPart2(varargin)
% GUIPART2 MATLAB code for GUIPart2.fig
%      GUIPART2, by itself, creates a new GUIPART2 or raises the existing
%      singleton*.
%
%      H = GUIPART2 returns the handle to a new GUIPART2 or the handle to
%      the existing singleton*.
%
%      GUIPART2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIPART2.M with the given input arguments.
%
%      GUIPART2('Property','Value',...) creates a new GUIPART2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIPart2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIPart2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIPart2

% Last Modified by GUIDE v2.5 17-May-2017 22:04:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIPart2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIPart2_OutputFcn, ...
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

function setGlobalval(x,y)
    global val
	global str
    val = x;
	str = y;
	
function r = getGlobalval
   global val
   r = val;	
	
function w = getGlobalStr
   global str
   w = str;
   

% --- Executes just before GUIPart2 is made visible.
function GUIPart2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIPart2 (see VARARGIN)

% Choose default command line output for GUIPart2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIPart2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIPart2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
val = get(hObject, 'Value');
str = get(hObject, 'String');
setGlobalval(val,str);
global fileFlag;
fileFlag = false;
switch str{val}
    case 'LU decomposition'
        set(handles.nPanel,'visible','on');
    case 'All Methods'
        set(handles.nPanel,'visible','on');
    case 'Choose the method:'
        set(handles.nPanel,'visible','on');
        setGlobalval(NaN,NaN)
    otherwise
        set(handles.nPanel,'visible','on');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iterBox_Callback(hObject, eventdata, handles)
% hObject    handle to iterBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterBox as text
%        str2double(get(hObject,'String')) returns contents of iterBox as a double


% --- Executes during object creation, after setting all properties.
function iterBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsBox_Callback(hObject, eventdata, handles)
% hObject    handle to epsBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsBox as text
%        str2double(get(hObject,'String')) returns contents of epsBox as a double


% --- Executes during object creation, after setting all properties.
function epsBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%method, equation, itr, eps, numbers
[baseName, folder] = uigetfile();
try
fullFileName = fullfile(folder, baseName);
A  = Read(fullFileName);
global method;
global equation;
global fileFlag;
global itr;
global eps;
global numbers;

fileFlag = true;
method = A{1};
equation = A{2};
itr = A{3};
eps = A{4};
numbers = A{5};

disp(A)
if strcmp(equation,'/')
    h = msgbox('ENTER EQUATION!');
    return;
end
if strcmp(method,'/')
    h = msgbox('ENTER A METHOD!');
    return;
end

if strcmp(numbers,'/')
    h = msgbox('ENTER NUMBER OF EQUATIONS!');
    return;
end

if strcmp(itr,'/')
    itr = '50';
end
if strcmp(eps,'/')
    eps = '0.00001';
end
itr = str2double(itr);
eps = str2double(eps);
catch 
    h = msgbox('Error occured or file not chosen')
    fileFlag = false;
end

function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on InputTable and none of its controls.
function InputTable_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to InputTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in InputTable.
function InputTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to InputTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function nBox_Callback(hObject, eventdata, handles)
% hObject    handle to nBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nBox as text
%        str2double(get(hObject,'String')) returns contents of nBox as a double


% --- Executes during object creation, after setting all properties.
function nBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function inputArea_Callback(hObject, eventdata, handles)
% hObject    handle to inputArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputArea as text
%        str2double(get(hObject,'String')) returns contents of inputArea as a double


% --- Executes during object creation, after setting all properties.
function inputArea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function inputPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SolveBtn.
function SolveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SolveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%2*x + y + 3*z ==1, 2*x + 6*y + 8*z == 3, 6*x + 8*y+18*z==5

global method;
global equation;
global fileFlag;
global itr;
global eps;
global numbers;

val = getGlobalval;
str = getGlobalStr;
cla(handles.axes1);

try
if fileFlag == true
    n = numbers;
    equations = equation;
else
n = get(handles.nBox,'String');
equations = get(handles.inputArea,'String');
end
if(isempty(n))
    h = msgbox('ENTER NUMBER OF EQUATIONS!');
    return;
end
n = str2num(n);

if(isempty(equations))
    h = msgbox('ENTER EQUATIONS!');
    return;
end

for i = 1 : n
        x = sprintf('x%d',i);
        assignin('caller',x,sym(x));
end

C = strsplit(equations,',');
D = C.';

symbolEQS=[];
    for i = 1 : n
    S=sym(D{i}); %eqs => equ contain all the equations each on is a string
    symbolEQS=[symbolEQS;S];
    end
    
[A,B] = equationsToMatrix(symbolEQS)

if fileFlag == true
    x = method;
    maxit = itr;
else
    eps = get(handles.epsBox,'String');
    maxit = get(handles.iterBox,'String');
    if(isempty(maxit))
    maxit = '50';
    end
    if(isempty(eps))
        eps = '0.00001';
    end
    
    %if(num2str(str) == 'NaN')
     %   return;
    %end
    x = str{val};
end

eps = str2double(eps);
maxit = str2double(maxit);
catch 
    h = msgbox('ERROR!')
end
switch x
    case 'Gaussian-elimination'
        [a,x,flag,time] = GaussElimination(A,B,0,handles)
        if flag == true
            set(handles.outArea,'string',sprintf(strcat('GauessElim:','\n', char(x))));
        else 
            h = msgbox('ERROR!');
        end
    case 'LU decomposition'
        [x, flag,time] = LUDecomposition(A,B, n, eps,0,handles)
        if flag == 1;
            set(handles.outArea,'string',{'LU:',x});
        else 
            h = msgbox('ERROR!');
        end
        %set(handles.outArea,'string',strcat('LU:',char(x)));
    case 'Gaussian-Jordan'
        matrix = cat(2, A, B);
        [ answers,flag,time ] = guessJordon( matrix ,0,handles)
        if flag == 0
        set(handles.outArea,'string',strcat('GauessJordan:',char(answers)));
        else 
             h = msgbox('ERROR!');
        end
    case 'Gauss-Seidel'
        siz = size(B);
        x = zeros(siz);
        [x,flag,iterations,errors,time] = GaussSeidel(A,B,x,maxit,eps,0,handles);
        if flag == 1
        set(handles.outArea,'string',x);
        else
            h = msgbox('ERROR!');
        end
    case 'All Methods'
         siz = size(B);
         x = zeros(siz);
         matrix = cat(2, A, B);
% % % % % % % % % % % % % % % % % % % % % % %    
         disp('LU x')
         [x2, flag,time] = LUDecomposition(A, B, n, eps,1,handles)
         fileID = fopen('outFile.txt','w');
          fprintf(fileID,'\n%6s','Method Name:  ','LU');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Answer: ');
         fprintf(fileID,'\n%6f %6f %6f',x2(1), x2(2), x2(3));
        
% % % % % % % % % % % % % % % % % % % % % % %    
         disp('Gauss Jordan x')
         [ answers,flag,time ] = guessJordon( matrix,1,handles )
          fprintf(fileID,'\n---------------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Gauss Jordan');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Answer: ');
         fprintf(fileID,'\n%6f %6f %6f',double(answers(1)), double(answers(2)), double(answers(3)));
% % % % % % % % % % % % % % % % % % % % % % %          
         disp('Gauss Elimination x')
         [a,x1,flag,time] = GaussElimination(A,B,1,handles)
          fprintf(fileID,'\n---------------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Gauss Elimination');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Answer: ');
         fprintf(fileID,'\n%6f %6f %6f',double(x1(1)), double(x1(2)), double(x1(3)));
% % % % % % % % % % % % % % % % % % % % % % %  
         disp('Gauss Siedel x')
         [z,flag,iterations,error,time] = GaussSeidel(A,B,x,maxit,eps,1,handles);
         fprintf(fileID,'\n---------------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Gauss Siedel');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Answer: ');
         fprintf(fileID,'\n%6f %6f %6f',z(1), z(2), z(3));
         fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f %6f %6f',error(1), error(2), error(3));
         
         set(handles.outArea,'string',{sprintf(strcat('GauessElim:',char(x1),'\n','LU:')),x2,sprintf(strcat('\n','GauessJordan:',char(answers),'\n','GauessSeidel:')),z});

end
fileFlag = false;

% magneta
function [x,flag,iterations,errors,time] = GaussSeidel(A,B,x,maxit,ea,allMethods,handles)
flag = 1;
set(handles.outTable,'data',[]);
[na , ma ] = size (A);

if na ~= ma
   flag = 0;
    return
end
[nb , mb ] = size (B);
if nb ~= na || mb~=1
  flag = 0;
   return
end
 
[nx, mx] = size(x);
if nx ~= na || mx ~= 1
flag = 0;
return;
end
iter = 0;
iterations =[0];
xs =[0];
errs =[100];
for r=1:maxit
    max = 0;
        for i=1: na
            s=0;
            for j=1: ma
               if j ~= i
                   s = s + (A(i,j)* x(j));
               end
            end
            t=(B(i)-s)/A(i,i);
             e = double((abs(t-x(i))/t));
             if e > max
                 max = e;
             end
            x(i)=t;
            error(iter+1, i) = e;
            errs =vertcat(errs,double(vpa(e*100)));
            iterations = vertcat(iterations,r);
            xs = vertcat(xs,double(vpa(t)));
            if(allMethods == 1 && r+1<=i)
                axes(handles.axes1);
                line([r-1 r],[x(r) x(r+1)],'Color','m');
                hold on;
            end
        end
             if max < ea
                break;
             end 
        iter = r;
end
if iter > maxit
    flag = 0;
end
tab = cat(2,iterations,xs,errs);
set(handles.outTable,'data',tab );
time = toc;
errors = [errs(size(errs,1)) errs(size(errs-1,1)) errs(size(errs-2,1))]

if allMethods == 0
file (iterations,xs,errs,time);
end
hold off;
% green  
function [a,x,flag,time] = GaussElimination(a,b,allMethods,handles)
tic;
flag = 1;
set(handles.outTable,'data',[]);
[na , ma ] = size(a);
if na ~= ma
    flag = 0;
    return
end
[nb , mb ] = size (b);
if nb ~= na || mb~=1
  flag =0;
   return
end

%forward elimination
   for k = 1:  size(a,1)-1
      c = a(k:size(a,1),k);
       [maxPivot,ind] = max(c(:))   
       a([k,ind+k-1],:) = a([ind+k-1, k],:);
       b([k,ind+k-1]) = b([ind+k-1, k]);
     for i = k+1:  size(a,1)
        factor = a(i,k) / a(k,k);
        for j = k : size(a,1)
             a(i,j) = a(i,j) - factor * a(k,j);
        end
        b(i) = b(i) - factor * b(k);
     end
   end
%back substitution
   x(size(a,1)) = b(size(a,1)) / a(size(a,1),size(a,1));
   cnt = 0;
   for i = size(a,1)-1: -1 : 1
      sum = 0;
      for j = i+1 : size(a,1)
         sum = sum + a(i,j) * x(j);
      end
      x(i) = (b(i) - sum) / a(i,i);
      if(allMethods == 1 && i > 1)
            axes(handles.axes1);
            line([cnt cnt+1],[x(i) x(i-1)],'Color','g');
            cnt = cnt + 1;
            hold on;
      end
   end
   time = toc;
   if allMethods == 0
       fileID = fopen('outFile.txt','w');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Answer: ');
         fprintf(fileID,'\n%6f %6f %6f',double(x(1)), double(x(2)), double(x(3)));
   end
   
% red
function [ answers,error, time] = guessJordon( matrix,allMethods,handles )
m=matrix;
flag=0;
tic;
error = 0;
set(handles.outTable,'data',[]);
for i=1:1:size(m,1)
    m=replace(m,i,maxJ(m,i));
    if(m(i,i)==0)
        flag = 1;
    end
    m(i,:)=m(i,:)/m(i,i);
    for r=1:1:size(m,1)
       if(r~=i)
       a=m(r,i);
       m(r,:)=m(r,:)-m(i,:)*a;
       if(allMethods == 1 && i > 1)
           axes(handles.axes1);
           line([r-1 r],[m(i) m(i+1)],'Color','r');
           hold on;
        end
       end
    end
end
if(flag==0)
answers = m(:,size(m,2));
else
    error = 1;
end
time = toc
if allMethods == 0
 fileID = fopen('outFile.txt','w');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Answer: ');
         fprintf(fileID,'\n%6f %6f %6f',double(answers(1)), double(answers(2)), double(answers(3)));
end

function [ Maxindex ] = maxJ( matrix , start)
maxI=start;
a=matrix(start,start);
for n=start:1:size(matrix,1)
 if(abs(matrix(n,start))>a)
     a=abs(matrix(n,start));
     maxI=n;
 end
end
Maxindex=maxI;

function [Matrix] = replace (matrix,x,y)
Martrixp=matrix;
a=Martrixp(x,:);
Martrixp(x,:)=Martrixp(y,:);
Martrixp(y,:)=a;
Matrix=Martrixp;
% blue

function [x, flag, time] = LUDecomposition(a, b, n, tol,allMethods,handles)
 %check of the size of the arrays
 tic;
 flag = 1;
 set(handles.outTable,'data',[]);
[na , ma ] = size(a);
if na ~= ma
    flag = 0;
    return
end
[nb , mb ] = size (b);
if nb ~= na || mb~=1
  flag =0;
   return
end
 
 
    for k = 1 : (n - 1) 
	%finding pivot and changing matrix
       c = a(k:size(a,1),k);
       [maxPivot,ind] = max(c(:))
       a([k,ind+k-1],:) = a([ind+k-1, k],:);
       b([k,ind+k-1]) = b([ind+k-1, k]);
	   
       
        for i = k + 1 : n 
            factor = a(i,k) / a(k,k);
            a(i,k) = factor;
            for j = k + 1 : n
                a(i, j) = a(i, j) - factor * a(k,j);
            end
        end

    end
	
   %forward substitution 
    y = zeros(n);
    y(1) = b(1);
    for i = 2 : n 
        sum = b(i);
        for j = 1 : i - 1
            sum = sum - a(i, j) * y(j);
        end
        y(i) = sum;
    end
    x = ones([1 n]);
    x(n) = y(n) / a(n, n);
	
	%back substitution
    for i = 1 : (n - 1) 
        sum = 0;
        for j = (n - i + 1) : n
            sum = sum + a(n - i, j) * x(j);
        end
        x(n - i) = (y(n - i) - sum) / a( n - i, n - i);
        if(allMethods == 1 && i > 1)
           axes(handles.axes1);
           line([i-1 i],[x(n-i+1) x(n-i)],'Color','b');
           hold on;
        end
    end
time = toc;

if allMethods == 0
fileID = fopen('outFile.txt','w');
 fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
 fprintf(fileID,'\n%6s','Answer: ');
 fprintf(fileID,'\n%6f %6f %6f',x(1), x(2), x(3));
end    

function [  ] = file(Iterations, Roots, Errors,time)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


A =  cat(2,Iterations,Roots,Errors);
fileID = fopen('outFile.txt','w');
fprintf(fileID,'%6s','Time Elapsed:  ',time);
fprintf(fileID,'\n%6s %10s %14s\n','Iterations','Roots','Errors');
i = 1;
siz =  size(Iterations);
while(i <= siz(1))
    fprintf(fileID,'%6f %15f %12f\n',A(i,1),A(i,2),A(i,3));
    i = i+1;
end
fclose(fileID);
    
function  A  = Read( file_name ) 
fid = fopen(file_name);

tline = fgetl(fid);
i=1;
while ischar(tline)
    A{i}=tline;
    i=i+1;
    tline = fgetl(fid);
end

fclose(fid);
    
% --- Executes during object creation, after setting all properties.
function outArea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
