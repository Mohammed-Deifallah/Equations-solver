function varargout = GUIPart1(varargin)
% GUIPART1 MATLAB code for GUIPart1.fig
%      GUIPART1, by itself, creates a new GUIPART1 or raises the existing
%      singleton*.
%
%      H = GUIPART1 returns the handle to a new GUIPART1 or the handle to
%      the existing singleton*.
%
%      GUIPART1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIPART1.M with the given input arguments.
%
%      GUIPART1('Property','Value',...) creates a new GUIPART1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIPart1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIPart1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIPart1

% Last Modified by GUIDE v2.5 17-May-2017 06:26:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIPart1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIPart1_OutputFcn, ...
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


% --- Executes just before GUIPart1 is made visible.
function GUIPart1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIPart1 (see VARARGIN)

% Choose default command line output for GUIPart1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIPart1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIPart1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function setGlobalval(x,y)
    global val
	global str
    val = x;
	str = y;

function setBisectionBounds(xLU)
    global xlu;
    xlu = xLU;
    
function setBisectionIndex(index)
    global i;
    i = index;
    
function index = getBisectionIndex
    global i;
    index = i;
    
function xLU = getBisectionBounds
    global xlu;
    xLU = xlu;
    
function r = getGlobalval
   global val
   r = val;	
	
function w = getGlobalStr
   global str
   w = str;
   
function hideAll(handles)
    
    set(handles.bisectionPanel,'visible','off');
    set(handles.falsePosPanel,'visible','off');
    set(handles.fixedPoiPanel,'visible','off');
    set(handles.NewRaphPanel,'visible','off');
    set(handles.secantPanel,'visible','off');
    set(handles.BVPanel,'visible','off');
    set(handles.allMethodsPanel,'visible','off');
    set(handles.nextBtn,'visible','off');
    set(handles.prevBtn,'visible','off');
%     set(handles.axes2,'visible','off');
	
function plotEquation(equation ,firstPar , secondPar , handles)
    %getting equation
    equation = strtrim(equation);
    axes(handles.axes1);
    str = getGlobalStr;
    func = strcat('@(x)',equation);
    f = str2func(func);
    from = str2double(firstPar);
    to = str2double(secondPar);
    val = getGlobalval;
    cla(handles.axes1);
    switch str{val}
    case 'Bisection'
        fplot(f , [from-5 to+5],'b');
        yL = get(gca,'YLim');
        line([from from],yL,'Color','r');
        line([to to],yL,'Color','r');
        legend(handles.axes1,'f(x)','Lower' , 'Upper');
     case 'False-position'
        fplot(f , [from-5 to+5],'b');
        yL = get(gca,'YLim');
        line([from from],yL,'Color','r');
        line([to to],yL,'Color','r');
        legend(handles.axes1,'f(x)','Lower' , 'Upper');
    case 'Fixed point'
        yL = get(gca,'YLim');
        line([from from],yL+10,'Color','r');
        hold on;
        func = strcat(func,'+x');
        f = str2func(func);
        fplot(f , [from-5 to+5],'b');
        hold off;
        legend(handles.axes1,'f(x)','x note');
    case {'Newton-Raphson' , 'Bierge-Vieta' , 'General Algorithm'} 
        derivative = matlabFunction(diff(sym(equation), 'x'));
        fplot(f , [from-5 to+5],'b');
        yL = get(gca,'YLim');
        line([from from],yL,'Color','r');
        hold on;
        d = func2str(derivative);
        if(d(3)~='x')
            d = d(4:end);
            d = strcat('@(x)',d);
            derivative = str2func(d);
        end
        fplot(derivative , [from-5 to+5],'g');
        hold off;
        legend(handles.axes1,'f(x)' , 'Upper','derevative');
    case 'Secant'
         derivative = matlabFunction(diff(sym(equation), 'x'));
        fplot(f , [from-5 to+5],'b');
        yL = get(gca,'YLim');
        line([from from],yL,'Color','r');
        line([to to],yL,'Color','r');
        hold on;
        d = func2str(derivative);
        if(d(3)~='x')
            d = d(4:end);
            d = strcat('@(x)',d);
            derivative = str2func(d);
        end
        fplot(derivative , [from-5 to+5],'g');
        hold off;
        legend(handles.axes1,'f(x)' ,'X0','X1', 'd(f(x))');
%     case 'All Methods'
%          ezplot(equation);
    end
    axis([from-5 to+5 -20 20]);
    line([0 0],[-100 100],'Color','k');
    line([-100 100],[0 0],'Color','k');
    
%     grid on;

% --- Executes on selection change in selectionMenu.
function selectionMenu_Callback(hObject, eventdata, handles)
% hObject    handle to selectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectionMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectionMenu
global val;
global str;
val = get(hObject, 'Value');
str = get(hObject, 'String');

switch str{val}
    case 'Bisection'
        hideAll(handles);
        set(handles.bisectionPanel,'visible','on');
        set(handles.nextBtn,'visible','on');
        set(handles.prevBtn,'visible','on');
    case 'False-position'
        hideAll(handles);
        set(handles.falsePosPanel,'visible','on');
    case 'Fixed point'
        hideAll(handles);
        set(handles.fixedPoiPanel,'visible','on');
    case 'Newton-Raphson'
        hideAll(handles);
        set(handles.NewRaphPanel,'visible','on');
    case 'Secant'
        hideAll(handles);
        set(handles.secantPanel,'visible','on');
    case 'Bierge-Vieta'
        hideAll(handles);
        set(handles.BVPanel,'visible','on');
    case 'General Algorithm'
        hideAll(handles);
