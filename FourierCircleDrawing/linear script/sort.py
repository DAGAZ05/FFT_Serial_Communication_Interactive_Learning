import re
import svgwrite
import numpy as np
import os

script_dir = os.path.dirname(os.path.abspath(__file__))


# 解析 SVG 路径
def parse_svg_path(svg_content):
    paths = []
    # 使用正则表达式提取路径数据
    path_data = re.findall(r'<path.*?d="([^"]+)"', svg_content)
    for data in path_data:
        # 解析路径命令和坐标
        commands = re.findall(r'([ML])\s*([\d\.]+),([\d\.]+)', data)
        paths.append({
            "data": data,  # 原始路径数据
            "commands": commands,  # 解析后的命令和坐标
            "start": (float(commands[0][1]), float(commands[0][2])),  # 起点坐标
            "end": (float(commands[-1][1]), float(commands[-1][2]))  # 终点坐标
        })
    return paths


# 计算两个点之间的欧几里得距离
def calculate_distance(point1, point2):
    return np.linalg.norm(np.array(point1) - np.array(point2))


# 重新排序路径
def reorder_paths(paths):
    if not paths:
        return paths

    # 初始化重新排序后的路径列表
    reordered_paths = [paths[0]]
    remaining_paths = paths[1:]

    while remaining_paths:
        last_end = reordered_paths[-1]["end"]  # 当前最后一个路径的终点
        # 找到与当前终点最接近的路径
        closest_index = -1
        closest_distance = float('inf')
        for i, path in enumerate(remaining_paths):
            distance = calculate_distance(last_end, path["start"])
            if distance < closest_distance:
                closest_distance = distance
                closest_index = i
        # 将找到的路径添加到重新排序后的列表中
        reordered_paths.append(remaining_paths[closest_index])
        # 从剩余路径中移除已添加的路径
        remaining_paths.pop(closest_index)

    return reordered_paths


# 生成新的 SVG 文件
def generate_svg(reordered_paths, output_svg):
    # 创建 SVG 画布
    dwg = svgwrite.Drawing(output_svg, size=("100%", "100%"))

    for path in reordered_paths:
        # 添加路径到 SVG
        dwg.add(dwg.path(d=path["data"], fill="none", stroke="black", stroke_width=2))

    # 保存 SVG 文件
    dwg.save()
    print(f"SVG file saved to {output_svg}")


# 主函数
def main():
    input_svg = os.path.join(script_dir, 'picture.svg')  # 输入 SVG 文件路径
    output_svg = os.path.join(script_dir, 'picture_sort.svg')  # 输出 SVG 文件路径

    # 读取 SVG 文件内容
    with open(input_svg, "r") as f:
        svg_content = f.read()

    # 解析 SVG 路径
    paths = parse_svg_path(svg_content)
    if not paths:
        print("No paths found in the SVG.")
        return

    # 重新排序路径
    reordered_paths = reorder_paths(paths)
    if not reordered_paths:
        print("No paths reordered.")
        return

    # 生成新的 SVG 文件
    generate_svg(reordered_paths, output_svg)


# 运行主函数
if __name__ == "__main__":
    main()
