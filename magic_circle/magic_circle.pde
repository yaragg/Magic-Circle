PImage eyeball_image;
PImage monster_images[] = new PImage[1];
Monster eyeball;
Player player;
ArrayList<Spell> spells;
ArrayList<Monster> monsters;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  monster_images[0] = loadImage("eyeball.png");
  player = new Player();
  
  spells = new ArrayList<Spell>();
  monsters = new ArrayList<Monster>();
  monsters.add(new Monster(0, 10, height/2, Element.LIGHT, Element.DARK, 3));
}


void draw(){
  background(255, 255, 255);
  
  player.update();
  player.display();
  
  for(int i=0; i<spells.size(); i++){
    spells.get(i).update();
  }
  
  for(int i=0; i<monsters.size(); i++){
    monsters.get(i).update();
    monsters.get(i).display();
  }
}

void keyPressed(){
  if(key == 'w'){
    spells.add(new Spell(Element.LIGHT, 10, player.position, 4));
    print("Light");
  }
}