%         set(handles.falsePosPanel,'visible','on');
    case 'All Methods'
        hideAll(handles);
        set(handles.allMethodsPanel,'visible','on'); 
    case 'Choose the method:'
        hideAll(handles);
        setGlobalval(NaN,NaN);
end

% --- Executes during object creation, after setting all properties.
function selectionMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function equationBox_Callback(hObject, eventdata, handles)
% hObject    handle to equationBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of equationBox as text
%        str2double(get(hObject,'String')) returns contents of equationBox as a double


% --- Executes during object creation, after setting all properties.
function equationBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equationBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bisXLBox_Callback(hObject, eventdata, handles)
% hObject    handle to bisXLBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bisXLBox as text
%        str2double(get(hObject,'String')) returns contents of bisXLBox as a double


% --- Executes during object creation, after setting all properties.
function bisXLBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bisXLBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bisXUBox_Callback(hObject, eventdata, handles)
% hObject    handle to bisXUBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bisXUBox as text
%        str2double(get(hObject,'String')) returns contents of bisXUBox as a double


% --- Executes during object creation, after setting all properties.
function bisXUBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bisXUBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



% --- Executes on button press in solveButton.
function solveButton_Callback(hObject, eventdata, handles)
% hObject    handle to solveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     global equation;
    global fileFlag;
    global lowerParameter;
    global upperParameter;
    global itr;
    global eps;
    global method;
    global str;
    global val;
    global parameters;
    
    %try
    if fileFlag == true
        x = method;
    else
      %  if num2str(val) == 'NaN'
       %     return;
       % end
       x = str{val};
	   eps = get(handles.epsBox,'String');
	   itr = get(handles.iterBox,'String');
       equation = get(handles.equationBox,'String');
     
    if(isempty(equation))
	       h = msgbox('ERROR!');
		   return;
    end
    end  
     xlabel(handles.axes1,'x');
     ylabel(handles.axes1,'f(x)');
 
%    y = eval(equation);
 %   func = strcat('@(x)',equation);
    s = vectorize(char(equation));
    eval(['func = @(x)',s]);
    
	if(isempty(eps))
	   eps = '0.00001';
	end
    if(isempty(itr))
	   itr = '50';
    end
    
	switch x
    case 'Bisection'
        setBisectionIndex(2);
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
        if fileFlag == true
        else
            upperParameter = get(handles.bisXUBox,'String');
            lowerParameter = get(handles.bisXLBox,'String');
            if(isempty(upperParameter) || isempty(lowerParameter))
               disp('error');
               return 
            end
        end
		
		[root,flag] = bisection(str2double(lowerParameter), str2double(upperParameter), func, str2double(itr), str2double(eps),0,handles);
		if(flag == 0)
	       disp('No root')
           set(handles.outArea,'string',strcat('Bisection error!'));
	    else 
	       disp(root)
           set(handles.outArea,'string',strcat('Bisection root:  ',num2str(root)));
        end 
        plotEquation(equation  , lowerParameter , upperParameter,handles);
    
    case 'False-position'
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
        if fileFlag == true
        else 
            upperParameter = get(handles.falsePosXUBox,'String');
            lowerParameter = get(handles.falsePosXLBox,'String');
            if(isempty(upperParameter) || isempty(lowerParameter))
               disp('error');
               set(handles.outputArea,'string','False Position: error');
               return 
            end
        end
        [root,flag] = regulaFalsi(func,str2double(lowerParameter),str2double(upperParameter),str2double(eps),str2double(itr),0,handles);
        if(flag == 0)
           disp('No root')
           set(handles.outArea,'string',strcat('False-Position error!'));
        else 
           disp(root)
           set(handles.outArea,'string',strcat('False-Position root:  ',num2str(root)));
        end 
        plotEquation(equation  , lowerParameter , upperParameter,handles);
	
    case 'Fixed point'
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
        if fileFlag == true
        else
            upperParameter = get(handles.FixedPoiXIniBox,'String');
            if(isempty(upperParameter))
               disp('error! Enter X initial point');
               return 
            end
        end
		[root,errors] =fixed( func ,str2double(upperParameter),str2double(itr),str2double(eps) ,0,handles);
        disp(root);
        set(handles.outArea,'string',strcat('Fixed point root:  ',num2str(root)));
        plotEquation(equation  , upperParameter , upperParameter,handles);
    case 'Newton-Raphson'
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
        if fileFlag == true
        else
        upperParameter = get(handles.NewRaphXIniBox,'String');
		if(isempty(upperParameter))
	       disp('error');
           set(handles.outArea,'string','Newton-Raphson: error');
		   return 
        end
        end
        root = newtonRaphson(func, str2double(upperParameter), str2double(eps), str2double(itr),0,handles);
        disp(root)
        set(handles.outArea,'string',strcat('Newoten root:  ',num2str(root)));
        plotEquation(equation  , upperParameter , upperParameter,handles);
		
    case 'Secant'
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
        if fileFlag == true
        else
            upperParameter = get(handles.secantX1Box,'String');
            lowerParameter = get(handles.secantX0Box,'String');
        end
		[root, flag] = secant(str2double(lowerParameter), str2double(upperParameter), func, str2double(itr), str2double(eps),0,handles);
		if(flag == 0)
	      disp('No root')
          set(handles.outArea,'string','Secant error!');
	    else 
	      disp(root)
          set(handles.outArea,'string',strcat('Secant root:  ',num2str(root)));
        end 
	    plotEquation(equation  , lowerParameter , upperParameter,handles);
    case 'Bierge-Vieta'
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
        if fileFlag == true
        else
            upperParameter = get(handles.BVXIniBox,'String');
            if(isempty(upperParameter))
               disp('error');
               set(handles.outArea,'string','Bierge vieta error!');
               return 
            end
        end
		root = brigeVita(func,str2double(upperParameter), str2double(itr),str2double(eps)*100,0,handles);
		disp('root :')
        disp(root) 
        set(handles.outArea,'string',strcat('Bierge vieta root:  ',num2str(root)));
		plotEquation(equation  , upperParameter , upperParameter,handles);
    case 'General Algorithm'
        axes(handles.axes2);        
        cla(handles.axes2); 
        set(handles.axes2,'visible','off');
       % root = generalAlgorithm( equation , handles);
        [root, m] = generalMethod(equation, eps,handles,0);
        disp(root);
        disp(m);
        set(handles.outArea,'string',strcat('General Algrithm root:  ',num2str(double(root))));
        plotEquation(equation  ,num2str(double(root)) , num2str(double(root)) ,handles);
            
    case 'All Methods'
        if fileFlag == true
            for a = 1:3:16
               if strcmp(parameters{a},'Bisection')
                  bisectionParameter1 = parameters{a+1};
                  bisectionParameter2 = parameters{a+2};
               elseif strcmp(parameters{a},'False-Position')
                   falseParameter1 =  parameters{a+1};
		           falseParameter2 = parameters{a+2};
               elseif strcmp(parameters{a},'Fixed-Point')
                   fixedParameter1 =  parameters{a+1};
               elseif strcmp(parameters{a},'Newton-Raphson')
                   newtonParameter = parameters{a+1};
               elseif strcmp(parameters{a},'Secant')
                   secantParameter1 = parameters{a+1};
		           secantParameter2 = parameters{a+2};
               elseif strcmp(parameters{a},'Bierge-Vieta')
                   vetaParameter = parameters{a+1};
               end 
            end
        else
        legend off;
	    bisectionParameter1 = get(handles.aBisXLBox,'String');
        bisectionParameter2 = get(handles.aBisXUBox,'String');
		falseParameter1 = get(handles.aFPXlBox,'String');
		falseParameter2 = get(handles.aFPXuBox,'String');
		
		fixedParameter = get(handles.aFPXIniBox,'String');
	    
	    newtonParameter = get(handles.aNRXIniBox,'String');
		
		secantParameter1 = get(handles.aSecantX0Box,'String');
		secantParameter2 = get(handles.aSecantX1Box,'String');
	    
	    vetaParameter = get(handles.aBVXIniBox,'String');
