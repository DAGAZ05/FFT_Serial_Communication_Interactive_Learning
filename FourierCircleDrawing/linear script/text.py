from svgpathtools import svg2paths
import os

script_dir = os.path.dirname(os.path.abspath(__file__))


def reverse_path(path_data):
    """将路径从尾到头反转（仅支持 M 和 L 命令），并去掉重复的结尾点"""
    # 提取所有点
    commands = path_data.strip().split()
    points = []
    current_command = None

    for token in commands:
        if token in ["M", "L"]:
            # 记录当前命令
            current_command = token
        elif current_command in ["M", "L"]:
            # 提取坐标部分
            try:
                x, y = map(float, token.split(","))
                points.append((x, y))
            except ValueError:
                # 如果坐标解析失败，跳过
                continue

    # 反转点列表（去掉最后一个点，避免重复）
    reversed_points = points[-2::-1]  # 从倒数第二个点开始，到第一个点结束

    # 构建反转后的路径
    reversed_path = []
    for i, (x, y) in enumerate(reversed_points):
        if i == 0:
            reversed_path.append(f"L {x},{y}")  # 第一个点使用 L 命令
        else:
            reversed_path.append(f"L {x},{y}")

    return " ".join(reversed_path)


def extend_path(path_data):
    """将路径从尾到头重复一遍，去掉重复的结尾点"""
    if not path_data:
        return path_data  # 如果路径数据为空，直接返回

    # 原始路径
    original_path = path_data
    # 反转路径
    reversed_path = reverse_path(path_data)
    # 拼接路径
    extended_path = f"{original_path} {reversed_path}"
    return extended_path


def svg_to_rawvertexes(svg_file, output_file):
    """将 SVG 文件中的路径写入 rawvertexes.txt，每条路径用 # 分隔"""
    # 读取 SVG 文件中的路径
    paths, attributes = svg2paths(svg_file)

    with open(output_file, "w") as f:
        for i, attr in enumerate(attributes):
            # 获取路径的 d 属性
            path_data = attr.get("d", "")
            # 扩展路径
            extended_path = extend_path(path_data)
            # 写入文件
            f.write(extended_path)
            f.write("z")
            # 如果不是最后一条路径，添加分隔符 #
            if i < len(paths) - 1:
                f.write("#")
    print(f"SVG 路径已写入 {output_file}")


# 示例调用
svg_file = os.path.join(script_dir, 'picture_sort.svg')  # 输入的 SVG 文件
output_file = os.path.join(script_dir, 'rawvertexes.txt')  # 输出的文本文件
svg_to_rawvertexes(svg_file, output_file)
