float datas[][][] = null; // 三维数组，存储多个路径的傅里叶系数
float rp[][][] = null;    // 三维数组，存储多个路径的极坐标形式
int maxCircle = -1;       // 最大圆圈数量，-1 表示无限制

int currentPath = 0;      // 当前绘制的路径索引
float t = -0f;            // 时间变量
PVector lastPos = new PVector(); // 上一个点的位置
PGraphics spot = null;    // 用于绘制轨迹的图形对象
PGraphics coord = null;   // 用于绘制坐标系的图形对象

void setup() {
  size(1920, 1080);
  spot = createGraphics(width, height);
  coord = createGraphics(width, height);
  coord.beginDraw();
  coord.stroke(0, 15, 25, 100);
  coord.line(0, coord.height / 2f, coord.width, coord.height / 2f);
  coord.line(coord.width / 2f, 0, coord.width / 2f, coord.height);
  coord.endDraw();

  // 读取 datas.txt 文件
  String sketchPath = sketchPath();
  String dataPath = sketchPath + "/datas.txt"; 
  String[] lines = loadStrings(dataPath);
  // String[] lines = loadStrings("datas.txt");
  String[] paths = join(lines, "\n").split("#"); // 用 # 分隔多个路径
  datas = new float[paths.length][][];
  rp = new float[paths.length][][];

  // 解析每个路径的傅里叶系数
  for (int p = 0; p < paths.length; p++) {
    String[] pathLines = split(paths[p], "\n");
    datas[p] = new float[pathLines.length][2];
    rp[p] = new float[pathLines.length][2];
    for (int i = 0; i < pathLines.length; i++) {
      String cache[] = split(pathLines[i], ",");
      if (cache.length < 2) {
        break;
      }
      datas[p][i][0] = Float.parseFloat(cache[0].replace("[", ""));
      datas[p][i][1] = Float.parseFloat(cache[1].replace("]", ""));
      rp[p][i][0] = sqrt(datas[p][i][0] * datas[p][i][0] + datas[p][i][1] * datas[p][i][1]);
      rp[p][i][1] = atan2(datas[p][i][1], datas[p][i][0]);
    }
  }
}

void draw() {
  String sketchPath = sketchPath();
  String rotationPath = sketchPath + "/rotationSpeed.txt"; 
  float rotationSpeed = float(loadStrings(rotationPath)[0]);//Speed of rotation
  String clearPath = sketchPath + "/clearOrbit.txt"; 
  int clearOrbit = int(loadStrings(clearPath)[0]);//Speed of rotation
  background(255);
  t += rotationSpeed;

  // 如果 t 超过 π，切换到下一个路径
  if (t >= PI) {
    t = 0;
    currentPath = (currentPath + 1) % datas.length; // 循环切换路径
    lastPos.set(0, 0); // 重置上一个点的位置
    
    if(currentPath==0 && clearOrbit==1){
      spot.clear(); // 完整绘制一遍后清除轨迹
    }
  } 

  image(coord, 0, 0);
  PVector center = new PVector();
  PVector pointer = new PVector();
  noFill();
  stroke(255);

  // 获取当前路径的傅里叶系数
  float[][] currentDatas = datas[currentPath];
  float[][] currentRp = rp[currentPath];
  int num = (maxCircle > 0) ? min(maxCircle, currentDatas.length) : currentDatas.length;

  // 绘制傅里叶圆圈
  for (int i = 0; i < num; i++) {
    int m = 0;
    if (i > 0) m = ((i + 1) / 2) * ((i % 2 == 0) ? -1 : 1);
    float r = currentRp[i][0];
    stroke(175);
    ellipse(center.x + width / 2f, center.y + height / 2f, r * 2f, r * 2f);
    float theta = t * m + currentRp[i][1];
    pointer.add(new PVector(r * cos(theta), r * sin(theta)));
    if (m == 0) pointer.set(currentDatas[0][0], currentDatas[0][1]);
    stroke(100);
    line(center.x + width / 2f, center.y + height / 2f, pointer.x + width / 2f, pointer.y + height / 2f);
    center.set(pointer);
  }

  // 绘制轨迹
  if (t >= 0) {
    spot.beginDraw();
    spot.noStroke();
    spot.fill(0, 0, 0);
    spot.translate(spot.width / 2f, spot.height / 2f);
    spot.ellipse(pointer.x, pointer.y, 5, 5);
    spot.endDraw();
    image(spot, 0, 0);
  }
  lastPos.set(pointer);
}