%         set(handles.allMethodsPanel,'visible','off');
%         axes(handles.axes2);    
        end
        cla(handles.axes2);
        cla(handles.axes1);
        set(handles.axes2,'visible','on');
        xlabel(handles.axes2,'iterations');
        xlabel(handles.axes1,'iterations');
        ylabel(handles.axes2,'errors');
        ylabel(handles.axes1,'roots');
% % % % % % % % % % % % % % % % % % % % % % % % % % %         
        disp('Bisection:');
		if(isempty(bisectionParameter1) || isempty(bisectionParameter2))
	       h = msgbox('Missing Parameters!')
		   return 
        end
        try
		[root1,flag, time, iterations, errs] = bisection(str2double(bisectionParameter1), str2double(bisectionParameter2), func, str2double(itr), str2double(eps),1,handles);
		if(flag == 0)
	      h = msgbox('NO ROOT FOR BISECTION!')
	    else 
	       disp(root1)
        end 
        
         fileID = fopen('outFile.txt','w');
         fprintf(fileID,'\n%6s','Method Name:  ','Bisection');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Root: ');
         fprintf(fileID,'\n%6f',root1);
         fprintf(fileID,'\n%6s','Iterations: ');
         fprintf(fileID,'\n%6f',iterations(size(iterations,1)));
          fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f',errs(size(errs,1)));
        catch
        end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
        disp('False-Position:');
        if(isempty(falseParameter1) || isempty(falseParameter2))
	       disp('error');
		   return 
        end
        try
        [root2,flag, time, iterations, errs] = regulaFalsi(func,str2double(falseParameter1),str2double(falseParameter2),str2double(eps),str2double(itr),1,handles);
        if(flag == 0)
          h = msgbox('NO ROOT FOR REGULAFALSI!')
        else 
           disp(root2)
        end 
        fprintf(fileID,'\n%6s','------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','False Position');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Root: ');
         fprintf(fileID,'\n%6f',root2);
         fprintf(fileID,'\n%6s','Iterations: ');
         fprintf(fileID,'\n%6f',iterations(size(iterations,1)));
          fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f',errs(size(errs,1)));
        catch
        end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
        disp('Fixed Point:');
        if(isempty(fixedParameter))
	      h = msgbox('Enter paramter!')
		   return 
        end
        try
		[root3, flag, time, iterations, errs] = fixed( func ,str2double(fixedParameter),str2double(itr),str2double(eps) ,1,handles);
		
        errorFixed1 = errs(size(errs,1));
        errorFixed2 = errs(size(errs,1)-1);
        ansFixed = errorFixed1/errorFixed2
       
        fprintf(fileID,'\n%6s','------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Fixed Point');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Root: ');
         fprintf(fileID,'\n%6f',root3);
        fprintf(fileID,'\n%6s','Iterations: ');
         fprintf(fileID,'\n%6f',iterations(size(iterations,1)));
          fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f',errs(size(errs,1)));
         fprintf(fileID,'\n%6s','Error Bound: ');
         fprintf(fileID,'\n%6f',ansFixed);
        catch 
        end
         
% % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
        disp('Newton Raphason');
        if(isempty(newtonParameter))
	       h = msgbox('Enter Parameter!')
		   return 
        end
        try
        [root4, steps, time, iterations, errs, errors] = newtonRaphson(func, str2double(newtonParameter), str2double(eps), str2double(itr),1,handles);
        
        
        errorNewton1 = errs(size(errs,1));
        errorNewton2 = errs(size(errs,1)-1);
        ansNEW = errorNewton1/((errorNewton2)^2);
        
        fprintf(fileID,'\n%6s','------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Newton Raphason');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Root: ');
         fprintf(fileID,'\n%6f',root4);
         fprintf(fileID,'\n%6s','Iterations: ');
         fprintf(fileID,'\n%6f',iterations(size(iterations,1)));
          fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f',errs(size(errs,1)));
          fprintf(fileID,'\n%6s','Error Bound: ');
         fprintf(fileID,'\n%6f',ansNEW);
         
        catch
        end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
        disp('Secant');
        if(isempty(secantParameter1) || isempty(secantParameter2))
	       h = msgbox('Enter Parameters!')
		   return; 
        end
       try
        [root5, flag, time, iterations, errs] = secant(str2double(secantParameter1), str2double(secantParameter2), func, str2double(itr), str2double(eps),1,handles);
		if(flag == 0)
	      h = msgbox('NO ROOT FOR SECANT!')
	    else 
	      disp(root5)
        end 
        
         fprintf(fileID,'\n%6s','------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Secant');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Root: ');
         fprintf(fileID,'\n%6f',root5);
         fprintf(fileID,'\n%6s','Iterations: ');
         fprintf(fileID,'\n%6f',iterations(size(iterations,1)));
          fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f',errs(size(errs,1)));
       catch
       end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
        disp('Birge Vieta');
        if(isempty(vetaParameter))
	       h = msgbox('Enter Parameter!')
		   return; 
        end
        try
		[root6, errorsVector, time, iterations, errs] = brigeVita(func,str2double(vetaParameter), str2double(itr),str2double(eps)*100,1,handles);
        
        fprintf(fileID,'\n%6s','------------------------------------');
         fprintf(fileID,'\n%6s','Method Name:  ','Birge Vieta');
         fprintf(fileID,'\n%6s','Time Elapsed:  ',time);
         fprintf(fileID,'\n%6s','Root: ');
         fprintf(fileID,'\n%6f',root6);
        fprintf(fileID,'\n%6s','Iterations: ');
         fprintf(fileID,'\n%6f',iterations(size(iterations,1)));
          fprintf(fileID,'\n%6s','Error: ');
         fprintf(fileID,'\n%6f',errs(size(errs,1)));
        catch
        end
         set(handles.outArea,'string',{'Bisection:',root1,'False-Position:',root2,'Fixed Point:',root3,'Newoten Raphason:',root4,'Secant:',root5,'Berige Vieta:',root6});
        
    end
    %catch
     %   h = msgbox('ERROR!');
      %  return;
  % end
    fileFlag = false;

% --- Executes on button press in selectFileButton.
function selectFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[baseName, folder] = uigetfile();
try
fullFileName = fullfile(folder, baseName);
A  = Read(fullFileName);
global method;
global equation;
global fileFlag;
global lowerParameter;
global upperParameter;
global itr;
global eps;
global parameters;

try
fileFlag = true;
method = A{1};
equation = A{2};
itr = A{3};
eps = A{4};
parameters = {};

if strcmp(equation,'/')
    h = msgbox('ENTER EQUATION!');
    return;
end
if strcmp(method,'/')
    h = msgbox('ENTER A METHOD!');
    return;
end

if strcmp(itr,'/')
    itr = '50';
end
if strcmp(eps,'/')
    eps = '0.00001';
end

if strcmp(method,'All Methods') 
    counter = 5;
for a = 1:6 
   for b = 1:3
      Data{b} = A{counter};
      parameters{counter-4} = A{counter};
      counter = counter + 1;
   end
    check(Data{1}, Data{2}, Data{3});
end

elseif strcmp(method,'General Algorithm')
else
lowerParameter = A{5};
upperParameter = A{6};
 check(method, lowerParameter, upperParameter);
end
catch
    h = msgbox('Error occurred: Maybe file not chosen');
    fileFlag = false;
    return;
end
catch
    h = msgbox('ERROR: Maybe file not chosen!');
end

    function check(m, first, second)
        
        if strcmp(m,'/')
    h = msgbox('ENTER METHOD TYPE!');
    return;
end

if strcmp(first,'/')
    h = msgbox('ENTER LOWER BOUND!');
    return;
end

if strcmp(m,'Bisection') || strcmp(m,'regulaFalsi') || strcmp(m,'secant')
    if strcmp(second,'/')
        h = msgbox('ENTER UPPER BOUND!');
        return;
    end
end


% --- Executes during object creation, after setting all properties.
function bisectionPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bisectionPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function falsePosXUBox_Callback(hObject, eventdata, handles)
% hObject    handle to falsePosXUBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of falsePosXUBox as text
%        str2double(get(hObject,'String')) returns contents of falsePosXUBox as a double


% --- Executes during object creation, after setting all properties.
function falsePosXUBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to falsePosXUBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function falsePosXLBox_Callback(hObject, eventdata, handles)
% hObject    handle to falsePosXLBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of falsePosXLBox as text
%        str2double(get(hObject,'String')) returns contents of falsePosXLBox as a double


