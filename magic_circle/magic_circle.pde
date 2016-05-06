PImage eyeball_image;
PImage monster_images[] = new PImage[1];
Monster eyeball;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  monster_images[0] = loadImage("eyeball.png"); 
  eyeball = new Monster(0, 10, height/2, 0, 5);
}


void draw(){
  background(255, 255, 255);
  eyeball.update();
}