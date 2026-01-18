import sys
import os
import re
from pathlib import Path

script_dir = os.path.dirname(os.path.abspath(__file__))


def extract_svg_path_to_txt(svg_file_path, output_txt_path):
    """
    从SVG文件中提取路径数据并保存到TXT文件

    参数:
        svg_file_path: 输入的SVG文件路径
        output_txt_path: 输出的TXT文件路径

    如果SVG中包含多个路径，则直接退出程序
    """
    # 读取SVG文件内容
    try:
        with open(svg_file_path, 'r', encoding='utf-8') as svg_file:
            svg_content = svg_file.read()
    except FileNotFoundError:
        print(f"错误: 文件 {svg_file_path} 不存在")
        sys.exit(1)
    except Exception as e:
        print(f"读取SVG文件时出错: {e}")
        sys.exit(1)

    # 使用正则表达式查找所有路径
    path_matches = re.findall(r'<path\s[^>]*d="([^"]*)"', svg_content, re.IGNORECASE)

    # 检查路径数量
    if len(path_matches) != 1:
        print(f"错误: SVG文件中包含 {len(path_matches)} 个路径，要求只能有1个")
        sys.exit(1)

    # 获取路径数据
    path_data = path_matches[0]

    # 写入TXT文件
    try:
        with open(output_txt_path, 'w', encoding='utf-8') as txt_file:
            txt_file.write(path_data)
        print(f"成功将路径数据保存到 {output_txt_path}")
    except Exception as e:
        print(f"写入TXT文件时出错: {e}")
        sys.exit(1)


if __name__ == "__main__":
    # 示例用法
    svg_path = os.path.join(script_dir, 'input.svg')
    txt_path = os.path.join(script_dir, 'rawvertexes.txt')

    # 检查SVG文件是否存在
    if not Path(svg_path).exists():
        print(f"错误: SVG文件 {svg_path} 不存在")
        sys.exit(1)

    extract_svg_path_to_txt(svg_path, txt_path)