# FFT_Serial_Communication_Interactive_Learning

**Chinese version:**

本次课程设计基于本人对快速傅里叶变换（以下简称FFT）的初步学习，同时与基于Arduino Uno开发板的串口通信相结合，实现了从理论到交互的FFT基础学习。

本App的主界面分为以下9个栏目，其分别实现的主要功能如下：

1. FFT理论：

展示FFT的相关文档，内容包括历史溯源、欧拉公式、FS（傅里叶级数）、FT（傅里叶变换）、DFS（离散傅里叶级数）、DTFT（离散时间傅里叶变换）、DFT（离散傅里叶变换）、FFT、MATLAB中常用的FFT工具及FFT的常见问题等内容。

![1](pictures%20for%20README/1.png)

2. 简易图形示范：

展示方波的傅里叶变换相关图像；实时绘制闭合图形的傅里叶变换动态图像；展示FFT（包括DFT等相关内容）在图形上的应用的文档。

![2](pictures%20for%20README/2.png)

3. 图像FFT：

可选择两种方式进行图像的FFT应用。方式1：基于C++，提取jpg/png/bmp图像的轮廓并提供傅里叶圆的动态展示；方式2：基于Python（需PC自带Python解释器），提取jpg/png的硬边缘或单路径svg，对路径进行快速傅里叶变换，通过processing程序进行图像渲染，可以手动调整5个相关参数。

![3](pictures%20for%20README/3.png)

4. 音频FFT：

实现了简单的音乐播放器界面，并基于FFT绘制歌曲的波形图、频谱图；基于FFT实现人声增强；播放内置的不同乐器演奏的歌曲，通过FFT对不同乐器的谐波结构进行分析。

![4](pictures%20for%20README/4.png)

5. Arduino声信号处理：

提供自动获取可用端口及连接Arduino串口的方式；提供Arduino Uno的线路连接方式（基于声音传感器）；通过FFT显示波形、频谱及静音检测的动态图像，并动态更新参数表；实现静音过滤；实现音频的变声处理（基于FFT将原音频转换为男声、女声、卡通声或机器声），录音设备支持Arduino Uno及PC麦克风。

![5](pictures%20for%20README/5.png)

6. Arduino光信号处理：

提供自动获取可用端口及连接Arduino串口的方式；提供Arduino Uno的线路连接方式（基于光敏传感器）；收集光信号并实时更新参数表；基于FFT显示波形图、频谱图。

![6](pictures%20for%20README/6.png)

7. 实时音游：

导入歌曲并对其进行主频分析；基于FFT模拟歌曲的音符并实现音游界面。

![7](pictures%20for%20README/7.png)

8. 交互练习：

用户完成10道FFT相关的检测题，可显示答案。

![8](pictures%20for%20README/8.png)

9. 数据导出：

可导出前述模块中涉及的部分文档、图像、参数表等。

![9](pictures%20for%20README/9.png)

此外，边栏也提供了相关说明文档展示、语言切换、图像导入、音频导入、获取PC的Python解释器、查看Arduino程序等功能，并支持界面大小缩放。

本人曾在初中阶段就对DFT、FFT等数学工具有所了解，当时研究的动机为拟合曲线，从而用参数方程描述任意由轮廓构成的图像，制作这一App也是为了总结曾经的所学及进一步的收获、提炼。对于用户而言，本App旨在让用户初步了解FFT及其应用，并激发学习兴趣，在更广阔的应用空间里运用FFT这一数学工具，实现对物质世界的数学建模与解析。

