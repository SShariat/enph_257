void setup()
{
	Serial.begin(9600);
}

void loop() 
{
        float rand = 1.72;
	rand = random(10);
	
	Serial.println(rand);
	
	delay(50);
}
