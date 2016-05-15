class Monster{
  PVector position;
  Element weakness; 
  Element resistance;
  float speed;
  int type;
  int radius;
  int health;
  Monster(int type, float x, float y, Element weakness, Element resistance, float speed, int health){
    position = new PVector(x, y);
    this.weakness = weakness;
    this.resistance = resistance;
    this.speed = speed;
    this.type = type;
    this.radius = (monster_images[type].width+monster_images[type].height)/2;
    this.health = health;
  }
  
  void update(){
    if(position.x >= 700 - monster_images[type].width/2 && weakness == barrier_type) die();
    if(position.x>=715) gameover = true;
    position.x += speed; 
    display();
  }
  
  void display(){
    image(monster_images[type], position.x, position.y, monster_images[type].width, monster_images[type].height);
  }
  
  void die(){
    score += 3;
    monsters.remove(this);
  }
  
  void damage(Spell s){
    int dam = 1;
    if(s.type == this.weakness){
      this.health -= 2*dam;
    }
    else if(s.type != this.resistance){
      this.health -= dam;
    }
    
    if(this.health <= 0) {
      die();
    }
  }
}