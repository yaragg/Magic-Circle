import processing.serial.*;
String portname = "COM3";  
Serial port; 
String myString = "";
PImage eyeball_image;
PImage monster_images[] = new PImage[4];
PImage bg;
PImage barriers[] = new PImage[6];
Element barrier_type;
Monster eyeball;
Player player;
ArrayList<Spell> spells;
ArrayList<Monster> monsters;
int score = 0;
boolean gameover = false;
int middle = 0, middlePrevious = 0;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  monster_images[0] = loadImage("eyeball.png");
  monster_images[1] = loadImage("spider.png");
  monster_images[2] = loadImage("wasp.png");
  monster_images[3] = loadImage("shadow.png");
  bg = loadImage("bg.png");
  barriers[Element.FIRE.ordinal()] = loadImage("fire_barrier.png");
  barriers[Element.WATER.ordinal()] = loadImage("water_barrier.png");
  barriers[Element.EARTH.ordinal()] = loadImage("earth_barrier.png");
  barriers[Element.LIGHT.ordinal()] = loadImage("light_barrier.png");
  barriers[Element.DARK.ordinal()] = loadImage("dark_barrier.png");
  barriers[Element.WIND.ordinal()] = loadImage("wind_barrier.png");
  barrier_type = Element.FIRE;
  player = new Player();
  
  spells = new ArrayList<Spell>();
  monsters = new ArrayList<Monster>();
  //monsters.add(new Monster(0, 10, height/2, Element.LIGHT, Element.DARK, 3));
  
  //port = new Serial(this, portname, 9600);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  //port.bufferUntil('\n');
}


void draw(){
  if(gameover){
    fill(255, 0, 0);
    textSize(48);
    text("Game over", width/2, height/2);
    return;
  }
  
  if(middle >= 100 && middlePrevious < 100){
    spells.add(new Spell(Element.LIGHT, 10, player.position, 4));
    print("Light");
  }
  
  //background(255, 255, 255);
  image(bg, width/2, height/2, width, height);
  stroke(0, 0, 0);
  strokeWeight(1);
  
  player.update();
  
  for(int i=0; i<spells.size(); i++){
    spells.get(i).update();
  }
  
  for(int i=0; i<monsters.size(); i++){
    monsters.get(i).update();
  }
  fill(255, 255, 255);
  textSize(24);
  text(score, 780, 15);
  
  //stroke(255, 0, 0);
  //strokeWeight(3);
  //line(715, 0, 715, 600);
  //line(700, 0, 700, 600);
  
  image(barriers[barrier_type.ordinal()], player.position.x, player.position.y, barriers[barrier_type.ordinal()].width, barriers[barrier_type.ordinal()].height);
  
  if(random(1)<0.01) generateMonster();
}

void keyPressed(){
  if(key == 'w'){
    spells.add(new Spell(Element.LIGHT, 10, player.position, 4));
    print("Light");
  }
  else if(key == 'd'){
    spells.add(new Spell(Element.DARK, 10, player.position, 4));
    print("Dark");
  }
  else if(key == 'f'){
    spells.add(new Spell(Element.FIRE, 10, player.position, 4));
    print("Fire");
  }
}

void generateMonster(){
  //generate type
  int type = int(random(0, monster_images.length));
  switch(type){
    case 0: {
      monsters.add(new Monster(type, 10, height/2+15, Element.LIGHT, Element.DARK, 3, 5));
      break;
    }
    case 1:{
      monsters.add(new Monster(type, 10, height/2+15, Element.FIRE, Element.EARTH, 1.5, 5));
      break;
    }
    case 2:{
      monsters.add(new Monster(type, 10, height/2+15, Element.WIND, Element.EARTH, 4, 4));
      break;
    }
    case 3:{
      monsters.add(new Monster(type, 10, height/2+15, Element.LIGHT, Element.DARK, 1, 7));
      break;
    }
  }
}

//void serialEvent(Serial myPort) { 
//  try {
//    // read the serial buffer:
//    myString = myPort.readStringUntil('\n');
//    // if you got any bytes other than the linefeed:
//    myString = trim(myString);
//    // split the string at the commas
//    // and convert the sections into integers:
//    //if (myString.length() > 0) {
//    //  int coords[] = int(split(myString, ','));
//    //  x = coords[0];
//    //  y = coords[1];
//    //  //int i = coords[0]; //which frequency?
//    //  //y = int(myString);
//    //  //ellipse(width/2, y, 50, 50);
//    //  //print(coords[0] + "," + coords[1]);
//    //  //equalizer[i][0] = coords[1]; //real magnitude
//    //  //equalizer[i][1] = coords[2]; //imaginary magnitude
//    //}
//    middlePrevious = middle;
//    middle = int(myString);
//  } 
//  catch (Exception e) {
//    print("?" + e);
//  }
//}