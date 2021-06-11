import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietician/appointmentPage.dart';
import 'package:dietician/home_screen.dart';
import 'package:dietician/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String lastName;
  BuildContext context;
  String image;

  ProfilePage(this.lastName, this.image);

  @override
  _ProfilePageState createState() => _ProfilePageState(lastName);
}

class _ProfilePageState extends State<ProfilePage> {
  String lastName;

  _ProfilePageState(this.lastName);

  Widget doctorProfile() {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
      ),
      child: Container(
        child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return doctorCard(
                firstName: "Lorianne",
                lastName: "Bentro",
                prefix: "Dr",
                specialty: "Pediatric Dietitian",
                imagePath: widget.image,
                rank: 10,
                medicalEducation:
                    "Curabitur turpis ex, iaculis nec sollicitudin id, lobortis nec mi. Sed fermentum sapien facilisis augue vulputate pulvinar. Etiam vehicula tortor ut est vestibulum pharetra ut in purus.",
                residency:
                    "Curabitur turpis ex, iaculis nec sollicitudin id, lobortis nec mi. Sed fermentum sapien facilisis augue vulputate pulvinar. Etiam vehicula tortor ut est vestibulum pharetra ut in purus.",
                internship:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum arcu eget nibh gravida, sed tristique justo malesuada. Duis euismod dolor in tincidunt efficitur. Integer a iaculis enim.",
                biography:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum arcu eget nibh gravida, sed tristique justo malesuada. Duis euismod dolor in tincidunt efficitur. Integer a iaculis enim. Praesent rutrum orci vitae justo varius tempor. Donec iaculis leo sed elit pulvinar tempus. Nunc a mattis neque.",
              );
            }),
      ),
    );
  }

  Widget doctorCard({
    String firstName,
    String lastName,
    String prefix,
    String specialty,
    String imagePath,
    num rank,
    String medicalEducation,
    String residency,
    String internship,
    String fellowship,
    String biography,
  }) {
    final SimpleDialog officePhoneDialog = SimpleDialog(
      title: Text('Office Locations'),
      children: [
        SimpleDialogItem(
          icon: Icons.account_circle,
          color: Colors.teal,
          text: 'denverlocation@yourwebsite.com',
          onPressed: () {
            Navigator.pop(context, 'denverlocation@yourwebsite.com');
          },
        ),
        SimpleDialogItem(
          icon: Icons.account_circle,
          color: Colors.green,
          text: 'newyork@yourwebsite.com',
          onPressed: () {
            Navigator.pop(context, 'newyork@yourwebsite.com');
          },
        ),
        SimpleDialogItem(
          icon: Icons.account_circle,
          color: Colors.blue,
          text: 'houston@yourwebsite.com',
          onPressed: () {
            Navigator.pop(context, 'houston@yourwebsite.com');
          },
        ),
      ],
    );
    final SimpleDialog dialog = SimpleDialog(
      title: Text('Office Location'),
      children: [
        SimpleDialogItem(
          icon: Icons.account_circle,
          color: Colors.orange,
          text: 'denverlocation@.com',
          onPressed: () {
            Navigator.pop(context, 'denverlocation@yourwebsite.com');
          },
        ),
        SimpleDialogItem(
          icon: Icons.account_circle,
          color: Colors.green,
          text: 'newyork@yourwebsite.com',
          onPressed: () {
            Navigator.pop(context, 'newyork@yourwebsite.com');
          },
        ),
        SimpleDialogItem(
          icon: Icons.account_circle,
          color: Colors.red,
          text: 'houston@yourwebsite.com',
          onPressed: () {
            Navigator.pop(context, 'houston@yourwebsite.com');
          },
        ),
      ],
    );
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Colors.green,
            Colors.green,
          ], // whitish to gray
        ),
      ),
      alignment: Alignment.center, // where to position the child
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Color(0xFFFFFFFF),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  //transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            color: Colors.green,
                            highlightColor: Theme.of(context).primaryColorLight,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Icon(
                              Icons.phone,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Office',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 15.0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            transform:
                                Matrix4.translationValues(0.0, -15.0, 0.0),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: (imagePath == null)
                                  ? AssetImage(
                                      'assets/images/user.jpg',
                                    )
                                  : AssetImage(imagePath),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (context) => dialog);
                            },
                            color: Colors.green,
                            highlightColor: Theme.of(context).primaryColorLight,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.mail_outline,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Message',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${prefix.capitalize()} ${firstName.capitalize()} ${lastName.capitalize()}' ??
                              "lastName not found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF6f6f6f),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.transparent,
                          splashColor: Colors.black26,
                          onPressed: () {},
                          child: Text(
                            specialty ?? "specialty not found",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: StarRating(
                      rating: rank,
                      rowAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
                sectionTitle(context, "Biography"),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      biography ?? "error",
                      style: TextStyle(
                        color: Color(0xFF9f9f9f),
                      ),
                    ),
                  ),
                ),
                sectionTitle(context, "Dietitian History"),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (medicalEducation != null)
                                  ? Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'MEDICAL EDUCATION',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Color(0xFF6f6f6f),
                                            ),
                                          ),
                                          Text(
                                            medicalEducation,
                                            style: TextStyle(
                                              color: Color(0xFF9f9f9f),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              (internship != null)
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        top: 20.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'INTERNSHIP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Color(0xFF6f6f6f),
                                            ),
                                          ),
                                          Text(
                                            internship,
                                            style: TextStyle(
                                              color: Color(0xFF9f9f9f),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (residency != null)
                                  ? Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'RESIDENCY',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Color(0xFF6f6f6f),
                                            ),
                                          ),
                                          Text(
                                            residency,
                                            style: TextStyle(
                                              color: Color(0xFF9f9f9f),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sectionTitle(context, "Office Gallery"),
                Container(
                  height: 150,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      officePhotos(context, "https://i.imgur.com/gKdDh8p.jpg"),
                      officePhotos(context, "https://i.imgur.com/bJ6gU02.jpg"),
                      officePhotos(context, "https://i.imgur.com/ZJZIrIB.jpg"),
                      officePhotos(context, "https://i.imgur.com/pTAuS44.jpg"),
                      officePhotos(context, "https://i.imgur.com/eY1lW0A.jpg"),
                    ],
                  ),
                ),
                sectionTitle(context, "Appointments"),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AppointmentPage()));
        },
      ),
      appBar: StandardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                Colors.red,
                Colors.yellow,
              ], // whitish to gray
            ),
          ),
          alignment: Alignment.center, // where to position the child
          child: Column(
            children: [
              doctorProfile(),
            ],
          ),
        ),
      ),
    );
  }
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
        onPressed: () {},
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
        onPressed: () {},
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

Material officePhotos(context, String officePhotoUrl) {
  return Material(
    color: Colors.white,
    child: GestureDetector(
      onTap: () async {
        imageDialog(context, officePhotoUrl);
      },
      child: Container(
        width: 150.0,
        margin: const EdgeInsets.only(
          left: 20.0,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(officePhotoUrl),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Color(0xFFb1b2c4),
        ),
      ),
    ),
  );
}
