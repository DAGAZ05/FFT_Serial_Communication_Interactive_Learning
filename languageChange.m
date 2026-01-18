% LANGUAGECHANGE 语言切换函数
% 1.Function of this function
%     切换App对象中的文本信息的语言（中文/英文）
% 2.Input parameters
%     app:传入App对象
% 3.Output parameters
%     无
% 4.Examples
%     Inputs:
%     languageChange(app);
%     Results:
%     None (switch language)
% --------------Implementation goes here---------------------
function languageChange(app)
    if app.language=="CH" % 中文
        app.ToggleTool_language.ImageSource=fullfile(app.appRoot, 'pictures', 'chinese_icon.png');
        app.html.HTMLSource=fullfile(app.appRoot, 'html','FFT.html');
        app.html2.HTMLSource=fullfile(app.appRoot, 'html','Example.html');
        app.html3.HTMLSource=fullfile(app.appRoot, 'html','jpg.html');
        app.html4.HTMLSource=fullfile(app.appRoot, 'html','practice.html');
        app.Label_warning.FontName="楷体";
        app.Label_warning.Text="请确保程序路径无中文字符";
        app.Label_title.FontName="楷体";
        app.Label_title.Text="快速傅里叶变换串口通信交互学习入门";
        app.Menu_function.Text="功能说明";
        app.Menu_function.Tooltip="右键展开副菜单";
        app.Menu_doc.Text="说明文档";
        app.Menu_link.Text="参考链接";
        app.Menu_mail.Text="学校邮件";
        app.Menu_reference.Text="参考资料";
        app.Menu_reference.Tooltip="右键展开副菜单";
        app.Menu_contact.Text="联系作者";
        app.Menu_contact.Tooltip="右键展开副菜单";
        app.PushTool_pictureInput.Tooltip="导入图片";
        app.PushTool_audioInput.Tooltip="导入音频";
        app.ToggleTool_arduino.Tooltip="查看arduino程序";
        app.ToggleTool_language.Tooltip=['切换语言选项',newline,'（默认中文）'];
        app.ToggleTool_python.Tooltip=['切换Python接口',newline,'（默认关闭）'];
        app.Tab_theory.Title="FFT理论";
        app.Button_theory.FontName="楷体";
        app.Button_theory.Text="FFT理论";
        app.Tab_example.Title="简易图形示范";
        app.Button_example.FontName="楷体";
        app.Button_example.Text="简易图形示范";
        app.Tab_picture.Title="图像FFT";
        app.Button_picture.FontName="楷体";
        app.Button_picture.Text="图像FFT";
        app.Tab_audio.Title="音频FFT";
        app.Button_audio.FontName="楷体";
        app.Button_audio.Text="音频FFT";
        app.Tab_soundSignal.Title="arduino声信号处理";
        app.Button_soundSignal.FontName="楷体";
        app.Button_soundSignal.Text="声信号处理";
        app.Tab_lightSignal.Title="arduino光信号处理";
        app.Button_lightSignal.FontName="楷体";
        app.Button_lightSignal.Text="光信号处理";
        app.Tab_musicGame.Title="实时音游";
        app.Button_musicGame.FontName="楷体";
        app.Button_musicGame.Text="实时音游";
        app.Tab_practice.Title="交互练习";
        app.Button_practice.FontName="楷体";
        app.Button_practice.Text="交互练习";
        app.Tab_dataOutput.Title="数据导出";
        app.Button_dataOutput.FontName="楷体";
        app.Button_dataOutput.Text="数据导出";
        app.Label_html4.FontName="楷体";
        app.Label_html4.Text="点击按钮，查看html网页";
        app.Button_way1.FontName="楷体";
        app.Button_way1.Text="方式1（基于C++）";
        app.Button_way2.FontName="楷体";
        app.Button_way2.Text="方式2（基于Python）";
        app.Button_instruction.FontName="楷体";
        app.Button_instruction.Text="说明（必看）";
        app.Button_importPic.FontName="楷体";
        app.Button_importPic.Text="导入图片";
        app.TextArea_ways.FontName="楷体";
        app.TextArea_ways.Value=['方式1：',newline,'支持jpg/png格式；',newline,'支持bmp格式',newline,newline,'方式2：',newline, ...
           '支持jpg/png格式；',newline,'支持仅含1条路径且通过Adobe Illustrator导出的svg格式'];
        app.Label_originalPic.FontName="楷体";
        app.Label_originalPic.Text="原图";
        app.Label_svgPaths.FontName="楷体";
        app.Label_svgPaths.Text="轮廓/svg路径图像";
        app.Button_dynamicFFT.FontName="楷体";
        app.Button_dynamicFFT.Text="图像FFT动态展示";
        if app.ButtonGroup_ways.SelectedObject==app.Button_way2 && app.picChoose~=0
            app.Button_dynamicFFT.Tooltip="请先设置参数（见下）";
        else
            app.Button_dynamicFFT.Tooltip='';
        end
        app.EditField_4Label.FontName = '楷体';
        app.EditField_4Label.Text="轮廓采样率";
        app.EditField_edgeSampleRate.Tooltip = {'范围[0,1]'; '越高计算时间越长'};
        app.EditField_5Label.FontName="楷体";
        app.EditField_5Label.Text = '傅里叶系数计算阈值';
        app.EditField_fourierThreshold.Tooltip = {'范围[10,2000]'; '越大计算时间越长'};
        app.Label_6.FontName="楷体";
        app.Label_6.Text = '是否进行曲线拟合';
        app.DropDown_curveFitting.Items = {'离散', '拟合'};
        app.DropDown_curveFitting.Tooltip = {'不建议进行拟合'};
        app.DropDown_curveFitting.FontName = '楷体';
        app.Label_4.FontName="楷体";
        app.Label_4.Text = '傅里叶圆旋转速度';
        app.EditField_rotationSpeed.Tooltip = {'范围[1e-4,10]'; '越大频率越高'};
        app.Label_5.FontName="楷体";
        app.Label_5.Text = '重绘是否清除已有轨道';
        app.DropDown_clearOrbit.Items = {'是', '否'};
        app.DropDown_clearOrbit.FontName = '楷体';
        app.Button_importMusic.FontName="楷体";
        app.Button_importMusic.Text="导入歌曲";
        app.Button_playMusic.FontName="楷体";
        app.Button_playMusic.Text="播放";
        app.Button_pauseMusic.FontName="楷体";
        app.Button_pauseMusic.Text="暂停";
        app.Button_resumeMusic.FontName="楷体";
        app.Button_resumeMusic.Text="续播";
        app.Button_stopMusic.FontName="楷体";
        app.Button_stopMusic.Text="停止";
        app.Button_preMusic.FontName="楷体";
        app.Button_preMusic.Text="上一首";
        app.Button_nextMusic.FontName="楷体";
        app.Button_nextMusic.Text="下一首";
        app.Button_stengthenVoice.FontName="楷体";
        if app.isEnhanceHumanVoice==false
            app.Button_stengthenVoice.Text="增强人声";
        else
            app.Button_stengthenVoice.Text="取消增强人声";
        end
        app.Button_voicePrinciple.FontName="楷体";
        app.Button_voicePrinciple.Text="增强人声原理";
        app.UIAxes_timeWave.Title.String = '实时时域波形';
        app.UIAxes_spectrum.Title.String = '实时频谱图';
        app.Button_part.FontName="楷体";
        app.Button_part.Text="局部";
        app.Button_whole.FontName="楷体";
        app.Button_whole.Text="整体";
        app.Button_violin.Text="小提琴";
        app.Button_viola.Text="中提琴";
        app.Button_cello.Text="大提琴";
        app.Button_bass.Text="贝斯";
        app.Button_guitar.Text="吉他";
        app.Button_keyboard.Text="键盘";
        app.Button_flute.Text="长笛";
        app.Button_saxophone.Text="萨克斯";
        app.Button_piano.Text="钢琴";
        app.Button_drums.Text="架子鼓";
        app.Button_marimba.Text="马林巴琴";
        app.Button_glockenspiel.Text="钟琴";
        app.Button_harpsichord.Text="羽管键琴";
        app.Button_bowbells.Text="管钟";
        app.Button_melodyorgan.Text="口风琴";
        app.Button_trumpet.Text="小号";
        app.Button_instruPlay.FontName="楷体";
        app.Button_instruPlay.Text="乐器播放";
        app.ButtonGroup_instrument.Tooltip={'连续点击两次乐器播放按钮开始播放；';'单击停止按钮停止播放'};
        app.ButtonGroup_instrument.FontName="楷体";
        app.ButtonGroup_instrument.Title="乐器谐波结构";
        app.UIAxes_musicInstrument.Title.String="谐波结构";
        app.Hyperlink_pythonDownload.FontName="楷体";
        app.Hyperlink_pythonDownload.Text="Python下载链接";
        app.TextArea_soundSignal.Value="本界面实现matlab与arduino交互的音频特征分析、" + ...
            "静音检测及变声处理。请先输入arduino连接端口（请在PC设备管理器上确认），" + ...
            "执行bat程序（并确保无其他程序占用端口，可在任务管理器-详细信息查看），查看并连接线路图，点击右上角图标" + ...
            "（内有arduino下载链接）复制arduino程序并上传至arduino uno开发板（波特率设置115200），" + ...
            "确保关闭arduino程序后点击连接按钮，通过开始与结束按钮读取声音传感器传递的音频信息。";
        app.DropDown_port.Tooltip="点击可更新选项";
        app.Label_7.Tooltip = {'可手动调节声音传感器的电容以缩放传递的信号'};
        app.Button_connectArduino.Tooltip="连接速度较慢，请耐心等待";
        app.Button_connectArduino.FontName="楷体";
        app.Button_connectArduino.Text="点击连接";
        app.Button_bat.FontName="楷体";
        app.Button_bat.Text="执行bat";
        app.Button_circuit.FontName="楷体";
        app.Button_circuit.Text="线路图";
        app.UITable_extractData.ColumnName = {'时间'; '均值'; '最大值'; '主频'; '过零率'};
        app.Label_7.FontName="楷体";
        app.Label_7.Text = '信号采集最低值';
        app.Button_sStart.FontName="楷体";
        app.Button_sStart.Text="开始";
        app.Button_sEnd.FontName="楷体";
        app.Button_sEnd.Text="结束";
        app.Button_sExport.FontName="楷体";
        app.Button_sExport.Text="导出静音过滤";
        app.Button_sPlay.FontName="楷体";
        app.Button_sPlay.Text="播放";
        app.Button_sStop.FontName="楷体";
        app.Button_sStop.Text="停止";
        app.Panel_changeVoice.FontName="楷体";
        app.Panel_changeVoice.Title="变声处理";
        app.Button_changeVoicePlay.FontName="楷体";
        app.Button_changeVoicePlay.Text="播放";
        app.Button_changeVoiceStop.FontName="楷体";
        app.Button_changeVoiceStop.Text="停止";
        app.Button_femaleVoice.Text="转女声";
        app.Button_maleVoice.Text="转男声";
        app.Button_cartoonVoice.Text="转卡通";
        app.Button_robotVoice.Text="转机器";
        app.Button_devArduino.Text="使用arduino";
        app.Button_devMicrophone.Text="使用麦克风";
        app.Button_lstart.FontName="楷体";
        app.Button_lstart.Text="开始";
        app.Button_lend.FontName="楷体";
        app.Button_lend.Text="结束";
        app.Button_connectArduino_2.Tooltip="连接速度较慢，请耐心等待";
        app.Button_connectArduino_2.FontName="楷体";
        app.Button_connectArduino_2.Text="点击连接";
        app.Button_bat_2.FontName="楷体";
        app.Button_bat_2.Text="执行bat";
        app.Button_circuit_2.FontName="楷体";
        app.Button_circuit_2.Text="线路图";
        app.UITable_light.ColumnName = {'时间'; '电阻'; '相对光强'; '峰值频率'; '频谱能量'};
        app.TextArea_lightSignal.Value="本界面实现matlab与arduino交互的光强信号时域波形及频谱能量分布分析。" + ...
            "请先输入arduino连接端口（请在PC设备管理器上确认），执行bat程序（并确保无其他程序占用端口），" + ...
            "查看并连接线路图，点击右上角图标（内有arduino下载链接）复制arduino程序并上传至arduino uno开发板" + ...
            "（波特率设置115200），确保关闭arduino程序后点击连接按钮，" + ...
            "通过开始与结束按钮读取光敏传感器传递的光敏电阻信息。";
        app.DropDown_port_2.Tooltip="点击可更新选项";
        app.UIAxes_lightWaveform.Title.String = '实时光强信号';
        app.UIAxes_lightWaveform.XLabel.String = '时间';
        app.UIAxes_lightWaveform.YLabel.String = '光强值';                            
        app.UIAxes_lightSpectrum.Title.String = '频谱能量分布';
        app.UIAxes_lightSpectrum.XLabel.String = '频率 (Hz)';
        app.UIAxes_lightSpectrum.YLabel.String = '幅值';
        app.Button_importMusic_2.FontName="楷体";
        app.Button_importMusic_2.Text="导入歌曲";
        app.Button_analyzeMusic.FontName="楷体";
        app.Button_analyzeMusic.Text="FFT分析";
        app.Button_startMG.FontName="楷体";
        app.Button_startMG.Text="开始";
        app.Button_stopMG.FontName="楷体";
        app.Button_stopMG.Text="结束";
        app.Label_8.FontName="楷体";
        app.Label_8.Text="音量";
        app.Button_playMG.FontName="楷体";
        app.Button_playMG.Text="播放";
        app.Node_picFFT.Text="图像FFT";
        app.Node_way1.Text="方式1";
        app.Node_edge.Text="轮廓图像（导出png）";
        app.Node_way2.Text="方式2";
        app.Node_svg.Text="svg路径图像（导出svg）";
        app.Node_picPa.Text="参数表格（导出csv/mat）";
        app.Node_fft.Text="傅里叶系数（导出txt）";
        app.Node_audioFFT.Text="音频FFT";
        app.Node_audioWave.Text="波形图（导出png）";
        app.Node_audioSpectrum.Text="频谱图（导出png）";
        app.Node_instrument.Text="乐器谐波图像（导出png）";
        app.Node_ligntArduino.Text="arduino光信号处理";
        app.Node_ligntPa.Text="参数表格（导出csv/mat）";
        app.Node_lightWave.Text="波形图（导出png）";
        app.Node_lightSpectrum.Text="频谱图（导出png）";
        app.Node_soundArduino.Text="arduino声信号处理";
        app.Node_arduino.Text="arduino接口";
        app.Node_arduinoPa.Text="参数表格（导出csv/mat）";
        app.Node_threshold.Text="采集最低值参数（导出mat）";
        app.Node_ardWave.Text="波形图（导出png）";
        app.Node_ardSpectrum.Text="频谱图（导出png）";
        app.Node_silence.Text="静音检测图像（导出png）";
        app.Node_origin.Text="变声处理原波形图（导出png）";
        app.Node_processed.Text="变声处理加工波形图（导出png）";
        app.Node_microphone.Text="麦克风接口";
        app.Node_micWave.Text="波形图（导出png）";
        app.Node_micSpectrum.Text="频谱图（导出png）";
        app.Node_micOrigin.Text="变声处理原波形图（导出png）";
        app.Node_micProcessed.Text="变声处理加工波形图（导出png）";
        app.Node_musicGame.Text="实时音游";
        app.Node_mgSpectrum.Text="频谱图（导出png）";
        app.Node_score.Text="得分（导出mat）";
        app.Node_practice.Text="交互练习";
        app.Node_analysis.Text="题目解析（导出txt）";
        app.Button_exportData.FontName="楷体";
        app.Button_exportData.Text="导出数据";
        app.Image_self.Tooltip="App作者";
        app.Button_re1.Tooltip="重新传递数据";
        app.Button_re2.Tooltip="重新传递数据";
        app.Button_killPython.FontName="楷体";
        app.Button_killPython.Text="中断Python";
        app.Button_openPde.FontName="楷体";
        app.Button_openPde.Text="打开pde文件";
        app.Button_sExport.Tooltip="仅支持使用arduino设备";
        if app.ButtonGroup_device.SelectedObject==app.Button_devArduino % 当前使用arduino
            app.Button_sPlay.Tooltip="播放静音去除文件";
        else % 当前使用PC麦克风
            app.Button_sPlay.Tooltip="播放录音文件";
        end
    elseif app.language=="EN" % 英文
        app.ToggleTool_language.ImageSource=fullfile(app.appRoot, 'pictures', 'english_icon.png');
        app.html.HTMLSource=fullfile(app.appRoot, 'html','FFT_EN.html');
        app.html2.HTMLSource=fullfile(app.appRoot, 'html','Example_EN.html');
        app.html3.HTMLSource=fullfile(app.appRoot, 'html','jpg_EN.html');
        app.html4.HTMLSource=fullfile(app.appRoot, 'html','practice_EN.html');
        app.Label_warning.FontName="Segoe UI";
        app.Label_warning.Text="Please make sure there isn't any Chinese character in the program path";
        app.Label_title.FontName="Segoe UI";
        app.Label_title.Text="FFT Serial Communication Interactive Learning";
        app.Menu_function.Text="Function";
        app.Menu_function.Tooltip=['Right click',newline,'to expand the submenu'];
        app.Menu_doc.Text="Document";
        app.Menu_link.Text="Reference Link";
        app.Menu_mail.Text="School E-mail";
        app.Menu_reference.Text="Reference";
        app.Menu_reference.Tooltip=['Right click',newline,'to expand the submenu'];
        app.Menu_contact.Text="Contact";
        app.Menu_contact.Tooltip=['Right click',newline,'to expand the submenu'];
        app.PushTool_pictureInput.Tooltip="Import picture files";
        app.PushTool_audioInput.Tooltip="Import audio files";
        app.ToggleTool_arduino.Tooltip="Look up arduino program";
        app.ToggleTool_language.Tooltip=['Switch language option',newline,'(default Chinese)'];
        app.ToggleTool_python.Tooltip=['Switch Python interface',newline,'(default off)'];
        app.Tab_theory.Title="FFT Theory";
        app.Button_theory.FontName="Segoe UI";
        app.Button_theory.Text="FFT Theory";
        app.Tab_example.Title="Figure Example";
        app.Button_example.FontName="Segoe UI";
        app.Button_example.Text="Figure Example";
        app.Tab_picture.Title="Picture FFT";
        app.Button_picture.FontName="Segoe UI";
        app.Button_picture.Text="Picture FFT";
        app.Tab_audio.Title="Audio FFT";
        app.Button_audio.FontName="Segoe UI";
        app.Button_audio.Text="Audio FFT";
        app.Tab_soundSignal.Title="Sound Signal Process";
        app.Button_soundSignal.FontName="Segoe UI";
        app.Button_soundSignal.Text="Sound Signal Process";
        app.Tab_lightSignal.Title="Light Signal Process";
        app.Button_lightSignal.FontName="Segoe UI";
        app.Button_lightSignal.Text="Light Signal Process";
        app.Tab_musicGame.Title="Real-time Music Game";
        app.Button_musicGame.FontName="Segoe UI";
        app.Button_musicGame.Text="Real-time Music Game";
        app.Tab_practice.Title="Intereactive Practice";
        app.Button_practice.FontName="Segoe UI";
        app.Button_practice.Text="Intereactive Practice";
        app.Tab_dataOutput.Title="Export Data";
        app.Button_dataOutput.FontName="Segoe UI";
        app.Button_dataOutput.Text="Export Data";
        app.Label_html4.FontName="Segoe UI";
        app.Label_html4.Text="Click button to search html web";
        app.Button_way1.FontName="Segoe UI";
        app.Button_way1.Text="way1(C++)";
        app.Button_way2.FontName="Segoe UI";
        app.Button_way2.Text="way2(Python)";
        app.Button_instruction.FontName="Segoe UI";
        app.Button_instruction.Text=['instruction',newline,'(must-read)'];
        app.Button_importPic.FontName="Segoe UI";
        app.Button_importPic.Text="import picture";
        app.TextArea_ways.FontName="Segoe UI";
        app.TextArea_ways.Value=['Way1:',newline,'Support jpg/png format;',newline,'Support bmp format',newline,newline,'Way2:',newline, ...
           'Support jpg/png format;',newline,'Supports svg format containing only one path and exported from Adobe Illustrator'];
        app.Label_originalPic.FontName="Segoe UI";
        app.Label_originalPic.Text="original picture";
        app.Label_svgPaths.FontName="Segoe UI";
        app.Label_svgPaths.Text="edge/svg paths image";
        app.Button_dynamicFFT.FontName="Segoe UI";
        app.Button_dynamicFFT.Text="Image FFT dynamic display";
        if app.ButtonGroup_ways.SelectedObject==app.Button_way2 && app.picChoose~=0
            app.Button_dynamicFFT.Tooltip="Please set the parameters first (see below)";
        else
            app.Button_dynamicFFT.Tooltip='';
        end
        app.EditField_4Label.FontName = 'Segoe UI';
        app.EditField_4Label.Text="Contour sampling rate";
        app.EditField_edgeSampleRate.Tooltip = {'range[0,1]'; ...
            'The higher the value, the longer the calculation time'};
        app.EditField_5Label.FontName="Segoe UI";
        app.EditField_5Label.Text = 'Fourier coefficient calculation threshold';
        app.EditField_fourierThreshold.Tooltip = {'range[10,2000]'; ...
            'The higher the value, the longer the calculation time'};
        app.Label_6.FontName="Segoe UI";
        app.Label_6.Text = 'Whether to perform curve fitting';
        app.DropDown_curveFitting.Items = {'discrete', 'fitting'};
        app.DropDown_curveFitting.Tooltip = {'Fitting is not recommended'};
        app.DropDown_curveFitting.FontName = 'Segoe UI';
        app.Label_4.FontName="Segoe UI";
        app.Label_4.Text = 'Fourier circle rotation speed';
        app.EditField_rotationSpeed.Tooltip = {'range[1e-4,10]'; ...
            'The higher the value, the higher the frequency'};
        app.Label_5.FontName="Segoe UI";
        app.Label_5.Text = 'Whether to clear existing tracks when redrawing';
        app.DropDown_clearOrbit.Items = {'yes', 'no'};
        app.DropDown_clearOrbit.FontName = 'Segoe UI';
        app.Button_importMusic.FontName="Segoe UI";
        app.Button_importMusic.Text="import music";
        app.Button_playMusic.FontName="Segoe UI";
        app.Button_playMusic.Text="play";
        app.Button_pauseMusic.FontName="Segoe UI";
        app.Button_pauseMusic.Text="pause";
        app.Button_resumeMusic.FontName="Segoe UI";
        app.Button_resumeMusic.Text="resume";
        app.Button_stopMusic.FontName="Segoe UI";
        app.Button_stopMusic.Text="stop";
        app.Button_preMusic.FontName="Segoe UI";
        app.Button_preMusic.Text="previous music";
        app.Button_nextMusic.FontName="Segoe UI";
        app.Button_nextMusic.Text="next music";
        app.Button_stengthenVoice.FontName="Segoe UI";
        if app.isEnhanceHumanVoice==false
            app.Button_stengthenVoice.Text="vocal enhancement";
        else
            app.Button_stengthenVoice.Text="cancel vocal enhancement";
        end
        app.Button_voicePrinciple.FontName="Segoe UI";
        app.Button_voicePrinciple.Text="principle";
        app.UIAxes_timeWave.Title.String = 'Real-time Wave Form';
        app.UIAxes_spectrum.Title.String = 'Real-time Spectrum';
        app.Button_part.FontName="Segoe UI";
        app.Button_part.Text="Part";
        app.Button_whole.FontName="Segoe UI";
        app.Button_whole.Text="Whole";
        app.Button_violin.Text="violin";
        app.Button_viola.Text="viola";
        app.Button_cello.Text="cello";
        app.Button_bass.Text="bass";
        app.Button_guitar.Text="guitar";
        app.Button_keyboard.Text="keyboard";
        app.Button_flute.Text="flute";
        app.Button_saxophone.Text="saxophone";
        app.Button_piano.Text="piano";
        app.Button_drums.Text="drums";
        app.Button_marimba.Text="marimba";
        app.Button_glockenspiel.Text="glockenspiel";
        app.Button_harpsichord.Text="harpsichord";
        app.Button_bowbells.Text="bow bells";
        app.Button_melodyorgan.Text="melody organ";
        app.Button_trumpet.Text="trumpet";
        app.Button_instruPlay.FontName="Sogoe UI";
        app.Button_instruPlay.Text="play instrument";
        app.ButtonGroup_instrument.Tooltip={'Click the instrument play button twice in a row to start playing;'; ...
            'Click the stop button to stop playing'};
        app.ButtonGroup_instrument.FontName="Segoe UI";
        app.ButtonGroup_instrument.Title="Instrument Harmonic Structure";
        app.UIAxes_musicInstrument.Title.String="Harmonic Structure";
        app.Hyperlink_pythonDownload.FontName="Segoe UI";
        app.Hyperlink_pythonDownload.Text="Python Download Link";
        app.TextArea_soundSignal.Value="This interface realizes audio feature analysis, silence detection " + ...
            "and voice change processing of the interaction between matlab and arduino. " + ...
            "Please enter the arduino connection port first (please confirm it on the PC " + ...
            "device manager), execute the bat program (and make sure that no other program " + ...
            "occupies the port, and you can view it in Task Manager - Details of your PC)," + ...
            " check and connect the circuit diagram, click the icon in " + ...
            "the upper right corner (with the arduino download link), copy the arduino " + ...
            "program and upload it to the arduino uno development board (baud rate set to 115200), " + ...
            "make sure to close the arduino program and click connect button and read the audio information transmitted " + ...
            "by the sound sensor through the start and end buttons.";
        app.DropDown_port.Tooltip="Click to update option";
        app.Label_7.Tooltip = {'The capacitance of the sound sensor can be manually adjusted to scale the delivered signal'};
        app.Button_connectArduino.Tooltip="Connection speed is slow, please be patient";
        app.Button_connectArduino.FontName="Segoe UI";
        app.Button_connectArduino.Text="connect";
        app.Button_bat.FontName="Segoe UI";
        app.Button_bat.Text="run bat";
        app.Button_circuit.FontName="Segoe UI";
        app.Button_circuit.Text="circuit";
        app.UITable_extractData.ColumnName = {'time'; 'avg'; 'max'; 'dom freq'; 'zcr'};
        app.Label_7.FontName="Segoe UI";
        app.Label_7.Text = 'Minimum signal collection value';
        app.Button_sStart.FontName="Segoe UI";
        app.Button_sStart.Text="start";
        app.Button_sEnd.FontName="Segoe UI";
        app.Button_sEnd.Text="end";
        app.Button_sExport.FontName="Segoe UI";
        app.Button_sExport.Text="export mute filtering";
        app.Button_sPlay.FontName="Segoe UI";
        app.Button_sPlay.Text="play";
        app.Button_sStop.FontName="Segoe UI";
        app.Button_sStop.Text="stop";
        app.Panel_changeVoice.FontName="Segoe UI";
        app.Panel_changeVoice.Title="Change Voice";
        app.Button_changeVoicePlay.FontName="Segoe UI";
        app.Button_changeVoicePlay.Text="play";
        app.Button_changeVoiceStop.FontName="Segoe UI";
        app.Button_changeVoiceStop.Text="stop";
        app.Button_femaleVoice.Text="female";
        app.Button_maleVoice.Text="male";
        app.Button_cartoonVoice.Text="cartoon";
        app.Button_robotVoice.Text="robot";
        app.Button_devArduino.Text="use arduino";
        app.Button_devMicrophone.Text="use microphone";
        app.Button_lstart.FontName="Segoe UI";
        app.Button_lstart.Text="start";
        app.Button_lend.FontName="Segoe UI";
        app.Button_lend.Text="end";
        app.Button_connectArduino_2.Tooltip="Connection speed is slow, please be patient";
        app.Button_connectArduino_2.FontName="Segoe UI";
        app.Button_connectArduino_2.Text="connect";
        app.Button_bat_2.FontName="Segoe UI";
        app.Button_bat_2.Text="run bat";
        app.Button_circuit_2.FontName="Segoe UI";
        app.Button_circuit_2.Text="circuit";
        app.UITable_light.ColumnName = {'Time'; 'Resistance'; 'Relative Light Intensity'; 'Peak Frequency'; 'Spectral Energy'};
        app.TextArea_lightSignal.Value="This interface implements the analysis of the time domain waveform and spectrum energy distribution " + ...
            "of the light intensity signal that interacts between MATLAB and Arduino." + ...
            "Please enter the Arduino connection port first (please confirm on the PC device manager), " + ...
            "execute the bat program (and make sure that no other program occupies the port)," + ...
            "View and connect the circuit diagram, click the icon in the upper right corner (with the Arduino " + ...
            "download link), copy the Arduino program and upload it to the Arduino Uno development board" + ...
            "(Set the baud rate to 115200), make sure to close the Arduino program and click the connect button," + ...
            "Read the photoresistor information transmitted by the photosensor through the start and end buttons.";
        app.DropDown_port_2.Tooltip="Click to update option";
        app.UIAxes_lightWaveform.Title.String = 'Real-time light intensity signal';
        app.UIAxes_lightWaveform.XLabel.String = 'time';
        app.UIAxes_lightWaveform.YLabel.String = 'light intensity';
        app.UIAxes_lightSpectrum.Title.String = 'Spectral energy distribution';
        app.UIAxes_lightSpectrum.XLabel.String = 'frequency (Hz)';
        app.UIAxes_lightSpectrum.YLabel.String = 'amplitude';
        app.Button_importMusic_2.FontName="Segoe UI";
        app.Button_importMusic_2.Text="Import music";
        app.Button_analyzeMusic.FontName="Segoe UI";
        app.Button_analyzeMusic.Text="FFT anlaysis";
        app.Button_startMG.FontName="Segoe UI";
        app.Button_startMG.Text="start";
        app.Button_stopMG.FontName="Segoe UI";
        app.Button_stopMG.Text="end";
        app.Label_8.FontName="Segoe UI";
        app.Label_8.Text="volume";
        app.Button_playMG.FontName="Segoe UI";
        app.Button_playMG.Text="play";
        app.Node_picFFT.Text="Image FFT";
        app.Node_way1.Text="Method 1";
        app.Node_edge.Text="Contour image (export png)";
        app.Node_way2.Text="Method 2";
        app.Node_svg.Text="svg path image (export svg)";
        app.Node_picPa.Text="Parameter table (export csv/mat)";
        app.Node_fft.Text="Fourier coefficients (export txt)";
        app.Node_audioFFT.Text="Audio FFT";
        app.Node_audioWave.Text="Waveform (export png)";
        app.Node_audioSpectrum.Text="Spectrum (export png)";
        app.Node_instrument.Text="Instrument harmonic image (export png)";
        app.Node_ligntArduino.Text="arduino optical signal processing";
        app.Node_ligntPa.Text="Parameter table (export csv/mat)";
        app.Node_lightWave.Text="waveform (export png)";
        app.Node_lightSpectrum.Text="spectrum (export png)";
        app.Node_soundArduino.Text="arduino sound signal processing";
        app.Node_arduino.Text="arduino interface";
        app.Node_arduinoPa.Text="parameter table (export csv/mat)";
        app.Node_threshold.Text="collection minimum value parameter (export mat)";
        app.Node_ardWave.Text="waveform (export png)";
        app.Node_ardSpectrum.Text="spectrum (export png)";
        app.Node_silence.Text="silence detection image (export png)";
        app.Node_origin.Text="original waveform of sound change processing (export png)";
        app.Node_processed.Text="processed waveform of sound change processing (export png)";
        app.Node_microphone.Text="microphone interface";
        app.Node_micWave.Text="Waveform (export png)";
        app.Node_micSpectrum.Text="Spectrum (export png)";
        app.Node_micOrigin.Text="Original waveform of voice change processing (export png)";
        app.Node_micProcessed.Text="Processed waveform of voice change processing (export png)";
        app.Node_musicGame.Text="Real-time music game";
        app.Node_mgSpectrum.Text="Spectrum (export png)";
        app.Node_score.Text="Score (export mat)";
        app.Node_practice.Text="Interactive practice";
        app.Node_analysis.Text="Question analysis (export txt)";
        app.Button_exportData.FontName="Segoe UI";
        app.Button_exportData.Text="Export data";
        app.Image_self.Tooltip="App author";
        app.Button_re1.Tooltip="Re-transmit data";
        app.Button_re2.Tooltip="Re-transmit data";
        app.Button_killPython.FontName="Segoe UI";
        app.Button_killPython.Text="Interrupt Python";
        app.Button_openPde.FontName="Segoe UI";
        app.Button_openPde.Text="Open pde file";
        app.Button_sExport.Tooltip="Only supports Arduino device";
        if app.ButtonGroup_device.SelectedObject==app.Button_devArduino % 当前使用arduino
            app.Button_sPlay.Tooltip="Play silence removal file";
        else % 当前使用PC麦克风
            app.Button_sPlay.Tooltip="Play recording file";
        end
    end
end