% --- Executes during object creation, after setting all properties.
function falsePosXLBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to falsePosXLBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function aFPXlBox_Callback(hObject, eventdata, handles)
% hObject    handle to aFPXlBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aFPXlBox as text
%        str2double(get(hObject,'String')) returns contents of aFPXlBox as a double


% --- Executes during object creation, after setting all properties.
function aFPXlBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aFPXlBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aFPXuBox_Callback(hObject, eventdata, handles)
% hObject    handle to aFPXuBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aFPXuBox as text
%        str2double(get(hObject,'String')) returns contents of aFPXuBox as a double


% --- Executes during object creation, after setting all properties.
function aFPXuBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aFPXuBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aFPXIniBox_Callback(hObject, eventdata, handles)
% hObject    handle to aFPXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aFPXIniBox as text
%        str2double(get(hObject,'String')) returns contents of aFPXIniBox as a double


% --- Executes during object creation, after setting all properties.
function aFPXIniBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aFPXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aBisXUBox_Callback(hObject, eventdata, handles)
% hObject    handle to aBisXUBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aBisXUBox as text
%        str2double(get(hObject,'String')) returns contents of aBisXUBox as a double


% --- Executes during object creation, after setting all properties.
function aBisXUBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aBisXUBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aBisXLBox_Callback(hObject, eventdata, handles)
% hObject    handle to aBisXLBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aBisXLBox as text
%        str2double(get(hObject,'String')) returns contents of aBisXLBox as a double


% --- Executes during object creation, after setting all properties.
function aBisXLBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aBisXLBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aBVXIniBox_Callback(hObject, eventdata, handles)
% hObject    handle to aBVXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aBVXIniBox as text
%        str2double(get(hObject,'String')) returns contents of aBVXIniBox as a double


% --- Executes during object creation, after setting all properties.
function aBVXIniBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aBVXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aNRXIniBox_Callback(hObject, eventdata, handles)
% hObject    handle to aNRXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aNRXIniBox as text
%        str2double(get(hObject,'String')) returns contents of aNRXIniBox as a double


% --- Executes during object creation, after setting all properties.
function aNRXIniBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aNRXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aSecantX1Box_Callback(hObject, eventdata, handles)
% hObject    handle to aSecantX1Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aSecantX1Box as text
%        str2double(get(hObject,'String')) returns contents of aSecantX1Box as a double


% --- Executes during object creation, after setting all properties.
function aSecantX1Box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aSecantX1Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aSecantX0Box_Callback(hObject, eventdata, handles)
% hObject    handle to aSecantX0Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aSecantX0Box as text
%        str2double(get(hObject,'String')) returns contents of aSecantX0Box as a double


% --- Executes during object creation, after setting all properties.
function aSecantX0Box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aSecantX0Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function BVXIniBox_Callback(hObject, eventdata, handles)
% hObject    handle to BVXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BVXIniBox as text
%        str2double(get(hObject,'String')) returns contents of BVXIniBox as a double


% --- Executes during object creation, after setting all properties.
function BVXIniBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BVXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NewRaphXIniBox_Callback(hObject, eventdata, handles)
% hObject    handle to NewRaphXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NewRaphXIniBox as text
%        str2double(get(hObject,'String')) returns contents of NewRaphXIniBox as a double


% --- Executes during object creation, after setting all properties.
function NewRaphXIniBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NewRaphXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secantX1Box_Callback(hObject, eventdata, handles)
% hObject    handle to secantX1Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secantX1Box as text
%        str2double(get(hObject,'String')) returns contents of secantX1Box as a double


% --- Executes during object creation, after setting all properties.
function secantX1Box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secantX1Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secantX0Box_Callback(hObject, eventdata, handles)
% hObject    handle to secantX0Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secantX0Box as text
%        str2double(get(hObject,'String')) returns contents of secantX0Box as a double


% --- Executes during object creation, after setting all properties.
function secantX0Box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secantX0Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixedPoiXIniBox_Callback(hObject, eventdata, handles)
% hObject    handle to FixedPoiXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixedPoiXIniBox as text
%        str2double(get(hObject,'String')) returns contents of FixedPoiXIniBox as a double


% --- Executes during object creation, after setting all properties.
function FixedPoiXIniBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixedPoiXIniBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function fixedPoiPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fixedPoiPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Red
function [root, flag, time, iterations,errs] = regulaFalsi(f, l, u, e, iter,allMethods,handles)
%That funcion calculates the root of the equation on a given interval
% and an acceptable error, using Regula-Falsi method
    tic;
    flag = 1;
    set(handles.outTable,'data',[]);
    try
    if(f(l) * f(u) > 0)
        flag = 0; 
        root = 1;
    elseif(f(l) == 0)
        root = l;
    elseif(f(u) == 0)
        root = u;
    else
        root = (l * f(u) - u * f(l)) / (f(u) - f(l));
        if(f(u) * f(root) < 0)
            xi = u;
        else
            xi = l;
        end
        i = 0;
        iterations =[0];
        xs =[l];
        errs =[100];
        error = 100;
        while(abs((root - xi) / root) > e && i < iter)
            errorOld = error;
            error = abs((root - xi) / root);
            errs =vertcat(errs,error);
            i = i + 1;
            iterations = vertcat(iterations,i);
            temp = root;
            xs = vertcat(xs,root);
            root = (xi * f(temp) - temp * f(xi)) / (f(temp) - f(xi));
             if(allMethods == 1)
                axes(handles.axes2);
                line([i-1 i],[errorOld error],'Color','r');
                hold on;
                axes(handles.axes1);
                line([i i+1],[temp root],'Color','r');
                hold on;
            end
            if(f(temp) * f(root) < 0)
                xi = temp;
               
            end
        end
        tab = cat(2,iterations,xs,errs);
        set(handles.outTable,'data',tab );
    end
    time = toc;
    
    if allMethods == 0
    file(iterations, xs,errs , time,'regulaFalsi',0);
    end
    catch 
        h = msgbox('ERROR!');
        return;
    end;
