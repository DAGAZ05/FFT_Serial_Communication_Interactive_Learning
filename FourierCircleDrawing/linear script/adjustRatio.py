import cv2
import svgwrite
import os

script_dir = os.path.dirname(os.path.abspath(__file__))


def reduce_sampling(points, sampling_ratio):
    """
    减少轮廓点的采样比率
    :param points: 轮廓点列表，格式为 [(x1, y1), (x2, y2), ...]
    :param sampling_ratio: 采样比率（0到1之间的浮点数，例如0.5表示保留50%的点）
    :return: 采样后的点列表
    """
    if sampling_ratio <= 0 or sampling_ratio > 1:
        raise ValueError("采样比率必须在 (0, 1] 范围内")

    num_points = len(points)
    num_sampled = max(1, int(num_points * sampling_ratio))  # 至少保留一个点
    step = max(1, num_points // num_sampled)  # 计算采样间隔

    # 等间隔采样
    sampled_points = [points[i] for i in range(0, num_points, step)]

    # 确保起点和终点被保留
    if sampled_points[0] != points[0]:
        sampled_points.insert(0, points[0])
    if sampled_points[-1] != points[-1]:
        sampled_points.append(points[-1])

    return sampled_points


def contours_to_svg(input_image_path, output_svg_path, sampling_ratio=1.0):
    """
    将线稿图像转换为 SVG，并减少采样比率
    :param input_image_path: 输入图像路径
    :param output_svg_path: 输出 SVG 路径
    :param sampling_ratio: 采样比率（0到1之间的浮点数）
    """
    # 读取线稿图像
    edges = cv2.imread(input_image_path, cv2.IMREAD_GRAYSCALE)

    # 使用Canny边缘检测提取线稿
    canny_edges = cv2.Canny(edges, 100, 200)

    # 提取轮廓
    contours, _ = cv2.findContours(canny_edges, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)

    # 创建 SVG 文件
    height, width = edges.shape
    dwg = svgwrite.Drawing(output_svg_path,
                          size=(f"{width}px", f"{height}px"),
                          viewBox=f"0 0 {width} {height}")

    # 将轮廓转换为 SVG 路径
    for contour in contours:
        if len(contour) > 1:  # 至少需要两个点才能形成路径
            # 将轮廓点转换为列表格式 [(x1, y1), (x2, y2), ...]
            points = [tuple(point[0]) for point in contour]

            # 减少采样比率
            sampled_points = reduce_sampling(points, sampling_ratio)

            # 将采样后的点转换为 SVG 路径
            path_data = 'M ' + ' L '.join([f'{x},{y}' for x, y in sampled_points])
            dwg.add(dwg.path(d=path_data, fill='none', stroke='black', stroke_width=1))

    # 保存 SVG 文件
    dwg.save()
    print(f"SVG 文件已生成：{output_svg_path}")


# 使用
input_path = os.path.join(script_dir, 'picture_canny.png')
output_path = os.path.join(script_dir, 'picture.svg')

ratio = float(input())
contours_to_svg(input_path, output_path, sampling_ratio=ratio)
