% PROCESSWAY2 picFFT基于Python方式导入jpg/png时的函数
% 1.Function of this function
%     针对指定App对象，读取图像的宽、高数据及pde文件路径，在matlab中依序执行Python程序，弹出信息提示框，最后打开processing程序
% 2.Input parameters
%     app:传入MATLAB App对象
%     width:图片宽度
%     height:图片高度
%     pdeFile:processing程序（pde文件）路径字符串
% 3.Output parameters
%     无
% 4.Examples
% (1) Inputs1:
%     width=768;
%     height=768;
%     pdeFile=fullfile(folder, 'Fourier.pde');
%     processWay2(app,width,height,pdeFile);
%     Results1:
%       process:
%           resize2.py -> canny.py -> adjustRatio.py (-> lines.py) -> sort.py -> text.py -> FourierMathDynamic.py -> pde 
% (2) Inputs2:
%     width=3840;
%     height=2160;
%     pdeFile=fullfile(folder, 'Fourier.pde');
%     processWay2(app,width,height,pdeFile);
%     Results2:
%       process:
%           canny.py -> adjustRatio.py (-> lines.py) -> resize.py -> sort.py -> text.py -> FourierMathDynamic.py -> pde
% --------------Implementation goes here---------------------
function processWay2(app,width,height,pdeFile)
    % 处理Python解释器路径及脚本路径
    pythonExe = ['"' strrep(app.pythonExePath, '\', '/') '"'];
    scriptPath1 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'resize2.py'), '\', '/') '"'];
    scriptPath2 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'canny.py'), '\', '/') '"'];
    scriptPath3 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'lines.py'), '\', '/') '"'];
    scriptPath4 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'sort.py'), '\', '/') '"'];
    scriptPath5 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'text.py'), '\', '/') '"'];
    scriptPath6 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'resize.py'), '\', '/') '"'];  
    
    if width <= 1920 && height <= 1080 % 图片尺寸在1920pt * 1080pt之下
        % 执行Python脚本 resize2.py -> canny.py -> adjustRatio.py (-> lines.py)
        [status1,cmdout1]=system([pythonExe ' ' scriptPath1]);
        result1=createProcessDialog(app,'resize2.py',status1,cmdout1);
        drawnow;
        if result1==0
            return;
        end

        [status2,cmdout2]=system([pythonExe ' ' scriptPath2]);
        result2=createProcessDialog(app,'canny.py',status2,cmdout2);
        drawnow;
        if result2==0
            return;
        end

        result7=processAdujustRatio(app);
        drawnow;
        if result7==0
            return;
        end

        if app.DropDown_curveFitting.Value==1 % 进行曲线拟合
            [status3,cmdout3]=system([pythonExe ' ' scriptPath3]);
            result3=createProcessDialog(app,'lines.py',status3,cmdout3);
            drawnow;
            if result3==0
                return;
            end
        end
    else % 图片尺寸超过1920pt * 1080pt
        % 执行Python脚本 canny.py -> adjustRatio.py (-> lines.py) -> resize.py
        [status2,cmdout2]=system([pythonExe ' ' scriptPath2]);
        result2=createProcessDialog(app,'canny.py',status2,cmdout2);
        drawnow;
        if result2==0
            return;
        end

        result7=processAdujustRatio(app);
        drawnow;
        if result7==0
            return;
        end

        if app.DropDown_curveFitting.Value==1 % 进行曲线拟合
            [status3,cmdout3]=system([pythonExe ' ' scriptPath3]);
            result3=createProcessDialog(app,'lines.py',status3,cmdout3);
            drawnow;
            if result3==0
                return;
            end
        end
        
        [status6,cmdout6]=system([pythonExe ' ' scriptPath6]);
        result6=createProcessDialog(app,'resize.py',status6,cmdout6); 
        drawnow;
        if result6==0
            return;
        end
    end
    
    % 执行Python脚本 sort.py -> text.py -> FourierMathDynamic.py
    [status4,cmdout4]=system([pythonExe ' ' scriptPath4]);
    result4=createProcessDialog(app,'sort.py',status4,cmdout4);
    drawnow;
    if result4==0
        return;
    end

    [status5,cmdout5]=system([pythonExe ' ' scriptPath5]);
    result5=createProcessDialog(app,'text.py',status5,cmdout5);
    drawnow;
    if result5==0
        return;
    end

    % 处理信息复制至对应处理路径
    copyfile(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'rawvertexes.txt'), ...
        fullfile(app.appRoot, 'FourierCircleDrawing', 'FourierCircleDrawing2', 'rawvertexes.txt'))
    file=sprintf('picFFT_way2_rawvertexes_%s.txt',num2str(app.cntPicfft));
    path=fullfile(app.appRoot,'data','picFFT','way2','fft');
    copyfile(fullfile(app.appRoot, 'FourierCircleDrawing', 'linear script', 'rawvertexes.txt'), ...
        fullfile(path,file)); % 存储傅里叶系数数据
    app.cntPicfft=app.cntPicfft+1; % 计数器加1
    
    result8=processFourierMathDynamic(app);
    drawnow;
    if result8==0
        return;
    end

    processingReliedData(app); % 处理App中参数数据

    winopen(pdeFile); % 打开pde文件
