%CREATEALERTWAY2 创建picFFT的way2提示框
% 1.Function of this function
%     针对指定App对象，绘制图像FFT栏基于Python方式的提示框
% 2.Input parameters
%     app:传入MATLAB App对象
% 3.Output parameters
%     无
% 4.Examples
%     Inputs:
%     createAlertWay2(app);
%     Results:
%     None (show tooltip in center)
% --------------Implementation goes here---------------------
function createAlertWay2(app)
    delete(app.picAlert2);  % 删除旧提示框
    
    alertFig = uifigure('Name', 'picture FFT (Python)');
    parentPos = app.UIFigure.Position; % 获取主界面位置信息
    initWidth = max(480, parentPos(3)*0.7);
    initHeight = max(270, parentPos(4)*0.7);
    alertFig.Position = [...
        parentPos(1)+(parentPos(3)-initWidth)/2, ...
        parentPos(2)+(parentPos(4)-initHeight)/2, ...
        initWidth, initHeight];
    app.picAlert2=alertFig;

    % 创建网格布局容器
    grid = uigridlayout(alertFig);
    grid.RowHeight = {'1x', '1x', '1x', '1x', '1x'};  
    grid.ColumnWidth = {'1x'};  
    grid.Padding = [2 2 2 2];          
    grid.RowSpacing = 2;                 
    grid.ColumnSpacing = 2;
    
    % 创建标签组件
    Label = uilabel(grid);
    if app.language=="CH"
        Label.Text = '请先查看左侧说明文档并下载左下角processing！'; 
        Label.FontName = "楷体";
    else
        Label.Text = 'Please check the documentation on the left and download processing in the corner first!'; 
        Label.FontName = "Segoe UI";
    end
    
    Label.FontSize = 16;
    Label.FontWeight = 'bold';
    Label.HorizontalAlignment = 'center';
    Label.WordWrap="on";
    Label.Layout.Row = 1;
    Label.Layout.Column = 1;

    % 创建标签组件
    Label2 = uilabel(grid);
    if app.language=="CH"
        Label2.Text = '选择导入jpg/png或导入svg（仅含1个路径）'; 
        Label2.FontName = "楷体";
    else
        Label2.Text = 'Choose to import jpg/png or svg (containing only 1 path)'; 
        Label2.FontName = "Segoe UI";
    end
    
    Label2.FontSize = 16;
    Label2.FontWeight = 'bold';
    Label2.HorizontalAlignment = 'center';
    Label2.WordWrap="on";
    Label2.Layout.Row = 2;
    Label2.Layout.Column = 1;

    % 创建按钮组件
    button1 = uibutton(grid);
    if app.language=="CH"
        button1.Text = '点击导入jpg/png'; 
        button1.FontName = "楷体";
    else
        button1.Text = 'Click to import jpg/png'; 
        button1.FontName = "Segoe UI";
    end
    
    button1.FontSize = 16;
    button1.FontWeight = 'bold';
    button1.HorizontalAlignment = 'center';
    button1.WordWrap="on";
    button1.Layout.Row = 3;
    button1.Layout.Column = 1;
    button1.ButtonPushedFcn = @(src, event) importJpgPng(app);

    % 创建按钮组件
    button2 = uibutton(grid);
    if app.language=="CH"
        button2.Text = '点击导入svg'; 
        button2.FontName = "楷体";
    else
        button2.Text = 'Click to import svg'; 
        button2.FontName = "Segoe UI";
    end
    
    button2.FontSize = 16;
    button2.FontWeight = 'bold';
    button2.HorizontalAlignment = 'center';
    button2.WordWrap="on";
    button2.Layout.Row = 4;
    button2.Layout.Column = 1;
    button2.ButtonPushedFcn = @(src, event) importSvg(app);

    % 创建按钮组件
    button3 = uibutton(grid);
    if app.language=="CH"
        button3.Text = '结束'; 
        button3.FontName = "楷体";
    else
        button3.Text = 'Cancel'; 
        button3.FontName = "Segoe UI";
    end
    
    button3.FontSize = 16;
    button3.FontWeight = 'bold';
    button3.HorizontalAlignment = 'center';
    button3.WordWrap="on";
    button3.Layout.Row = 5;
    button3.Layout.Column = 1;
    button3.ButtonPushedFcn = @(src, event) delete(app.picAlert2);
end

