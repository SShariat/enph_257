float rand = 0.0;

void setup()
{
	Serial.begin(9600);
}

void loop() 
{
	rand = random(10);
	
	Serial.println(rand);
	
	delay(50);
}
