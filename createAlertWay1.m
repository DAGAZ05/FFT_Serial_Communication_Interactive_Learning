%CREATEALERTWAY1 创建picFFT的way1提示框
% 1.Function of this function
%     针对指定App对象，绘制图像FFT栏基于C++方式的提示框
% 2.Input parameters
%     app:传入MATLAB App对象
% 3.Output parameters
%     无
% 4.Examples
%     Inputs:
%     createAlertWay1(app);
%     Results:
%     None (show tooltip in center)
% --------------Implementation goes here---------------------
function createAlertWay1(app)
    delete(app.picAlert1);  % 删除旧提示框
    
    alertFig = uifigure('Name', 'picture FFT (C++)');
    parentPos = app.UIFigure.Position;
    initWidth = max(480, parentPos(3)*0.7);
    initHeight = max(270, parentPos(4)*0.7);
    alertFig.Position = [...
        parentPos(1)+(parentPos(3)-initWidth)/2, ...
        parentPos(2)+(parentPos(4)-initHeight)/2, ...
        initWidth, initHeight];
    app.picAlert1=alertFig;

    % 创建网格布局容器
    grid = uigridlayout(alertFig);
    grid.RowHeight = {'0.2x', '1x', '1x', '1x', '0.2x'};  
    grid.ColumnWidth = {'1x', '1x', '1x'};  
    grid.Padding = [2 2 2 2];          
    grid.RowSpacing = 2;                 
    grid.ColumnSpacing = 2;
    
    % 创建标签组件
    Label1 = uilabel(grid);
    if app.language=="CH"
        Label1.Text = '请先查看左侧说明文档！'; 
        Label1.FontName = "楷体";
    else
        Label1.Text = 'Please check the documentation on the left first!'; 
        Label1.FontName = "Segoe UI";
    end
    
    Label1.FontSize = 16;
    Label1.FontWeight = 'bold';
    Label1.HorizontalAlignment = 'center';
    Label1.WordWrap="on";
    Label1.Layout.Row = 1;
    Label1.Layout.Column = [1 3];
    
    % 创建标签组件
    Label2 = uilabel(grid);
    if app.language=="CH"
        Label2.Text = '复制以下路径再点击右侧按钮，将路径复制在打开的exe程序内，按说明继续在程序内输入参数'; 
        Label2.FontName = "楷体";
    else
        Label2.Text = ['Copy the following path and click the button on the right to copy the path ' ...
            'into the opened exe program. Follow the instructions to continue entering parameters into the program.']; 
        Label2.FontName = "Segoe UI";
    end
    
    Label2.FontSize = 16;
    Label2.FontWeight = 'bold';
    Label2.HorizontalAlignment = 'left';
    Label2.WordWrap="on";
    Label2.Layout.Row = 2;
    Label2.Layout.Column = [1 2];
    
    % 创建按钮组件
    button1 = uibutton(grid);
    if app.language=="CH"
        button1.Text = '点击执行kruskal'; 
        button1.FontName = "楷体";
    else
        button1.Text = 'Click to execute kruskal'; 
        button1.FontName = "Segoe UI";
    end
    
    button1.FontSize = 16;
    button1.FontWeight = 'bold';
    button1.HorizontalAlignment = 'center';
    button1.WordWrap="on";
    button1.Layout.Row = 2;
    button1.Layout.Column = 3;
    button1.ButtonPushedFcn = @(src, event) button1Back(app); % 执行kruskal.exe按钮的触击回调

    txtArea = uitextarea(grid);
    txtArea.Layout.Row = 3;
    txtArea.Layout.Column = [1 3];
    txtArea.Value=app.copyPath;
    
    % 创建标签组件
    Label3 = uilabel(grid);
    if app.language=="CH"
        Label3.Text = '点击右侧按钮，打开exe程序绘图，按F5开始/结束绘图'; 
        Label3.FontName = "楷体";
    else
        Label3.Text = "Click the button on the right to open the exe program for drawing, and press F5 to start/end drawing"; 
        Label3.FontName = "Segoe UI";
    end
    
    Label3.FontSize = 16;
    Label3.FontWeight = 'bold';
    Label3.HorizontalAlignment = 'left';
    Label3.WordWrap="on";
    Label3.Layout.Row = 4;
    Label3.Layout.Column = [1 2];
    
    % 创建按钮组件
    button2 = uibutton(grid);
    if app.language=="CH"
        button2.Text = '点击执行fourier'; 
        button2.FontName = "楷体";
    else
        button2.Text = 'Click to execute fourier'; 
        button2.FontName = "Segoe UI";
    end
    
    button2.FontSize = 16;
    button2.FontWeight = 'bold';
    button2.HorizontalAlignment = 'center';
    button2.WordWrap="on";
    button2.Layout.Row = 4;
    button2.Layout.Column = 3;
    button2.ButtonPushedFcn = @(src, event) winopen(app.exePath2); % 打开fourier.exe
    
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
    button3.Layout.Column = 2;
    button3.ButtonPushedFcn = @(src, event) delete(app.picAlert1); % 删除提示框
end

% 执行kruskal.exe按钮的触击回调
function button1Back(app)
    winopen(app.exePath1); % 打开kruskal.exe
    
    cla(app.UIAxes_edge); % 清空图像显示坐标区
end