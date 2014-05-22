int i = 0;
int start = 0;
int currentTime = 0;

void setup()
{
	Serial.begin(9600);
        start = millis();
}

void loop()
{
        Serial.println('Hi there!');
        while ( currentTime != (start + 1000)) {
        Serial.println(i);
        i++;
        currentTime = millis();
	}
}
