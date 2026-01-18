from svgpathtools import svg2paths, wsvg
import numpy as np
import os

script_dir = os.path.dirname(os.path.abspath(__file__))


def scale_svg(input_svg_path, output_svg_path, max_size=(1920, 1080)):
    # 读取SVG文件中的路径和属性
    paths, attributes = svg2paths(input_svg_path)

    # 过滤掉没有实际路径段的路径
    valid_paths = [path for path in paths if len(path) > 0]

    # 获取SVG图形的边界框（bounding box）
    all_points = []
    for path in valid_paths:
        all_points.extend([path.point(t) for t in np.linspace(0, 1, 100)])  # 采样路径上的点
    all_points = np.array([(p.real, p.imag) for p in all_points])  # 转换为二维坐标

    # 计算当前图形的宽度和高度
    min_x, min_y = np.min(all_points, axis=0)
    max_x, max_y = np.max(all_points, axis=0)
    width = max_x - min_x
    height = max_y - min_y

    # 计算缩放比例
    scale = min(max_size[0] / width, max_size[1] / height)

    # 缩放路径
    scaled_paths = [path.scaled(scale, scale) for path in valid_paths]

    # 将缩放后的路径保存为新的SVG文件
    wsvg(scaled_paths, attributes=attributes, filename=output_svg_path)


# 使用示例
input_svg = os.path.join(script_dir, 'picture.svg')  # 输入 SVG 文件路径
output_svg = os.path.join(script_dir, 'picture.svg')  # 输出 SVG 文件路径
scale_svg(input_svg, output_svg)