% Green
function[xr , flag, time, iterations ,errs] = bisection(xL, xU, func, maxit, es,allMethods,handles)
     tic;
     try
     flag = 1;
     iter = 0;
     iterations =[];
     xs =[];
     errs =[];
     set(handles.outTable,'data',[]);
     xlu = [xL xU];
     if((func(xL) * func(xU)) > 0)
         flag = 0;
         xr = 1;
     elseif (func(xL) == 0)
	     xr = xL;
	     return;
     elseif (func(xU) == 0)
	     xr = xU;
	     return;
     else 
         xr = (xU + xL)/2;
         if((func(xL) * func(xr)) < 0)
            xU = xr;
         else 
	        xL = xr;
         end 
         if(func(xL)*func(xr)==0)
             return;
         end
         error = 100;
         errorOld = 0;
         iterations =[0];
         xs =[xr];
         errs =[100];
         for i= 1:maxit
             tmp = [xL xU];
             xlu = vertcat(xlu,tmp);
             x = xr;
	         xr = (xU + xL)/2;
             errorOld = error;
             error = abs((xr-x)/xr);
             errs =vertcat(errs,error);
             iterations = vertcat(iterations,i);
             xs = vertcat(xs,xr);
             
            
             if(allMethods == 1)
                axes(handles.axes2);
                line([i-1 i],[errorOld error],'Color','g');
                hold on;
                axes(handles.axes1);
                line([i-1 i],[x xr],'Color','g');
                hold on;
             end
             if(abs((xr-x)/xr) < es)
                break;
              end	
             if((func(xL) * func(xr)) < 0)
                xU = xr;
              else 
                xL = xr;
              end            
             if((func(xL) * func(xr))== 0) 
               break;
              end
              iter = i;
        end
       if( iter >= maxit)
         flag = 0;
       end
       tab = cat(2,iterations,xs,errs);
       set(handles.outTable,'data',tab );
     end
     setBisectionBounds(xlu);
     time = toc;
     if allMethods == 0
     file(iterations, xs,errs , time,'bisection',0);
     end
     catch 
         h = msgbox('ERRORS!');
         return;
     end
% blue
 function [root, steps,time,iterations,errs, errors] = newtonRaphson(func, x0, eps, iterations,allMethods,handles)
%This function calculates the root of function f, using Newton-Raphson
%method with x0 as an initial point
%f = x^2 + 3x + 2

tic
set(handles.outTable,'data',[]);
try
	it=iterations;
    syms x;
    xs=[];
    errs =[];
    derivative = matlabFunction(diff(func,x)); %2x + 3
    steps = zeros(50);
    steps(1) = x0;
    d = func2str(derivative);
    if(d(3)~='x')
            d = d(4:end);
            d = strcat('@(x)',d);
            derivative = str2func(d);
    end
    disp(derivative);
    if(derivative(x0) == 0)
        root = x0;
    else
        root = x0 - func(x0) /  derivative(x0);
        steps(1) = root;
        iter = 1;
        error = 100;
        errorOld = 0;
        errs = [100];
        iterations = [0];
        xs = [root];
		
        while( subs(derivative,x0) ~= 0 && abs((root - x0) / root) > eps && iter <= it)
           errorOld = error;
           error = abs((root - x0) / root);
           x0 = root;
           root = x0 - (func(x0) / derivative(x0));
		  
           errs =vertcat(errs,error);
           iterations = vertcat(iterations,iter);
           xs = vertcat(xs,root);
           if(allMethods == 1)
              axes(handles.axes2);
              line([iter-1 iter],[errorOld error],'Color','b');
              hold on;
              axes(handles.axes1);
              line([iter-1 iter],[x0 root],'Color','b');
              hold on;
           end 
           errors(iter) = abs((root - x0) / root) * 100;
           steps(iter + 1) = root;
           iter = iter + 1;
        end
        tab = cat(2,iterations,xs,errs);
        set(handles.outTable,'data',tab );
    end  
     time = toc;
     if allMethods == 0
file(iterations, xs,errs , time,'newton',0);
     end
catch
    h = msgbox('ERROR!');
    return;
end

% magneta	
function [ answer,errorsVector, time, iterations, errs] = brigeVita( fun,x,iltNum,tolerance ,allMethods,handles)
%     fun = 'x^2 - x - 3';
%     x = 4;
%     iltNum = 50;
%     tolerance = .0001;
tic;
try
xii=x;
counter=iltNum;
error = tolerance+1;
a = sym2poly(sym(fun));
b = a;
c = a;
errors=[];
err = 100;
errorOld = 0;
cnt = 0;
errs = [100];
iterations = [0];
xs = [xii];
set(handles.outTable,'data',[]);
while counter > 0 && error > tolerance 
   for n=2:1:length(b)
       b(n) = a(n)+ xii * b(n-1);  
   end  
   for n=2:1:length(b)-1
       c(n) = b(n)+ xii * c(n-1);
   end 
    xi = xii;
    lb=length(b);
    lc=length(c)-1;
    if b(lb)~= 0
    xii = xi - ( b(lb)/c(lc));
    end
    errorOld = err;
    errs =vertcat(errs,err);
    iterations = vertcat(iterations,cnt+1);
    xs = vertcat(xs,xii);
   err =abs((xii-xi)*100/xii);
   if(allMethods == 1)
       axes(handles.axes2);
       line([cnt cnt+1],[errorOld err],'Color','m');
       hold off;
       axes(handles.axes1);
       line([cnt cnt+1],[xi xii],'Color','m');
       hold off;
   end
   cnt = cnt+1;
    error=abs((xii-xi)*100/xii);
    errors(length(errors)+1)=error;
    counter = counter - 1 ;
