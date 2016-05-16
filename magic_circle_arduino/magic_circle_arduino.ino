#include <CapacitiveSensor.h>

CapacitiveSensor center = CapacitiveSensor(5,7);
CapacitiveSensor light = CapacitiveSensor(5,3);
CapacitiveSensor dark = CapacitiveSensor(12, 9);
CapacitiveSensor fire = CapacitiveSensor(12, 11);
CapacitiveSensor water = CapacitiveSensor(12, 10);
CapacitiveSensor earth = CapacitiveSensor(5,4);
CapacitiveSensor wind = CapacitiveSensor(12, 8);

void setup()                    
{
   Serial.begin(9600);
}

void loop()                    
{
    Serial.print(center.capacitiveSensor(30));
    Serial.print(",");
    Serial.print(light.capacitiveSensor(30));
    Serial.print(",");
    Serial.print(dark.capacitiveSensor(30));
    Serial.print(",");
    Serial.print(fire.capacitiveSensor(30));
    Serial.print(",");
    Serial.print(water.capacitiveSensor(30));
    Serial.print(",");
    Serial.print(earth.capacitiveSensor(30));
    Serial.print(",");
    Serial.print(wind.capacitiveSensor(30));
    Serial.print("\n");
    delay(10);                             // arbitrary delay to limit data to serial port 
}
