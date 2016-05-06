class Monster{
  PVector position;
  int weakness; 
  int speed;
  int type;
  Monster(int type, float x, float y, int weakness, int speed){
    position = new PVector(x, y);
    this.weakness = weakness;
    this.speed = speed;
    this.type = type;
  }
  
  void update(){
    position.x += speed; 
    display();
  }
  
  void display(){
    image(monster_images[type], position.x, position.y, monster_images[type].width, monster_images[type].height);
  }
}