本项目的最终成功（MATLAB App）可以从以下链接下载：[百度网盘](https://pan.baidu.com/s/1fGxbgO7D_WCVlzc2ju0d8g?pwd=9m3b)。

**说明**：

1. 项目要求用户安装有MATLAB R2022b或以上版本（支持MATLAB App）、Python 3.10或以上版本，运行串口通信功能时需具有最新版本的Arduino IDE以及Arduino Uno开发板；
2. 若直接运行本仓库下载的项目源代码文件，并使用图像FFT功能的方式2时，请根据以下链接，在pre目录中下载processing-3.4-windows64.zip（不要从其他来源下载，否则会出错；下载路径务必正确；不用解压）：[百度网盘](https://pan.baidu.com/s/1d5968GkHBChgQrDczhQUjg?pwd=i3n6)。

**版权及第三方依赖**：

[1]：界面中的校徽图案仅用于标识学校归属，无商业用途，版权归西北工业大学所有。

[2]：软件中直接引用或在他人创作基础上修改的HTML文档的来源如下：

https://blog.csdn.net/zhang0558/article/details/136840352；https://www.jezzamon.com/fourier/zh-cn.html；https://github.com/TheKOG/Fourier_Draw；https://github.com/ruanluyu/FourierCircleDrawing。

[3]：KaTeX（用于HTML数学公式显示）：来源：https://github.com/KaTeX/KaTeX/releases，许可证：MIT。

Highlight.js（用于HTML代码显示）：来源：https://github.com/highlightjs/highlight.js/releases，许可证：BSD-3-Clause

[4]：网页截取自：https://www.jezzamon.com/fourier/zh-cn.html。

[5]：C++源程序来源：https://github.com/TheKOG/Fourier_Draw，许可证：MIT。

[6]：图像FFT栏目所展示的例图为西北工业大学吉祥物航小天的图像，该图像仅用于标识学校归属，无商业用途，版权归西北工业大学所有。

[7]：图像FFT栏目的基于Python选项中，导入svg功能所执行程序基本来自：https://github.com/ruanluyu/FourierCircleDrawing，许可证：MIT。

导入jpg/png功能的依赖执行程序为作者在以上源程序基础上进行较大范围修改得到的（增加了边缘提取、svg写入、svg路径提取与处理算法、动态调用GPU等）。

[8]：依赖的Processing 3.4程序包（包含在.mlappinstall中）来源：https://processing.org/download，许可证：GNU LGPL/GPL。

本软件中仅调用Processing 进行图像渲染，未修改Processing 源代码及库。

[9]：所执行Python脚本中依赖的库（软件中使用pip指令下载）：

| 库名称       | 最低版本  | 许可证       | 用途                    | 备注                    |
| ------------ | --------- | ------------ | ----------------------- | ----------------------- |
| cv2 (OpenCV) | 4.5.0     | Apache 2.0   | 计算机视觉              | 需安装opencv-python     |
| svgwrite     | 1.4.3     | MIT          | 生成 SVG 矢量图形文件   |                         |
| svgpathtools | 1.5.1     | MIT          | 解析和操作 SVG 路径数据 | 依赖 numpy              |
| numpy        | 1.21.0    | BSD-3-Clause | 数值计算                |                         |
| PIL (Pillow) | 9.0.0     | HPND         | 图像处理                | 需安装 pillow           |
| PyTorch      | 与GPU适配 | BSD-3-Clause | 深度学习                | 通过 PyPI 或 Conda 安装 |

[10]：乐器播放所使用的音频来源自提供免费下载的公共网站，无版权侵犯。

----

**English version:**

This course design is based on my initial learning of the Fast Fourier Transform (FFT) and combines it with serial communication based on the Arduino Uno development kit to achieve a comprehensive FFT learning experience from theory to interaction.

The main interface of this app is divided into the following 9 sections, each implementing the following main functions:

1. FFT Theory:

Displays relevant FFT documentation, including historical background, Euler's formula, FS (Fourier series), FT (Fourier transform), DFS (Discrete Fourier series), DTFT (Discrete-Time Fourier Transform), DFT (Discrete Fourier Transform), FFT, commonly used FFT tools in MATLAB, and common FFT issues.

![1](pictures%20for%20README/1.png)

2. Simple Graphical Demonstration:

Displays Fourier transform images of square waves; real-time plotting of Fourier transform dynamic images of closed figures; documentation demonstrating the application of FFT (including DFT and related content) in graphics.

![2](pictures%20for%20README/2.png)

3. Image FFT:

Allows users to choose two methods for applying FFT to images. 

Method 1: Based on C++, extracts the outline of JPG/PNG/BMP images and provides a dynamic display of Fourier circles.

Method 2: Based on Python (requires a PC with a built-in Python interpreter), extracts hard edges or single-path SVG from JPG/PNG images, performs Fast Fourier Transform on the path, and renders the image using the Processing program. Five related parameters can be manually adjusted.

![3](pictures%20for%20README/3.png)

4. Audio FFT:

Implements a simple music player interface and draws waveform and spectrum diagrams of songs based on FFT; enhances vocals based on FFT; plays songs played by different built-in instruments and analyzes the harmonic structure of different instruments using FFT.

![4](pictures%20for%20README/4.png)

5. Arduino Sound Signal Processing:

Provides automatic acquisition of available ports and connection methods for Arduino serial ports; provides wiring methods for Arduino Uno (based on a sound sensor); displays waveforms, spectrums, and dynamic images of silence detection using FFT and dynamically updates the parameter table; implements silence filtering; implements audio voice changing processing (converting the original audio to male, female, cartoon, or robotic voices based on FFT); recording devices support Arduino Uno and PC microphones.

![5](pictures%20for%20README/5.png)

6. Arduino Optical Signal Processing:

Provides automatic acquisition of available ports and connection methods for the Arduino serial port; provides wiring methods for the Arduino Uno (based on a photosensitive sensor); collects optical signals and updates the parameter table in real time; displays waveforms and spectrum diagrams based on FFT.

![6](pictures%20for%20README/6.png)

7. Real-time Music Game:

Imports songs and performs frequency analysis; simulates song notes based on FFT and implements a music game interface.

![7](pictures%20for%20README/7.png)

8. Interactive Exercises:

Users complete 10 FFT-related test questions, and the answers are displayed.

![8](pictures%20for%20README/8.png)

9. Data Export:

Can export some documents, images, parameter tables, etc., involved in the aforementioned modules.

![9](pictures%20for%20README/9.png)

In addition, the sidebar also provides functions such as displaying relevant documentation, language switching, image import, audio import, obtaining the PC's Python interpreter, viewing Arduino programs, and supports interface scaling.

I had some understanding of mathematical tools such as DFT and FFT during junior high school. My motivation at that time was to fit curves, thereby using parametric equations to describe any image composed of contours. This app was created to summarize my past learning and further refine my findings. This app aims to provide users with a basic understanding of FFT and its applications, sparking their interest in learning and enabling them to utilize FFT as a mathematical tool in a broader range of applications to achieve mathematical modeling and analysis of the material world.

The final version of this project (MATLAB App) can be downloaded from the following link: [Baidu Netdisk](https://pan.baidu.com/s/1fGxbgO7D_WCVlzc2ju0d8g?pwd=9m3b).

**Notes**:

1. This project requires users to have MATLAB R2022b or later (supports MATLAB App), Python 3.10 or later, and the latest version of the Arduino IDE and Arduino Uno development kit to run the serial communication function;

2. If you are directly running the project source code file downloaded from this repository and using the image FFT function of method 2, please download processing-3.4-windows64.zip from the pre directory according to the following link (do not download from other sources, otherwise errors will occur; the download path must be correct; no need to unzip): [Baidu Netdisk](https://pan.baidu.com/s/1d5968GkHBChgQrDczhQUjg?pwd=i3n6).

**Copyright and Third-Party Dependencies**:

[1]: The school emblem in the interface is used only to identify the school's affiliation and has no commercial use. Copyright belongs to Northwestern Polytechnical University.

[2]: The sources of HTML documents directly referenced in the software or modified based on others' creations are as follows:

https://blog.csdn.net/zhang0558/article/details/136840352; https://www.jezzamon.com/fourier/zh-cn.html; https://github.com/TheKOG/Fourier_Draw; https://github.com/ruanluyu/FourierCircleDrawing.

[3]: KaTeX (used for displaying HTML mathematical formulas): Source: https://github.com/KaTeX/KaTeX/releases, License: MIT. Highlight.js (for HTML code display): Source: https://github.com/highlightjs/highlight.js/releases, License: BSD-3-Clause

[4]: Webpage screenshot from: https://www.jezzamon.com/fourier/zh-cn.html

[5]: C++ source code source: https://github.com/TheKOG/Fourier_Draw, License: MIT

[6]: The example image displayed in the Image FFT section is an image of Hang Xiaotian, the mascot of Northwestern Polytechnical University. This image is only used to identify the school and has no commercial use. The copyright belongs to Northwestern Polytechnical University.

[7]: The program executed by the import svg function in the Python-based option of the Image FFT section is basically from: https://github.com/ruanluyu/FourierCircleDrawing, License: MIT. The executable program for importing jpg/png is a modified version of the source code (with added edge extraction, SVG writing, SVG path extraction and processing algorithms, and dynamic GPU access).

[8]: The Processing 3.4 package (included in .mlappinstall) is available at https://processing.org/download and licensed under GNU LGPL/GPL.

This software only calls Processing for image rendering and does not modify the Processing source code or libraries.

[9]: Libraries required by the executed Python script (downloaded using pip in the software):

| Library Name | Minimum Version | License      | Purpose                              | Remarks                   |
| ------------ | --------------- | ------------ | ------------------------------------ | ------------------------- |
| cv2 (OpenCV) | 4.5.0           | Apache 2.0   | Computer Vision                      | Requires opencv-python    |
| svgwrite     | 1.4.3           | MIT          | Generates SVG vector graphics files  |                           |
| svgpathtools | 1.5.1           | MIT          | Parses and manipulates SVG path data | Depends on numpy          |
| numpy        | 1.21.0          | BSD-3-Clause | Numerical Computation                |                           |
| PIL (Pillow) | 9.0.0           | HPND         | Image Processing                     | Requires pillow           |
| PyTorch      | GPU Compatible  | BSD-3-Clause | Deep Learning                        | Install via PyPI or Conda |

[10]: The audio used for the instrument playback came from a public website that offered free downloads and did not infringe on any copyrights.
