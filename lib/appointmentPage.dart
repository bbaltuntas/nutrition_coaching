import 'package:dietician/Db.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String day = "";
  String hour = "";

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.green),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Appointment"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "Day:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 15.0,
              ),
              height: 60,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  appointmentDays("Monday", "June 15th", context),
                  appointmentDays("Tuesday", "June 19th`", context),
                  appointmentDays("Wednesday", "July 24th", context),
                  appointmentDays("Thursday", "July 12th", context),
                  appointmentDays("Friday", "July 13th", context),
                  appointmentDays("Saturday", "August 7th", context),
                  appointmentDays("Sunday", "August 9th", context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "Hour:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 15.0,
              ),
              height: 50,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  appointmentTimes("9:00 AM", context),
                  appointmentTimes("9:30 AM", context),
                  appointmentTimes("10:00 AM", context),
                  appointmentTimes("10:30 AM", context),
                  appointmentTimes("11:00 AM", context),
                ],
              ),
            ),
            Center(
              child: Text(
                day,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
            ),
            Center(
              child: Text(
                hour,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.teal),
                onPressed: (){
                 // DatabaseHelper.insertAppointment(date, customerId, dietitianId)
                },
                child: Text("Create Appointment"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Material appointmentDays(
      String appointmentDay, String appointmentDate, context) {
    return Material(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(
          right: 1.0,
          left: 20.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: OutlineButton(
          color: Colors.transparent,
          splashColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 6,
          ),
          onPressed: () {
            setState(() {
              day = appointmentDate + " " + appointmentDay;
            });
          },
          textColor: Colors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  appointmentDay ?? "error",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  appointmentDate ?? "error",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Material appointmentTimes(String appointmentDay, context) {
    return Material(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(
          right: 1.0,
          left: 20.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: OutlineButton(
          color: Colors.transparent,
          splashColor: Colors.lightGreen,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          onPressed: () {
            setState(() {
              hour = appointmentDay;
            });
          },
          textColor: Colors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              appointmentDay ?? "error",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