end

% 执行adjustRatio.py脚本（需传入轮廓采样率参数）
function result=processAdujustRatio(app)
    inputFile = fullfile(app.appRoot,"FourierCircleDrawing","linear script","temp.txt");
    fid = fopen(inputFile, 'w');
    fprintf(fid, '%f\n', app.EditField_edgeSampleRate.Value); % 加换行符\n
    fclose(fid);
    pythonExe=app.pythonExePath;
    scriptPath=fullfile(app.appRoot,"FourierCircleDrawing","linear script","adjustRatio.py");
    % 通过输入重定向传递
    [status,cmdout]=system(sprintf('"%s" "%s" < "%s"', pythonExe, scriptPath, inputFile));

    result=createProcessDialog(app,'adjustRatio.py',status,cmdout);
    
    % 删除临时文件
    delete(inputFile);
end

% 执行FourierMathDynamic.py脚本（需传入傅里叶圆个数参数）
function result=processFourierMathDynamic(app)
    inputFile = fullfile(app.appRoot,"FourierCircleDrawing","linear script","temp2.txt");
    fid = fopen(inputFile, 'w');
    fprintf(fid, '%d\n', app.EditField_fourierThreshold.Value); % 加换行符\n
    fclose(fid);
    pythonExe=app.pythonExePath;
    scriptPath=fullfile(app.appRoot, 'FourierCircleDrawing', 'FourierCircleDrawing2', ...
        'FourierMathDynamic.py');
    % 通过输入重定向传递
    [status,cmdout]=system(sprintf('"%s" "%s" < "%s"', pythonExe, scriptPath, inputFile));

    result=createProcessDialog(app,'FourierMathDynamic.py',status,cmdout);
                
    % 删除临时文件
    delete(inputFile);
end

% 处理依赖文件（rotationSpeed参数、clearOrbit参数）
function processingReliedData(app)
    inputFile = fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing2","rotationSpeed.txt");
    fid = fopen(inputFile, 'w');
    fprintf(fid, '%.4f', app.EditField_rotationSpeed.Value); % 写入傅里叶圆旋转速度参数
    fclose(fid);
    
    inputFile2 = fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing2","clearOrbit.txt");
    fid2 = fopen(inputFile2, 'w');
    if app.DropDown_clearOrbit.Value==1
        fprintf(fid, '%d', 1); % 清除轨道
    else
        fprintf(fid, '%d', 0); % 不清除
    end
    fclose(fid2);
end

% 外部程序执行信息提示
function result=createProcessDialog(app,name,status,cmdout)
    try
        % 显示结果
        if app.language == "CH"
            if status == 0
                msg = sprintf('运行成功：\n%s', cmdout);
                result=1;
            else
                msg = sprintf('运行失败：\n%s', cmdout);
                result=0;
            end
            title = [name,'执行结果'];
        else
            if status == 0
                msg = sprintf('Process successful:\n%s', cmdout);
                result=1;
            else
                msg = sprintf('Process failed:\n%s', cmdout);
                result=0;
            end
            title = [name,' Process Result'];
        end
    
        % 创建结果对话框
        fig = uifigure('Name', title);
        parentPos = app.UIFigure.Position;
        initWidth = max(480, parentPos(3)*0.7);
        initHeight = max(270, parentPos(4)*0.7);
        fig.Position = [...
            parentPos(1)+(parentPos(3)-initWidth)/2, ...
            parentPos(2)+(parentPos(4)-initHeight)/2, ...
            initWidth, initHeight];
    
        grid = uigridlayout(fig);
        grid.RowHeight = {'1x'};
        grid.ColumnWidth = {'1x'};
        grid.Padding = [10 10 10 10];
        
        % 创建文本区域组件并显示执行信息
        textarea=uitextarea(grid, ...
            'Value', msg, ...
            'Editable', false);
        textarea.Layout.Row = 1;
        textarea.Layout.Column = 1;
    
    catch e % 错误信息提示
        if app.language == "CH"
            errordlg(['执行出错: ' e.message], '错误');
        else
            errordlg(['Error: ' e.message], 'Error');
        end
    end
end