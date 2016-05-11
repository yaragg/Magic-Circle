class Player{
  PImage wizard_image;
  PVector position;
  
  Player(){
    wizard_image = loadImage("wizard.png");
    position = new PVector(750, height/2);
  }
  
  void update(){
  }
  
  void display(){
    image(wizard_image, position.x, position.y, wizard_image.width, wizard_image.height);
  }
}