end
 tab = cat(2,iterations,xs,errs);
 set(handles.outTable,'data',tab );
hold off;
answer = xii;
errorsVector=errors;
time = toc;

if allMethods == 0
file(iterations, xs,errs , time,'birgeVita',0);
end
catch
    h = msgbox('ERROR!');
    return;
end


% secant
function[x2, flag, time, iterations, errs] = secant(Guess0, Guess1, func, maxit, es,allMethods,handles)
    tic
flag = 1;
iter = 1;
try
x = Guess0;
f = feval(func,x);
x1 = Guess1;
f1 = feval(func,x1);
errorOld = 0;
error = 100;
xs =[x1];
errs = [100];
iterations = [0];
set(handles.outTable,'data',[]);
for i= 2:maxit
    x2 = x1 - (f1*((x1-x)/(f1-f)));
    f2 = feval(func, x2);
    if(abs((x2-x1)/x2) < es)
        break;
    end
    errorOld = error;
    errs =vertcat(errs,error);
    iterations = vertcat(iterations,i-1);
    xs = vertcat(xs,x2);
    error = abs((x2-x1)/x2);
    if(allMethods == 1)
        axes(handles.axes2);
        line([i-2 i-1],[errorOld error],'Color','c');
        hold on;
        axes(handles.axes1);
        line([i-2 i-1],[x1 x2],'Color','c');
        hold on;
    end
    iter = i;
    x = x1;
    x1 = x2;
	f = f1;
	f1 = f2;
end
if(iter >= maxit) 
    flag = 0;
end
time = toc;
tab = cat(2,iterations,xs,errs);
set(handles.outTable,'data',tab );

if allMethods == 0
file(iterations, xs, errs, time,'secant',0);
end
catch
    h = msgbox('ERROR!');
    return;
end

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


