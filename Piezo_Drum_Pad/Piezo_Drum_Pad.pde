#Copyleft
#rileyporter@gmail.com
# To be used with Make Project Tutorial at:
#http://makeprojects.com/Project/Simple-Arduino-Drum-Pad-and-Game/

int piezoPin = 2; 
int ledPin = 13; 
int hit = 0;
int total = 0;
int hitRegister = 35;

unsigned long currentTime;
unsigned long lastTime;


void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT); // declare the ledPin as an OUTPUT
}


void loop() { 
  hit = (analogRead(piezoPin));	// read the value of a hit from the piezo sensor

    if (hit <= hitRegister)
    {
      digitalWrite(ledPin, HIGH);
      Serial.print(1);
      delay(130); //lame debouncing
      digitalWrite(ledPin, LOW);
  }
}


