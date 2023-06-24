import java.net.InetAddress;
import java.util.Date;
import org.apache.commons.net.ntp.NTPUDPClient; 
import org.apache.commons.net.ntp.TimeInfo;

/* 
 We can load the google sheet with the announcement info
 We pull the sheet as a TSV (tab separated values)
 We can pull the fields via the Table class
 
 */
void printGoogleSheet()
{
  Table tt = loadTable(URL, "header, tsv");
  println(tt.getRowCount() + " total rows in table"); 
  String picture="";

  for (TableRow row : tt.rows()) {

    String start = row.getString("Start Date");
    String end = row.getString("End Date");
    String announcement = row.getString("Text");
    picture = row.getString("Image");

    println(start + "-" + end + ": " + announcement + "\n" + picture);
  }
}


/*  With the lack of an RTC on the RPI we can try network time...
 Might be blocked by CPS IT
 
 */
void getNetworkTime()
{
  //println("time...");
  //try {
  //  String TIME_SERVER = "time-a-g.nist.gov";   
  //  NTPUDPClient timeClient = new NTPUDPClient();
  //  InetAddress inetAddress = InetAddress.getByName(TIME_SERVER);
  //  TimeInfo timeInfo = timeClient.getTime(inetAddress);
  //  long returnTime = timeInfo.getReturnTime();
  //  Date time = new Date(returnTime);
  //  println("Time from " + TIME_SERVER + ": " + time);
  //}
  //catch (Exception x) {
  //  println("Exception when getting time: " + x.getMessage());
  //}

  //println("end time");
}

void powerOffDisplay()
{
  String[] cmd = {
    "/bin/sh", 
    "-c", 
    "echo standby 0 | cec-client -s -d 1"
  };

  try {
    Process p = Runtime.getRuntime().exec(cmd);
    Thread.sleep(500);
    p.destroy();
  }
  catch (Exception x) {
  }
  finally {
  }
}
//
void powerOnDisplay()
{
  String[] cmd = {
    "/bin/sh", 
    "-c", 
    "echo on 0 | cec-client -s -d 1"
  };

  try {
    Process p = Runtime.getRuntime().exec(cmd);
    Thread.sleep(500);
    p.destroy();
  }
  catch (Exception x) {
  }
  finally {
  }
}
