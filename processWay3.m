% PROCESSWAY3 picFFT基于Python方式导入svg时的函数
% 1.Function of this function
%     针对指定App对象，读取pde文件路径，在matlab中依序执行Python程序，弹出信息提示框，最后打开processing程序
% 2.Input parameters
%     app:传入MATLAB App对象
%     pdeFile:processing程序（pde文件）路径字符串
% 3.Output parameters
%     无
% 4.Examples
%     Inputs:
%     pdeFile=fullfile(folder, 'Fourier.pde');
%     processWay3(app,pdeFile);
%     Results:
%       process:
%           resize.py -> svgtext.py -> FourierMath.py -> pde 
% --------------Implementation goes here---------------------
function processWay3(app,pdeFile)
    % 处理依赖文件
    processingReliedData(app);
    
    % 处理Python解释器路径
    pythonExe = ['"' strrep(app.pythonExePath, '\', '/') '"'];
    
    % 执行脚本resize.py -> svgtext.py -> FourierMath.py
    scriptPath0 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'FourierCircleDrawing1', 'resize.py'), '\', '/') '"'];
    [status0,cmdout0]=system([pythonExe ' ' scriptPath0]);
    result0=createProcessDialog(app,'resize.py',status0,cmdout0);
    drawnow;
    if result0==0
        return;
    end

    scriptPath1 = ['"' strrep(fullfile(app.appRoot, 'FourierCircleDrawing', 'FourierCircleDrawing1', 'svgtext.py'), '\', '/') '"'];
    [status1,cmdout1]=system([pythonExe ' ' scriptPath1]);
    result1=createProcessDialog(app,'svgtext.py',status1,cmdout1);
    drawnow;
    if result1==0
        return;
    end
   
    inputFile = fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing1","temp.txt");
    fid = fopen(inputFile, 'w');
    fprintf(fid, '%d\n', app.EditField_fourierThreshold.Value); % 加换行符\n
    fclose(fid);
    pythonExe=app.pythonExePath;
    scriptPath2=fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing1","FourierMath.py");
    % 通过输入重定向传递
    [status2,cmdout2]=system(sprintf('"%s" "%s" < "%s"', pythonExe, scriptPath2, inputFile));
    result2=createProcessDialog(app,'FourierMath.py',status2,cmdout2);
    drawnow;
    if result2==0
        return;
    end
    
    % 删除临时文件
    delete(inputFile);

    winopen(pdeFile); % 打开pde文件
end

% 处理依赖文件（rotationSpeed参数、clearOrbit参数）
function processingReliedData(app)
    inputFile = fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing1","rotationSpeed.txt");
    fid = fopen(inputFile, 'w');
    fprintf(fid, '%.4f', app.EditField_rotationSpeed.Value); % 写入傅里叶圆旋转速度参数
    fclose(fid);
    
    inputFile2 = fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing1","clearOrbit.txt");
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