import cv2
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

source_path = os.path.join(script_dir, 'picture.png')

# 读取图片
image = cv2.imread(source_path)

# 转换为灰度图像
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 使用Canny边缘检测
edges = cv2.Canny(gray, 100, 200)

picture_path = os.path.join(script_dir, 'picture_canny.png')

# 保存线稿
cv2.imwrite(picture_path, edges)
