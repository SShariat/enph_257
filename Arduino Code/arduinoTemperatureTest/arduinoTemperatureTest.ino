int sensor = A0;
int sensorValue = 0;

void setup()
{
	Serial.begin(4800);
}

void loop()
{
	sensorValue = analogRead(sensor);

        //to do: convert this sensor value (an integer between 0 & 1023) to an actual voltage.	

	Serial.println(sensorValue);
        delay(200);
}
