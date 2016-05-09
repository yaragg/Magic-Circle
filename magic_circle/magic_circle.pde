PImage eyeball_image;
PImage monster_images[] = new PImage[1];
Monster eyeball;
Player player;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  monster_images[0] = loadImage("eyeball.png");
  player = new Player();
  eyeball = new Monster(0, 10, height/2, Element.LIGHT, Element.DARK, 3);
}


void draw(){
  background(255, 255, 255);
  eyeball.update();
  eyeball.display();
  
  player.update();
  player.display();
}