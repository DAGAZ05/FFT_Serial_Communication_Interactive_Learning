import math
import cmath
import re
import time
import multiprocessing
import importlib  # 用于动态导入模块
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

# 检查是否安装了 PyTorch
try:
    torch = importlib.import_module("torch")  # 动态导入 PyTorch
    HAS_TORCH = True
    print("PyTorch 已安装，将尝试使用 GPU 加速计算。")
except ImportError:
    HAS_TORCH = False
    print("PyTorch 未安装，将在 CPU 上进行计算。")


def bezier(t, a, b, c, d):
    return (-a + 3 * b - 3 * c + d) * t * t * t + 3 * (a - 2 * b + c) * t * t + 3 * (-a + b) * t + a


def linear(x, a, b, c, d):
    return (x - a) / (b - a) * (d - c) + c


oneOver2PI = 1 / (math.pi * 2)


def prSolve(m, cs, ce, n):
    if m == 0:
        return (ce - cs) * oneOver2PI / (n + 1)
    if n == 0:
        denominator = m
        if denominator == 0:
            return 0  # 避免除以零
        return 1j * oneOver2PI / denominator * (cmath.exp(-m * 1j * ce) - cmath.exp(-m * 1j * cs))
    elif n > 0:
        denominator = (ce - cs) * m
        if denominator == 0:
            return 0  # 避免除以零
        return 1j * oneOver2PI / m * cmath.exp(-m * 1j * ce) - n * 1j / denominator * prSolve(m, cs, ce, n - 1)
    else:
        return 0


def numSolve(m, cs, ce, pts):
    if len(pts) < 4:
        return 0  # 如果 pts 长度不足，返回 0
    return (-pts[0] + 3 * pts[1] - 3 * pts[2] + pts[3]) * prSolve(m, cs, ce, 3) + \
           3 * (pts[0] - 2 * pts[1] + pts[2]) * prSolve(m, cs, ce, 2) + \
           3 * (-pts[0] + pts[1]) * prSolve(m, cs, ce, 1) + \
           pts[0] * prSolve(m, cs, ce, 0)


def cpToList(cp):
    return [cp.real, cp.imag]


def parsePaths(rawdata):
    paths = []
    rawPaths = rawdata.split("#")  # 用 # 分隔多个路径
    for rawPath in rawPaths:
        curve = re.sub(r'\s', '', rawPath)
        cells = re.findall(r'\w[\d\,\-\.]+', curve)
        path = []
        for cell in cells:
            trcdata = []
            formatString = re.sub(r'-', ',-', cell)
            trcdata.append(re.match(r'[A-Za-z]', formatString).group(0))
            rawvers = re.sub(r'[A-Za-z]\,?', '', formatString).split(',')
            for st in range(len(rawvers)):
                rawvers[st] = float(rawvers[st])
            vergroup = []
            vercurgrp = []
            for st in range(len(rawvers)):
                vercurgrp.append(rawvers[st])
                if len(vercurgrp) >= 2:
                    vergroup.append(vercurgrp[0] + vercurgrp[1] * 1j)
                    vercurgrp.clear()
            if len(vercurgrp) > 0:
                if re.match(r'v', trcdata[0], re.I):
                    vergroup.append(0 + vercurgrp[0] * 1j)
                elif re.match(r'h', trcdata[0], re.I):
                    vergroup.append(vercurgrp[0] + 0j)
            trcdata.append(vergroup)
            path.append(trcdata)
        paths.append(path)
    return paths


