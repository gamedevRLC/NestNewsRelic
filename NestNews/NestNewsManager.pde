
//This is the class for the Announcement

class NestNewsManager {
  
  /*
    These are the booleans
    They are for whether or not news is present, text needs to be wrapped,
    an image has been detected in the lines of news, and an image detected is
    a size that can be worked with.
  */
  
  boolean newsPresent, needWrapping, pic_detected, goodsize, showNews, showMotto;
  
  /*
    These are the integers
    They are for the specific line(index) in the messages arraylist to display,
    how many times a message has been displayed, the specific index(defaultMessage) in the defaultMessages to display,
    the specific image in the imgs arraylist to display, the amount of time a specific message will be displayed for, the exact time a message will expire
  */
  
  int line, messageCounter, defaultMessageIndex, pic, messgeTimelimit, messageExpireTime;
  
  /*
    These are the floats
    They are for the max amount of characters a piece of news can have, the actual amount of characters in a piece of news,
    the width of a text's wrapping, the width of the black bar, 2 specific wrapping widths, the height of a text's wrapping,
    the height of the black bar, 3 specific wrapping heights, 4 specific text sizes, and the location(x,y) of the text and black bar
  */
  float maxChar, messageLength, txtwrapWidth, boxWidth, wrapWidth1, wrapWidth2, textWrapHeight, boxHeight, boxHeight1, boxHeight2, boxHeight3, txtsize1, txtsize2, txtsize3, txtsize4, messageX, messageY;
  
  /*
    These are the Strings
    They are for the date entered and the specific message that needs to be displayed
  */
  String entered_date, message;
  
  /*
    The following arraylist are for the news messages found from the google spreadsheet, 
    a set of defaultMessages, a set of images from the google spreadsheet, 
    and dataPath locations for all of the defaultImages(Banners)
  */
  ArrayList<String> messages = new ArrayList<String>();
  ArrayList<String> defaultMessages = new ArrayList<String>();
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  ArrayList<String> banner_dataPaths = new ArrayList<String>();
  ArrayList<Announcement> announcements = new ArrayList<Announcement>();
  ArrayList<Announcement> defaultannouncements = new ArrayList<Announcement>();
  
  //This is an instance of the MovingPic class
  MovingPic Banner;
  
  //This is the constructor for the Announcement class. It takes in a String, an ArrayList of Strings, and an ArrayList of PImages as its parameters
  NestNewsManager(String _entered_date, ArrayList<Announcement> _announcements) {
    //The parameters are assigned to their corresponding variables
    entered_date = _entered_date;
    announcements = _announcements;
    
    //All the booleans are initialized as false, assuming there are no messages yet
    newsPresent = false;
    needWrapping = false;
    pic_detected = false;
    goodsize = false;
    showNews = false;
    showMotto = false;
    
    if(announcements.size() > 0){
      newsPresent = true;
      showNews = true;
      showMotto = false;
    } else if (announcements.size() == 0) {
      newsPresent = false;
      showNews = false;
      showMotto = true;
    }
    
    //The index for the display text and images are set to zero - the message has not been assigned yet.
    line = 0;
    messageCounter = 1;
    defaultMessageIndex = 0;
    pic = 0;
    
    //The max amount of characters for a single line is 27
    maxChar = 27;
    
    //The two wrap widths are assigned as such
    wrapWidth1 = width * .8;
    wrapWidth2 = wrapWidth1 * 1.05;
    
    //The various heights are assigned as such
    textWrapHeight = height * .9;
    boxHeight1 = height * .6875;
    boxHeight2 = height * .75;
    boxHeight3 = height * .2777; 
    
    //The various text sizes are assigned as such
    txtsize1 = width * .0585;
    txtsize2 = width * .0438;
    txtsize3 = width * .0351;
    txtsize4 = width * .0273;
    
    //The location of the text is in center of the screen
    messageX = width * .5;
    messageY = height * .5;
    
    //The defaultMessages arraylist is given the following lines
    defaultannouncements.add(new Announcement("Protect the Nest", ""));
    defaultannouncements.add(new Announcement("Our History Guides Our Future", ""));
    defaultannouncements.add(new Announcement("Swoop Swoop", ""));
    defaultannouncements.add(new Announcement("Be Inclusive", ""));
    defaultannouncements.add(new Announcement("Be Challenged", ""));
    defaultannouncements.add(new Announcement("Be Supportive", ""));
    defaultannouncements.add(new Announcement("Be Leaders", ""));
    defaultannouncements.add(new Announcement("Be Understanding", ""));
    defaultannouncements.add(new Announcement("Be Engaged", ""));
    defaultannouncements.add(new Announcement("Be Impactful", ""));
    
    //The dataPaths of all of the images are loaded here.
    for (int i = 0; i < 15; i++) {
      banner_dataPaths.add("images/" + i + ".JPG");
    }
    
    //The instance of the MovingPic class is initialized here
    Banner = new MovingPic(1, banner_dataPaths);
    
    if(newsPresent == true){
      messageExpireTime = millis() + announcements.get(line).messageTimelimit;
    } else if (newsPresent == false) {
      messageExpireTime = millis() + defaultannouncements.get(defaultMessageIndex).messageTimelimit;
    }
  }
  
