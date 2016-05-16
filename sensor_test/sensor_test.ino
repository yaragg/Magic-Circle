#include <CapacitiveSensor.h>

/*
 * CapitiveSense Library Demo Sketch
 * Paul Badger 2008
 * Uses a high value resistor e.g. 10M between send pin and receive pin
 * Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
 * Receive pin is the sensor pin - try different amounts of foil/metal on this pin
 */


CapacitiveSensor   cs_7_5 = CapacitiveSensor(12,11);        // 10M resistor between pins 5 & 7, pin 5 is sensor pin, add a wire and or foil if desired
//CapacitiveSensor   cs_7_9 = CapacitiveSensor(7,9); 
void setup()                    
{
   //cs_7_5.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
   
   Serial.begin(9600);
}

void loop()                    
{
    long start = millis();
    long total1 =  cs_7_5.capacitiveSensor(30);
//    long total2 =  cs_7_9.capacitiveSensor(30);

    Serial.print(total1);                  // print sensor output 1
//    Serial.print(",");
//    Serial.print(total2);
    Serial.print("\n");

    delay(10);                             // arbitrary delay to limit data to serial port 
}
