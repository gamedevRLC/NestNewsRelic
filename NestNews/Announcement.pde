
class Announcement{
  
  boolean needWrapping;
  int messageTimelimit, messageExpireTime;
  float maxChar, messageLength, txtwrapWidth, boxWidth, wrapWidth1, wrapWidth2, textWrapHeight, boxHeight, boxHeight1, boxHeight2, boxHeight3, txtsize, txtsize1, txtsize2, txtsize3, txtsize4, messageX, messageY;
  String text, imgUrl;
  PImage img;
  
  Announcement(String _text, String _imgUrl){
    text = _text;
    imgUrl = _imgUrl;
    
    needWrapping = false;
    maxChar = 27;
    
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
    
    messageLength = text.length();
    
    if (messageLength >= maxChar) {
      needWrapping = true;
    } else if (messageLength < maxChar) {
      needWrapping = false;
    }
    
    if (needWrapping == true) {
      if (messageLength >= maxChar && messageLength <= 101) {
        messageTimelimit = 7 * 1000;
        boxWidth = wrapWidth2;
        boxHeight = boxHeight1;
        txtsize = txtsize1;
        txtwrapWidth = wrapWidth1;
      } else if (messageLength > 101 && messageLength <= 202) {
        messageTimelimit = 12 * 1000;
        boxWidth = wrapWidth2;
        boxHeight = boxHeight1;
        txtsize = txtsize2;
        txtwrapWidth = wrapWidth1;
      } else if (messageLength > 202 && messageLength <= 376) {
        messageTimelimit = 20 * 1000;
        boxWidth = wrapWidth2;
        boxHeight = boxHeight1;
        txtsize = txtsize3;
        txtwrapWidth = wrapWidth1;
      } else if (messageLength > 376 && messageLength <= 500) {
        messageTimelimit = 33 * 1000;
        boxWidth = wrapWidth2;
        boxHeight = boxHeight2;
        txtsize = txtsize4;
        txtwrapWidth = wrapWidth1;
      }
    } else if (needWrapping == false) {
      messageTimelimit = 5 * 1000;
      boxWidth = wrapWidth1;
      boxHeight = boxHeight3;
      txtsize = txtsize1;
      txtwrapWidth = wrapWidth1;
    }
    
    if(imgUrl.equals("") == false){
      img = loadImage(imgUrl);
    }
    
  }
  
  void draw(){
    textSize(txtsize);
    fill(0, 178);
    rect(messageX, messageY, boxWidth, boxHeight);
    fill(255);
    text(text, messageX, messageY, txtwrapWidth, textWrapHeight);
  }
  
  PImage Img(){
    imageMode(CENTER);
    background(115, 4, 10);
    return img;
  }
  
}