  //the function for updating the news. It takes in an arraylist and assigns it to the messages arraylist
  void updateMessages(ArrayList<Announcement> _m){
    announcements = _m;
  }
  
  //function for drawing the text
  void draw() {
    ////This draws the text in the center of the screen with a black box behind it
    if(showNews){
      announcements.get(line).draw();
    } else if (showMotto) {
      defaultannouncements.get(defaultMessageIndex).draw();
    } 
  }
  
  //function for displaying one message at a time
  void nextMessage() {    
    //If the time passed for a message is less than its timelimit,
    if (millis() < messageExpireTime)
      return;//exist the function

    //If there news is present and the messageCounter is on an even number.
    if (newsPresent == true && messageCounter % 2 == 0) {
      showNews = true;
      showMotto = false;
      //When the time passed for a message is greater than its timelimt
        //go to the next message in the messages arraylist
        line++;
        
        //if all of the messages have been shown, loop back to the first message
        if (line > announcements.size() - 1) {
          line = 0;
        }
        
        //print the date and next message that's going to be shown in the console
        println(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
        println("loading next piece of news: " + announcements.get(line).text);
        
        //add another count to the amount of messages shown
        messageCounter++;
        
        messageExpireTime = millis() + announcements.get(line).messageTimelimit;
    } else if (newsPresent == true && messageCounter % 2 != 0) {//If there news is present and the messageCounter is on an odd number.
      //When the time passed for a message is greater than its timelimt
      showNews = false;
      showMotto = true;
        //go to the next message in the defaultMessages arraylist
        defaultMessageIndex++;
        
        //if all of the default messages have been shown, loop back to the first default message
        if (defaultMessageIndex > defaultannouncements.size() - 1) {
          defaultMessageIndex = 0;
        }
        
        //print the date and next default message that's going to be shown in the console
        println("-----------------------------------------------------------");
        println("Software Running Time Range: " + startDate + " -> " + new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
        println("loading next piece of news: " + defaultannouncements.get(defaultMessageIndex).text);
        
        //add another count to the amount of messages that has been displayed
        messageCounter++;
        
        messageExpireTime = millis() + defaultannouncements.get(defaultMessageIndex).messageTimelimit;
    }
  }
  
  //the function for displaying the images
  void Images() {
    //if there wasn't an image detected along with a piece of news
    if(announcements.get(line).img != null && showNews){
      image(announcements.get(line).Img(), width/2, height/2);
    } else {
      //updates the banner's image
      Banner.update();      
      //draw the banner and its movement
      Banner.draw();
      Banner.movement();
    }
  }
}
