const int soundPin = A0;
const int silenceThreshold = 560;  // 静音阈值（根据实际环境调整）
const unsigned long minSilenceDuration = 1000; // 最小静音持续时间(ms)
const unsigned long minSoundDuration = 600;   // 最小有声持续时间(ms)

bool lastState = false;
unsigned long stateStartTime = 0;

void setup() {
  Serial.begin(115200);
}

void loop() {
  int soundValue = analogRead(soundPin);
  bool currentState = (soundValue < silenceThreshold);
  unsigned long currentTime = millis();

  // 状态持续时间检测
  if(currentState != lastState) {
    unsigned long stateDuration = currentTime - stateStartTime;
    
    // 检查前一个状态是否满足最小持续时间
    if(lastState) { // 之前是静音状态
      if(stateDuration >= minSilenceDuration) {
        Serial.print("SILENCE_END:");
        Serial.println(currentTime);
      } else {
        // 忽略短时静音
        lastState = currentState; // 保持状态不变
        return;
      }
    } 
    else { // 之前是有声状态
      if(stateDuration >= minSoundDuration) {
        Serial.print("SILENCE_START:");
        Serial.println(currentTime);
      } else {
        // 忽略短时有声
        lastState = currentState;
        return;
      }
    }
    
    // 更新状态记录
    stateStartTime = currentTime;
    lastState = currentState;
  }
  
  // 持续发送原始数据（用于波形显示）
  Serial.print("DATA:");
  Serial.println(soundValue);
  delay(200); // 采样间隔
}