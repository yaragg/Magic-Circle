import processing.serial.*;
String portname = "COM3";  
Serial port; 
String myString = "";
int[][] equalizer; //store real/imaginary values for each freq
int margin = 10;
int midy;
int y = 10;
int x = 10;

void setup() 
{

  size(600, 600);
  background(255);
  frameRate(300);
  strokeWeight(4);
  stroke(53);
  //smooth();
  midy = height/2; //center of canvas

  //Find right # in Serial.list()
  println(Serial.list());
  //portname = Serial.list()[2];
  println("Port: " + portname);

  port = new Serial(this, portname, 9600);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  port.bufferUntil('\n');
  equalizer = new int[512][2];
}

void draw() {

  background(255);
  /*
  for (int i = 0; i < equalizer.length; i++) {
    int x = 4*i + margin;
    line(x, midy - equalizer[i][0], x, midy);
    line(x, midy + equalizer[i][1], x, midy);
  }*/
  ellipse(x, y, 50, 50);
}
// serialEvent  method is run automatically by the Processing applet
// whenever the buffer reaches the  byte value set in the bufferUntil() 
// method in the setup():

void serialEvent(Serial myPort) { 
  try {
    // read the serial buffer:
    myString = myPort.readStringUntil('\n');
    // if you got any bytes other than the linefeed:
    myString = trim(myString);
    // split the string at the commas
    // and convert the sections into integers:
    if (myString.length() > 0) {
      int coords[] = int(split(myString, ','));
      x = coords[0];
      y = coords[1];
      //int i = coords[0]; //which frequency?
      //y = int(myString);
      //ellipse(width/2, y, 50, 50);
      //print(coords[0] + "," + coords[1]);
      //equalizer[i][0] = coords[1]; //real magnitude
      //equalizer[i][1] = coords[2]; //imaginary magnitude
    }
  } 
  catch (Exception e) {
    print("?" + e);
  }
}