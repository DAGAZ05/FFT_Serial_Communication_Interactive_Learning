const int photocellPin = A0;

void setup() {
  Serial.begin(115200);
}

void loop() {
  int outputvalue = analogRead(photocellPin);
  Serial.println(outputvalue);
  delay(200);
}
