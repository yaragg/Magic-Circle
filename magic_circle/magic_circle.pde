import processing.serial.*;
String portname = "COM3";  
Serial port; 
String myString = "";
PImage monster_images[] = new PImage[6];
PImage bg;
PImage barriers[] = new PImage[6];
Element barrier_type;
Player player;
ArrayList<Spell> spells;
ArrayList<Monster> monsters;
int score = 0;
boolean gameover = false;
boolean center = false;
boolean light = false, dark = false, fire = false, water = false, earth = false, wind = false;
boolean shift = false;
int lastFired = -10;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  monster_images[0] = loadImage("eyeball.png");
  monster_images[1] = loadImage("spider.png");
  monster_images[2] = loadImage("wasp.png");
  monster_images[3] = loadImage("shadow.png");
  monster_images[4] = loadImage("fire_slime.png");
  monster_images[5] = loadImage("drake.png");
  bg = loadImage("bg.png");
  barriers[Element.FIRE.ordinal()] = loadImage("fire_barrier.png");
  barriers[Element.WATER.ordinal()] = loadImage("water_barrier.png");
  barriers[Element.EARTH.ordinal()] = loadImage("earth_barrier.png");
  barriers[Element.LIGHT.ordinal()] = loadImage("light_barrier.png");
  barriers[Element.DARK.ordinal()] = loadImage("dark_barrier.png");
  barriers[Element.WIND.ordinal()] = loadImage("wind_barrier.png");
  player = new Player();
  
  port = new Serial(this, portname, 9600);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  port.bufferUntil('\n');
  
  restart();
}

void restart(){
  spells = new ArrayList<Spell>();
  monsters = new ArrayList<Monster>();
  barrier_type = Element.FIRE;
  score = 0;
  myString = "";
  lastFired = -10;
  light = false;
  dark = false;
  fire = false;
  water = false;
  earth = false;
  wind = false;
  gameover = false;
}


void draw(){
  if(gameover){
    center = false;
    fill(255, 0, 0);
    textSize(48);
    text("Game over", width/2, height/2);
    fill(255, 255, 255);
    textSize(30);
    text("Press center to continue", width/2, height/2+50);
    if(center)
      restart();
    return;
  }
  
  processInput();

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
  text(score, 770, 15);
  
  image(barriers[barrier_type.ordinal()], player.position.x, player.position.y, barriers[barrier_type.ordinal()].width, barriers[barrier_type.ordinal()].height);
  
  if(random(1)<0.01) generateMonster();
}

void cast(Element e){
  if(frameCount - lastFired < 10) return;
  lastFired = frameCount;
  spells.add(new Spell(e, 10, player.position, 4));
}

void processInput(){
  if(light){
    if(center) barrier_type = Element.LIGHT;
    else cast(Element.LIGHT);
  }
  if(dark){
    if(center) barrier_type = Element.DARK;
    else cast(Element.DARK);
  }
  if(fire){
    if(center) barrier_type = Element.FIRE;
    else cast(Element.FIRE);
  }
  if(water){
    if(center) barrier_type = Element.WATER;
    else cast(Element.WATER);
  }
  if(earth){
    if(center) barrier_type = Element.EARTH;
    else cast(Element.EARTH);
  }
  if(wind){
    if(center) barrier_type = Element.WIND;
    else cast(Element.WIND);
  }
}

void keyPressed(){
  if(keyCode==SHIFT){
    shift = true;
    print("SHIFTPRESS");
  }
  if(key == 'w'){
    if(shift) barrier_type = Element.LIGHT;
    else spells.add(new Spell(Element.LIGHT, 10, player.position, 4));
   // barrier_type = Element.LIGHT;
    print("Light");
  }
  else if(key == 'd'){
    if(shift) barrier_type = Element.DARK;
    else spells.add(new Spell(Element.DARK, 10, player.position, 4));
    print("Dark");
  }
  else if(key == 'f'){
    if(shift) barrier_type = Element.FIRE;
    else spells.add(new Spell(Element.FIRE, 10, player.position, 4));
    print("Fire");
  }
  else if(key == 'a'){
    if(shift) barrier_type = Element.WATER;
    else spells.add(new Spell(Element.WATER, 10, player.position, 4));
    print("Water");
  }
  else if(key == 'q'){
    if(shift) barrier_type = Element.WIND;
    else spells.add(new Spell(Element.WIND, 10, player.position, 4));
    print("Wind");
  }
  else if(key == 's'){
    if(shift) barrier_type = Element.EARTH;
    else spells.add(new Spell(Element.EARTH, 10, player.position, 4));
    print("Earth");
  }
}

void keyReleased(){
  if(keyCode==SHIFT){
    shift = false;
    print("SHIFTRELEASE");
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
    case 4:{
      monsters.add(new Monster(type, 10, height/2+15, Element.WATER, Element.FIRE, 2, 4));
      break;
    }
    case 5:{
      monsters.add(new Monster(type, 10, height/2+15, Element.EARTH, Element.WIND, 2, 10));
      break;
    }
  }
}

void serialEvent(Serial myPort) { 
try {
  // read the serial buffer:
  myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);
  if(myString.length() > 0){
    int values[] = int(split(myString, ','));
    if(values.length == 7){
      center = values[0]>100? true : false;
      light = values[1]>100? true : false;
      dark = values[2]>100? true : false;
      fire = values[3]>100? true : false;
      water = values[4]>100? true : false;
      earth = values[5]>100? true : false;
      wind = values[6]>100? true : false;
    }
  }
} 
catch (Exception e) {
  print("?" + e);
}
}