def calculateFourier(paths, start, end):
    allFourierCoefficients = []
    for path in paths:
        points = []
        curWeight = []
        center = [960, 540]  # 中心点位置

        # 解析路径数据
        for i in range(1, len(path)):
            if re.match(r'[a-z]', path[i][0]):
                for j in range(len(path[i][1])):
                    path[i][1][j] += path[i - 1][1][-1]
        for i in range(len(path)):
            flag = path[i][0]
            if re.match(r'm', flag, re.I):
                continue
            path[i][1].insert(0, path[i - 1][1][-1])
            if re.match(r's', flag, re.I):
                path[i][1].insert(1, 2 * path[i - 1][1][-1] - path[i - 1][1][-2])
            if re.match(r'[lvh]', flag, re.I):
                path[i][1].insert(1, path[i][1][0] / 3 + path[i][1][-1] * 2 / 3)
                path[i][1].insert(1, path[i][1][0] * 2 / 3 + path[i][1][-1] / 3)
        for i in range(len(path)):
            flag = path[i][0]
            if re.match(r'm', flag, re.I):
                continue
            points.append(path[i][1])
        for i in range(len(points)):
            for j in range(len(points[i])):
                points[i][j] -= center[0] + 1j * center[1]

        # 计算时间权重
        wsum = 0
        for curve in points:
            wst = 10  # steps
            sum = 0
            for i in range(1, wst):
                sum += abs(bezier(linear(i, 0, wst, 0, 1), curve[0], curve[1], curve[2], curve[3]) -
                       bezier(linear(i - 1, 0, wst, 0, 1), curve[0], curve[1], curve[2], curve[3]))
            curWeight.append(sum)
            wsum += sum
        for i in range(len(curWeight)):
            curWeight[i] /= wsum
        for i in range(1, len(curWeight)):
            curWeight[i] += curWeight[i - 1]
        curWeight.insert(0, 0)
        curWeight[-1] = 1

        # 根据是否安装了 PyTorch 选择计算方式
        if HAS_TORCH:
            # 使用 PyTorch 加速计算
            device = torch.device("cuda" if torch.cuda.is_available() else "cpu")  # 检查 GPU 是否可用
            points_tensor = torch.tensor(points, dtype=torch.complex128, device=device)  # 将数据移动到 GPU
            curWeight_tensor = torch.tensor(curWeight, dtype=torch.float64, device=device)
            out = []
            for s in range(start, end + 1):
                m = 0
                if s > 0:
                    m = ((s + 1) // 2) * (-1 if (s % 2 == 0) else 1)
                sum_tensor = torch.zeros(1, dtype=torch.complex128, device=device)  # 使用 GPU 计算
                for i in range(len(points_tensor)):
                    cs = linear(curWeight_tensor[i].item(), 0, 1, 0, math.pi * 2)
                    ce = linear(curWeight_tensor[i + 1].item(), 0, 1, 0, math.pi * 2)
                    sum_tensor += numSolve(m, cs, ce, points_tensor[i])
                out.append(cpToList(sum_tensor.cpu().numpy()[0]))  # 将结果移回 CPU
            allFourierCoefficients.append(out)
        else:
            # 在 CPU 上进行计算
            out = []
            for s in range(start, end + 1):
                m = 0
                if s > 0:
                    m = ((s + 1) // 2) * (-1 if (s % 2 == 0) else 1)
                sum = 0j
                for i in range(len(points)):
                    cs = linear(curWeight[i], 0, 1, 0, math.pi * 2)
                    ce = linear(curWeight[i + 1], 0, 1, 0, math.pi * 2)
                    sum += numSolve(m, cs, ce, points[i])
                out.append(cpToList(sum))
            allFourierCoefficients.append(out)
    return allFourierCoefficients


if __name__ == '__main__':
    # 定义傅里叶系数的计算范围
    start = 0
    end = int(input())  # 输入傅里叶系数个数
    input_path = os.path.join(script_dir, 'rawvertexes.txt')
    output_path = os.path.join(script_dir, 'datas.txt')

    with open(input_path, 'r') as f:
        rawdata = f.read()

    paths = parsePaths(rawdata)
    allFourierCoefficients = calculateFourier(paths, start, end)

    # 输出到 datas.txt
    with open(output_path, "w") as f:
        for i, coefficients in enumerate(allFourierCoefficients):
            for j, coeff in enumerate(coefficients):
                f.write(f"[{coeff[0]}, {coeff[1]}]")
                if j < len(coefficients) - 1:
                    f.write("\n")
            if i < len(allFourierCoefficients) - 1:
                f.write("#")

    print("输出完成")