% 导入jpg/png选项的触击回调
function importJpgPng(app)
    if(~invalidPython(app)) % 检查Python路径是否存在
        return;
    end
 
    if app.language=="CH"
        [file, path] = uigetfile({'*.jpg;*.png', 'image files (*.jpg,*.png)'}, ...
            '导入图片');
    else
        [file, path] = uigetfile({'*.jpg;*.png', 'image files (*.jpg,*.png)'}, ...
            'import one picture');
    end

    if isequal(file, 0) || isequal(path, 0) % 如果用户选择了取消
        return;
    end

    app.picExit=1; % 是否已导入图片属性置1
    app.picChoose=1; % 标记当前导入为jpg/png

    app.picFile=fullfile(path,file); % 图像路径

    info=imfinfo(app.picFile); % 获取图像信息

    timestamp = datetime("now","Format","dd-MM-uuuu-HH-mm-ss"); % 时间戳
    filename = ['image_' char(timestamp) '.' lower(info.Format)]; % 保存格式

    saveFile=fullfile(app.appRoot,"FourierCircleDrawing","pictures",filename); % 保存路径
    processFile=fullfile(app.appRoot,"FourierCircleDrawing","linear script","picture.png"); % 处理路径（统一处理为png）

    copyfile(app.picFile,saveFile); % 图像复制在保存路径中

    if lower(info.Format)=="jpg" % 导入图片格式为jpg
        jpgImg=imread(app.picFile);
        imwrite(jpgImg,processFile);
    else % 导入图片格式为png
        copyfile(app.picFile,processFile);
    end
    
    if app.packageExit2==0 % 库未安装（每次进入App后第一次处理的图像均需安装）
        installPythonPackage(app,'numpy');
        installPythonPackage(app,'opencv-python');
        installPythonPackage(app,'svgwrite');
        installPythonPackage(app,'svgpathtools');
        installPythonPackage(app,'pillow');
        
        app.packageExit2=app.packageExit2+1; % 标记Python库已安装
    end    
end

% 导入svg选项的触击回调
function importSvg(app)
    if(~invalidPython(app)) % 检查Python路径是否存在
        return;
    end

    if app.language=="CH"
        [file, path] = uigetfile({'*.svg', 'image files (*.svg)'}, ...
            '导入图片');
    else
        [file, path] = uigetfile({'*.svg', 'image files (*.svg)'}, ...
            'import one picture');
    end

    if isequal(file, 0) || isequal(path, 0) % 如果用户选择了取消
        return;
    end

    app.picExit=1; % 是否已导入图片属性置1
    app.picChoose=2; % 标记当前导入为svg

    app.picFile=fullfile(path,file); % 图像路径

    timestamp = datetime("now","Format","dd-MM-uuuu-HH-mm-ss"); % 时间戳
    filename = ['image_' char(timestamp) '.svg']; % 保存格式

    saveFile=fullfile(app.appRoot,"FourierCircleDrawing","pictures",filename); % 保存路径
    processFile=fullfile(app.appRoot,"FourierCircleDrawing","FourierCircleDrawing1","input.svg"); % 处理路径

    copyfile(app.picFile,saveFile); % 图像复制在保存路径中

    copyfile(app.picFile,processFile); % 图像复制在处理路径中

    % 数据存储
    fileSave=sprintf('picFFT_way2_svg1_%s.svg',num2str(app.cntPicSvg));
    copyfile(processFile,fullfile(app.appRoot,"data","picFFT","way2","svg",fileSave));
    app.cntPicSvg=app.cntPicSvg+1;
    
    if app.packageExit1==0 % 库未安装（每次进入App后第一次处理的图像均需安装）
        installPythonPackage(app,'numpy');
        installPythonPackage(app,'svgpathtools');
    
        app.packageExit1=app.packageExit1+1; % 标记Python库已安装 
    end   
end

% 在用户选择的Python解释器环境下导入Python库辅助函数
function installPythonPackage(app, packageName)   
    pipCommand = ['"' app.pythonExePath '" -m pip'];
    
    
    % 安装命令
    installCmd = [pipCommand ' install ' packageName ' --user'];
    
    % 执行命令并显示输出
    try
        [status, cmdout] = system(installCmd);
        
        % 显示结果
        if app.language == "CH"
            if status == 0
                msg = sprintf('安装成功:\n%s', cmdout);
            else
                msg = sprintf('安装失败:\n%s', cmdout);
            end
            title = 'pip安装结果';
        else
            if status == 0
                msg = sprintf('Installation successful:\n%s', cmdout);
            else
                msg = sprintf('Installation failed:\n%s', cmdout);
            end
            title = 'pip Installation Result';
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
        
        % 创建文本区域组件以显示执行信息
        textarea=uitextarea(grid, ...
            'Value', msg, ...
            'Editable', false);
        textarea.Layout.Row = 1;
        textarea.Layout.Column = 1;
        drawnow; % 立即更新
        
    catch e % 错误信息提示
        if app.language == "CH"
            errordlg(['执行出错: ' e.message], '错误');
        else
            errordlg(['Error: ' e.message], 'Error');
        end
    end
end

% 检查Python路径是否有效辅助函数
function status=invalidPython(app)   
    if isempty(app.pythonExePath) % 如果解释器路径为空
        if app.language == "CH"
            errordlg('请先选择有效的Python解释器', '路径错误');
        else
            errordlg('Please select a valid Python interpreter first', 'Path Error');
        end
        status=0; % 状态标记为无效
        return;
    end
    status=1; % 状态标记为有效
end