
//This is the class for the moving pictures
class MovingPic {
  /*
   These are its varibles.
   The booleans are for its left motion
   The float is for the index of the default images to display
   The float is for its speed when moving
   The PVectors are for its x,y coordinates and its width and hieght
   The image is of the the picture itself
   */
  boolean left;
  int imageIndex;
  float speed;
  PVector location, size;
  PImage pic;
  ArrayList<String> defaultpic_paths = new ArrayList<String>();

  //This is the constructor of the class. It takes in the image itself and speed
  MovingPic(float _speed, ArrayList<String> _pic_paths) {
    speed = _speed;
    defaultpic_paths = _pic_paths;
    //These initialize the other variables
    location = new PVector(-width/4, 0);
    size = new PVector();
    left = true;
    imageIndex = 0;
  }

  void draw() {
    //tint(255, 125);
    if (pic != null){
      imageMode(CORNER);
      image(pic, location.x, location.y - (pic.height * .25));
    }  else if (pic == null) {
    background(0);
    }
    
  }

  void movement() {
    //This allows the pictures to move to the left when the left boolean is true
    if (left == true) {
      location.x = location.x - (speed/widthProportion);
    }
  }
  
  //this function updates the banner image
  void update(){
    if(location.x <= -width/4){
      try {//Attempt to load the image
        pic = loadImage(defaultpic_paths.get(imageIndex));
      } catch (OutOfMemoryError x) {//If the image is too big to load
        //go to another index in the default images arraylist
        println("Image too big...trying another");
        imageIndex = imageIndex + 1;
        if (imageIndex > defaultpic_paths.size() - 1) {
          imageIndex = 0;
        }
        return;
      }
      
      //println the image that's going to be resized
      println("Resizing image: " + defaultpic_paths.get(imageIndex));
      
      //access the images actual dimensions and calculate its final dimensions
      float imageWidth = pic.width;
      float finalWidth = ((width * 2)/imageWidth) * imageWidth;
      float imageHeight = pic.height;
      float finalHeight = ((height * 2)/imageHeight) * imageHeight;
      
      //resize the image
      pic.resize(int(finalWidth), int(finalHeight));
        
      //set its x location to 0
      location.x = 0;
      
      //go to the next index in default pics arraylist
      imageIndex = imageIndex + 1;
      
      //if all the default pics have been shown, loop back to the first one
      if (imageIndex > defaultpic_paths.size() - 1) {
        imageIndex = 0;
      }
    }
  }
}
