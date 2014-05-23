int sensor = A0;
int sensorValue = 0;
float voltageValue = 0;

void setup()
{
	Serial.begin(9600);
}

void loop()
{
	sensorValue = analogRead(sensor);
	
	voltageValue = (sensorValue) * 5.0 / 1023.0;
	
	Serial.println(voltageValue);
}
