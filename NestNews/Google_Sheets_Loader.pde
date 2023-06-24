
//importation for connecting to the announcements google spreadsheet
import java.net.InetAddress;
import java.util.Date;
import org.apache.commons.net.ntp.NTPUDPClient; 
import org.apache.commons.net.ntp.TimeInfo;

//These arraylist are for lines of news and images attached to them
ArrayList<Announcement> Announcements = new ArrayList<Announcement>();
//ArrayList<PImage> Imgs = new ArrayList<PImage>();

//This function is dedicated to loading news from the announcements google spreadsheet
void GoogleSheetsLoad() {
  //The boolean is for whether or not today's date is within a piece of news' date range
  boolean in_range = false;
  
  //These strings are for the day, month, and year of the start date for a news, the end date for a news, and today's date
  
  //The String is the url of the announcements google spreadsheet
  String URL = "https://docs.google.com/spreadsheets/d/1aQRLzSPluYDXHKJTXZ3QsjXMaLp1lrbigut0KkGGYZc/export?exportFormat=tsv";
  println("Goolge Sheets Loader: Loading data from link: " + URL);
  
  //This table is for the announcements google spreadsheet
  Table tt;
  
  //initializes the Lines ArrayList for whenever the GoogleSheetsLoad function is called
  Announcements = new ArrayList<Announcement>();
  
  try {
    //try to load information from the announcements google spreadsheet
    tt = loadTable(URL, "header, tsv");
    println("Google Sheets Loader: " + tt.getRowCount() + " total rows in the table");
  } catch (Exception x) {//if unable to load information from the announcements google spreadsheet, return
    println("Error loading data, will try later" );
    return;
  }
  
  Date today, startDate, endDate;
  
  //The date is set here
  m = str(month());
  d = str(day()); 
  y = str(year());
  
  //This assigns the date to the month, day, and year of the device
  date = m + "/" + d + "/" + y;
  println("Date According to Device: " + date);
  
  //for every row in the announcements google spreadsheet
  for (TableRow row : tt.rows()) {
    //the cell at the "Start Date" column is the start date of a piece of news
    String start = row.getString(2);
    
    //the cell at the "End Date" column is the end date of a piece of news
    String end = row.getString(3);
    
    //the cell at the "Text" column is the piece of news itself
    String announcement = row.getString(4);
    
    //the cell at the "Image" column is the url link to an image associated with the news
    String picture = row.getString(5);  
    
    today = new Date(date);
    startDate = new Date(start);
    endDate = new Date(end);
    
    println("Splitting data: " + start);
    
    if((today.compareTo(startDate) > 0 && today.compareTo(endDate) < 0) || (today.compareTo(startDate) == 0 || today.compareTo(endDate) == 0)){
      in_range = true;
    } else {
      in_range = false;
    }
    
    //If today's date was in range of the news
    if (in_range == true) {
      //the piece of news is added to the arraylist of news
      println("adding message: " + announcement);
      Announcements.add(new Announcement(announcement, picture));
    }
  }
  
  //If there is an instance of the Announcement class
  if (NestNews != null){
    //give it the arraylist of news in its updateMessages function
    NestNews.updateMessages(Announcements);
  }
}
