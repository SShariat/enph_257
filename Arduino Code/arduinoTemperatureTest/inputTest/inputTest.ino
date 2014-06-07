void setup() {
  Serial.begin(9600);
}

void loop() {
  float sensorValue = (analogRead(5) * 5.0)/1023.0;
  Serial.println(sensorValue);              
}
