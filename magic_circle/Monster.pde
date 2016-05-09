class Monster{
  PVector position;
  Element weakness; 
  Element resistance;
  int speed;
  int type;
  Monster(int type, float x, float y, Element weakness, Element resistance, int speed){
    position = new PVector(x, y);
    this.weakness = weakness;
    this.resistance = resistance;
    this.speed = speed;
    this.type = type;
  }
  
  void update(){
    position.x += speed; 
  }
  
  void display(){
    image(monster_images[type], position.x, position.y, monster_images[type].width, monster_images[type].height);
  }
}