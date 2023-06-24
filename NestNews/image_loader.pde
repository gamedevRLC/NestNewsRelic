
//This class is for the loading the images
class imageLoader{
  /*
   These are its variables
   The boolean is for when a picture is present in the news messages arraylist
   The integers are for the start time, time passed, the picture in the images arraylist to show, and what line in the text file it's analyzing
   The Strings are for the date entered in the program and the url of the pictures
   The ArrayList of Strings are for all of the messages for the current date
  */
  boolean pic_detected, goodsize;
  int messageline, pics, time, start_time;
  PImage pic;
  ArrayList<String> messages = new ArrayList<String>();
  ArrayList<PImage> images = new ArrayList<PImage>();

  //This is the constructor of the class. It takes in the entered date in the sketch
  imageLoader(ArrayList<String> _TodaysNews){
    //These initialize the the variables
    messageline = 0;
    pics = 0;
    start_time = 0;
    pic_detected = false;
    messages = _TodaysNews;
    
    if(messages.size() != 0) {
      /*
       Splits all of the lines from messages by every comma,
       if the length of the line is 4, a picture has been detected 
       and the last part of the line is the url of the picture
       From then on, the image from that link is added to an 
       arraylist of images
       */
      for(int i = 0; i < messages.size(); i++){
        String[] Line = split(messages.get(i).trim(), ',');          
        if(Line.length == 4){
          pic_detected = true;
          println("Image Loader: An image has been found");
          images.add(loadImage(Line[3]));
        } else if (Line.length < 4) {
          pic_detected = false;
          println("Image Loader: No image with the news");
        }
      }
    }
  }

  void update(){
    //The picture is updated if the size of the messages list is not zero
    if(messages.size() != 0){
      //Time is counting forward
      time = (millis() - start_time)/1000;

      //Once 5 seconds have passed
      if(time >= 5){
        //The next line in the messages arraylist is analyzed
        messageline = messageline + 1;
        println("Image Loader: loading next news image");
        //The timer resets
        start_time = millis();
        
        //If there are no more lines in the messages ArrayList to analyze it loops back to the first line
        if(messageline > messages.size() - 1){
          messageline = 0;
        }
        
        /*
          The line in the messages arraylist is split into pices
          If 4 pieces are in the line, a picture has been detected
        */
        String[] Line = split(messages.get(messageline).trim(), ',');
        if (Line.length == 4) {
           pic_detected = true;
           println("Image Loader: An image has been found");
        } else if (Line.length < 4) {
          pic_detected = false;
          println("Image Loader: No image with the news");
        }
        
        //If a pcture has beeen detected, it will be the next picture to be displayed in the arraylist
        if(pic_detected == true){
          pics = pics + 1;
        }
      }
      
      //If there are no more lines in the images ArrayList to analyze, it loops back to the first line
      if(pics >= images.size()){
        pics = 0;
      }
    }
  }

  void picture(){
    //If a picture has been detected, it will be shown on the screen
    if(images.size() > 0){
      if(images.get(pics).width != 1920 && images.get(pics).height != 1080){
        goodsize = false;
      } else {
        goodsize = true;
      }
      if(pic_detected == true && goodsize == true){
        imageMode(CENTER);
        image(images.get(pics), width * .5, height * .5);
      }
    }
  }
}
