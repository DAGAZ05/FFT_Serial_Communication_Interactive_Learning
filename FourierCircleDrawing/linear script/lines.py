import re
import svgwrite
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
        paths.append(commands)
    return paths


# 检查两个点是否相邻
def are_points_close(point1, point2, distance_threshold=10):
    return abs(point1[0] - point2[0]) < distance_threshold and abs(point1[1] - point2[1]) < distance_threshold


# 连接多个相邻路径
def connect_adjacent_paths(paths, distance_threshold=10):
    connected_paths = []
    used = [False] * len(paths)

    for i in range(len(paths)):
        if not used[i]:
            current_path = paths[i]
            used[i] = True
            # 获取当前路径的首尾点
            start_point = (float(current_path[0][1]), float(current_path[0][2]))
            end_point = (float(current_path[-1][1]), float(current_path[-1][2]))
            # 继续检查是否有更多相邻路径
            while True:
                found_adjacent = False
                for j in range(len(paths)):
                    if not used[j]:
                        other_start_point = (float(paths[j][0][1]), float(paths[j][0][2]))
                        other_end_point = (float(paths[j][-1][1]), float(paths[j][-1][2]))
                        # 检查当前路径的尾点与其他路径的首点是否相邻
                        if are_points_close(end_point, other_start_point, distance_threshold):
                            current_path.extend(paths[j])
                            used[j] = True
                            end_point = (float(current_path[-1][1]), float(current_path[-1][2]))
                            found_adjacent = True
                        # 检查当前路径的首点与其他路径的尾点是否相邻
                        elif are_points_close(start_point, other_end_point, distance_threshold):
                            current_path = paths[j] + current_path
                            used[j] = True
                            start_point = (float(current_path[0][1]), float(current_path[0][2]))
                            found_adjacent = True
                # 如果没有找到更多相邻路径，则退出循环
                if not found_adjacent:
                    break
            connected_paths.append(current_path)
    return connected_paths


# 生成新的 SVG 文件
def generate_svg(connected_paths, output_svg):
    # 创建 SVG 画布
    dwg = svgwrite.Drawing(output_svg, size=("100%", "100%"))

    for path in connected_paths:
        # 将路径命令和坐标转换为 SVG 路径格式
        path_data = " ".join([f"{cmd} {x},{y}" for cmd, x, y in path])
        # 添加路径到 SVG
        dwg.add(dwg.path(d=path_data, fill="none", stroke="black", stroke_width=2))

    # 保存 SVG 文件
    dwg.save()
    print(f"SVG file saved to {output_svg}")


# 主函数
def main():
    input_svg = os.path.join(script_dir, 'picture.svg')  # 输入 SVG 文件路径
    output_svg = os.path.join(script_dir, 'picture.svg')  # 输出 SVG 文件路径
    distance_threshold = 20  # 相邻点的距离阈值

    # 读取 SVG 文件内容
    with open(input_svg, "r") as f:
        svg_content = f.read()

    # 解析 SVG 路径
    paths = parse_svg_path(svg_content)
    if not paths:
        print("No paths found in the SVG.")
        return

    # 连接相邻路径
    connected_paths = connect_adjacent_paths(paths, distance_threshold)
    if not connected_paths:
        print("No paths connected.")
        return

    # 生成新的 SVG 文件
    generate_svg(connected_paths, output_svg)


# 运行主函数
if __name__ == "__main__":
    main()
