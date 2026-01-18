from PIL import Image
import os

script_dir = os.path.dirname(os.path.abspath(__file__))


def resize_image(input_image_path, output_image_path, max_size=(1920, 1080)):
    with Image.open(input_image_path) as img:
        # 计算缩放比例
        width, height = img.size
        ratio = min(max_size[0] / width, max_size[1] / height)
        new_size = (int(width * ratio), int(height * ratio))

        # 使用 resize 方法放大图片
        resized_img = img.resize(new_size, Image.Resampling.LANCZOS)
        resized_img.save(output_image_path)


input_path = os.path.join(script_dir, 'picture.png')
output_path = os.path.join(script_dir, 'picture.png')

# 使用示例
resize_image(input_path, output_path)
