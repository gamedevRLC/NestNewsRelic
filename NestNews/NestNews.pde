
/*
  Being developed by Robert Chapman & Czar Carson
 This piece of software is able to load info from a text file
 and displays it on the screen
 */

//importations for getting the date online
import java.util.Date;
import java.text.SimpleDateFormat;

//This boolan is for whenever the sketch has loaded messages from the announcements google spreadsheet
boolean loadedData;

//This float is for moving the banner image at a proportional rate across different screens
float widthProportion;

//This String represents the time and date the sketch was opened
String startDate, Time; 

/*
  These strings relate to the todays date.
 The fourth one gets the date from first three - the month, day, and year according to the 
 device the software is on..
 */

String m, d, y, date;

//Link to google sheets spread sheet
String URL = "https://docs.google.com/spreadsheets/d/1aQRLzSPluYDXHKJTXZ3QsjXMaLp1lrbigut0KkGGYZc/export?exportFormat=tsv";

//The instance of the Announcement class
NestNewsManager NestNews;

void setup() {
  //This sets the size of the sketch to the size of the device's screen
  fullScreen();
  noCursor();

  //loadedData is set to false
  loadedData = false;

  //The widthProportion is set here
  widthProportion = 1280.0/float(width);

  //The date is set here
  m = str(month());
  d = str(day()); 
  y = str(year());
  //This assigns the date to the month, day, and year of the device
  date = m + "/" + d + "/" + y;
  println("Date According to Device: " + date);

  //The startTime is set here
  startDate = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());

  //The GoogleSheets function is used to get news from the google spreadsheet on startup
  GoogleSheetsLoad();

  //Instance of the Announcement class is initialized here
  NestNews = new NestNewsManager(date, Announcements);

  //Various drawing methods are established here
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CORNER);
}

void draw() {
  //Calls the Images, draw, and nextMessage functions of the Announcement class
  NestNews.Images();
  NestNews.draw();
  NestNews.nextMessage();

  //load live news from the google spreadsheet every 5 minutes
  if (minute() % 5 == 0) {
    //if loadedData is false
    if (loadedData == false) {
      //Load news from the google spreadsheet, set loadedData to true - this is a contingency for the hole minute when its supposed to load news
      GoogleSheetsLoad();
      loadedData = true;
    }
    
    Time = new SimpleDateFormat("h:mm a").format(new Date());
    if(Time.equals("7:00 PM") || Time.equals("7:01 PM") || Time.equals("7:02 PM") || Time.equals("7:03 PM") || Time.equals("7:04 PM")){
      powerOffDisplay();
    } else if (Time.equals("7:00 AM") || Time.equals("7:01 AM") || Time.equals("7:02 AM") || Time.equals("7:03 AM") || Time.equals("7:04 AM")){
      powerOnDisplay();
    }
    
  } else {//if it hasn't been 5 minutes, set loadData to false
    loadedData = false;
  }
}

void keyPressed() {
  //printGoogleSheet();
  //getNetworkTime();
  println(frameRate);
  //println(Time);
  switch(key){
  case '0':
    powerOffDisplay();
    break;
  case '1':
    powerOnDisplay();
    break;
  }
}
