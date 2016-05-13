PImage eyeball_image;
PImage monster_images[] = new PImage[3];
Monster eyeball;
Player player;
ArrayList<Spell> spells;
ArrayList<Monster> monsters;
int score = 0;
boolean gameover = false;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  monster_images[0] = loadImage("eyeball.png");
  monster_images[1] = loadImage("spider.png");
  monster_images[2] = loadImage("wasp.png");
  player = new Player();
  
  spells = new ArrayList<Spell>();
  monsters = new ArrayList<Monster>();
  monsters.add(new Monster(0, 10, height/2, Element.LIGHT, Element.DARK, 3));
}


void draw(){
  if(gameover){
    fill(255, 0, 0);
    textSize(48);
    text("Game over", width/2, height/2);
    return;
  }
  background(255, 255, 255);
  stroke(0, 0, 0);
  strokeWeight(1);
  
  player.update();
  
  for(int i=0; i<spells.size(); i++){
    spells.get(i).update();
  }
  
  for(int i=0; i<monsters.size(); i++){
    monsters.get(i).update();
  }
  fill(0, 0, 0);
  textSize(24);
  text(score, 15, 15);
  
  stroke(255, 0, 0);
  strokeWeight(3);
  line(715, 0, 715, 600);
  
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
      monsters.add(new Monster(type, 10, height/2, Element.LIGHT, Element.DARK, 3));
      break;
    }
    case 1:{
      monsters.add(new Monster(type, 10, height/2, Element.FIRE, Element.EARTH, 1.5));
      break;
    }
    case 2:{
      monsters.add(new Monster(type, 10, height/2, Element.WIND, Element.EARTH, 4));
      break;
    }
  }
}