% function  r  = generalAlgorithm( equation , handles)
% %UNTITLED Summary of this function goes here
% %   Detailed explanation goes here
%     func = strcat('@(x)',equation);
%     f = str2func(func);
%     l = -100;
%     u = 100;
%     flag = 1;
%     while(f(l) * f(u) > 0)
%         l = l+1;    
%         if(l > 0)
%             flag = 0;
%             break;
%         end
%         if(f(l) == 0)
%             disp('root is :');
%             r = l;
%             flag = 2;
%             break;
%         end
%     end
%     r = l;
%     cnt = 0;
%     if(flag == 1)
%         l = -100;
%         flag = 0;
%         xs = [r];
%         iterations = [cnt];
%         errs = [100];
%         rOld = u;
%        while(f(l) * f(u) > 0)
%        tmp = u;
%         u = u-1;
%         if(u < 0)
%             flag = 1;
%             break;
%         end
%         if(f(u) == 0)
%             disp('root is :');
%             r = u;
%             flag = 2;
%             break;
%         end
%         cnt = cnt+1;
%         
%         erro = abs((u-tmp)/tmp)*100;
%         errs =vertcat(errs,erro);
%         iterations = vertcat(iterations,cnt);
%         xs = vertcat(xs,u);
%        end
%     end
%     if(flag == 1)
%         disp('Fuunction has no root!');
%     else if(flag~=2)
%         r = (l + u) / 2;
%         if(f(r) * f(u) < 0)
%             l = r;
%         else
%             u = r;
%         end
% 
%         i = 0;
%         maxIter = 50000;
%         maxE = 0.00000001;
%         errs = [100];
%         xs = [r];
%         iterations = [i];
%         rOld    = r+1;
%         while(abs(r - rOld) > maxE && i < maxIter)
%             error = abs(r - rOld)*100/rOld;
%             i = i + 1;
%             errs =vertcat(errs,error);
%             iterations = vertcat(iterations,i);
%             rOld = r;
%             xs = vertcat(xs,r);
%             r = (l * f(u) - u * f(l))/(f(u) - f(l));
%             if(f(r)*f(u)  < 0)
%                 l = r;
%             else
%                 u = r;
%             end
%         end
%     tab = cat(2,iterations,xs,errs);
%     set(handles.outTable,'data',tab );
%     end
%     end
% % yellow
function [ xr,flag, time, iterations, errs] = fixed( fun ,s,iltNum, tolerance , allMethods,handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    syms x
    tic;
    try
    flag = false;
    xr= feval(fun,s)+s;
    errorOld = 0;
    err = 100;
    errs = [err];
    iterations=[0];
    xs = [xr];
   iter = 0;  
   for iter = 1:iltNum
    xr_old = xr;
    xr = feval(fun,xr_old)+ xr_old;
    ea = abs((xr - xr_old)/xr);
    errorOld = err;
    err = ea/xr;
    errs =vertcat(errs,err);
    iterations = vertcat(iterations,iter);
    xs = vertcat(xs,xr);
    if(allMethods == 1)
            axes(handles.axes2);
            line([iter-1 iter],[errorOld err],'Color','y');
            hold on;
            axes(handles.axes1);
            line([iter-1 iter],[xr_old xr],'Color','y');
            hold on;
    end
    iter = iter +1;
    if ea < tolerance
        break;
    end
   end
   time = toc;
   tab = cat(2,iterations,xs,errs);
   set(handles.outTable,'data',tab );
   if allMethods == 0
   file(iterations,xs,errs,time,'fixed',0);
   end
    catch
        h = msgbox('ERROR!');
        return;
    end
function [  ] = file(Iterations, Roots, Errors,time,method, m)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


A =  cat(2,Iterations,Roots,Errors);
disp(A)
fileID = fopen('outFile.txt','w');
fprintf(fileID,'%6s','Time Elapsed:  ',time);
if strcmp(method,'General Algorithm')
     fprintf(fileID,'\n%6s','Multiplicity:  ',num2str(m));
end
fprintf(fileID,'\n%6s %10s %14s\n','Iterations','Roots','Errors');
i = 1;
siz =  size(Iterations);
while(i <= siz(1))
    fprintf(fileID,'%6f %15f %12f\n',A(i,1),A(i,2),A(i,3));
    i = i+1;
end
fclose(fileID);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes when entered data in editable cell(s) in outTable.
function outTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to outTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function outArea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in nextBtn.
function nextBtn_Callback(hObject, eventdata, handles)
% hObject    handle to nextBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arr = getBisectionBounds;
index = getBisectionIndex;
siz = size(arr)

if(index<siz(1))
    setBisectionIndex(index + 1)
end
if(index<=siz(1))
    lowerParameter = arr(index,1);
    upperParameter = arr(index,2);
    plotEquation(get(handles.equationBox,'String')  , num2str(lowerParameter) , num2str(upperParameter),handles);
end
% --- Executes on button press in prevBtn.
function prevBtn_Callback(hObject, eventdata, handles)
% hObject    handle to prevBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arr = getBisectionBounds;
index = getBisectionIndex;
siz = size(arr)
if(index > 1)
    setBisectionIndex(index - 1)
end
if(index<=siz(1))
    lowerParameter = arr(index,1);
    upperParameter = arr(index,2);
    plotEquation(get(handles.equationBox,'String')  , num2str(lowerParameter) , num2str(upperParameter),handles);
end

%another general Algorithim
function [root, m, time, iterations, errors] = generalMethod(f, eps,handles, AllMethods)
    
   set(handles.outTable,'data',[] );
   tic;
   try
   [root, steps, errors, iter] = modifiedNewton(f, eps);
    if(abs(subs(f,root)) > eps)
        [root, steps2, errors2, iter2] = modifiedSecant(f, root, eps);
        steps = vertcat(steps, steps2);
        errors = vertcat(errors, errors2);
        iter = iter + iter2;
    end
    time = toc;
    iterations = 0:double(iter);
    m = multiplicity(f, root, eps);
    errors = [0 double(errors)];
   
    tab = cat(2,transpose(double(iterations)),transpose(double(steps)),transpose(errors));
    set(handles.outTable,'data',tab );
    iterations = transpose(double(iterations));
    roots = transpose(double(steps));
    errors = transpose(errors);
    
    if AllMethods == 0
    file(iterations,roots,errors,time,'General Algorithm',m);
    end
   catch
       h = msgbox('ERROR!');
       return;
   end
    
    
   function [root, steps, errors, iter] = modifiedNewton(f, eps)
       syms x;
 
    x0 = rand;
    while abs(subs(diff(f,x),x0)^2 - subs(diff(diff(f,x),x),x0) * subs(f,x0)) < eps
        x0 = rand;
    end
    iter = 0;
    steps(1) = x0;
    root = x0 - subs(f,x0) * subs(diff(f,x),x0) / (subs(diff(f,x),x0) * subs(diff(f,x),x0) - subs(diff(diff(f,x),x),x0) * subs(f,x0));
    errors = [];
    while(iter < 50 && abs(subs(diff(f,x),root)^2 - subs(diff(diff(f,x),x),root) * subs(f,root)) > eps && abs(root - x0) > eps)
        steps(length(steps)+1) = root;
    errors(length(errors)+1) = abs(root - x0);
        x0 = root;
        root = x0 - subs(f,x0) * subs(diff(f,x),x0) / (subs(diff(f,x),x0) * subs(diff(f,x),x0) - subs(diff(diff(f,x),x),x0) * subs(f,x0));
        iter = iter + 1;
        
    end
    steps(length(steps)+1) = root;
    errors(length(errors)+1) = abs(root - x0);
     iter = iter + 1;

    
    function [root, steps, errors, iter] = modifiedSecant(f, init, eps)
    del = rand;
    iter = 0;
    while(abs(subs(f,init + init * del) - subs(f,init)) < eps)
        init = init + rand;
    end
    errors = [];
    steps(1) = init;
    root = init - del * init * subs(f,init) / (subs(f,init + init * del) - subs(f,init));
    while(iter < 50 && abs(subs(f,del * root + root) - f(root)) > eps && abs(root - init) > eps)
        iter = iter + 1;
        steps(iter + 1) = root;
        errors(iter) = abs(root - init);
        init = root;
        root = init - del * init * subs(f,init) / (subs(f,init + init * del) - subs(f,init));   
    end
    
    
function m = multiplicity(f, root, eps)
    m = 1;
    f = diff(f);
    while(abs(subs(f,root)) <= eps)
        f = diff(f);
        m = m + 1;
    end