import 'package:dietician/meal.dart';
import 'package:dietician/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'Db.dart';
import 'login.dart';
import 'settings.dart';

class homescreen extends StatefulWidget {
  String name;
  homescreen(String name){
    this.name = name;
  }
  @override
  _homescreenState createState() => _homescreenState();
}
final today = DateTime.now();
class _homescreenState extends State<homescreen> {

  void initState() {
    super.initState();
    DatabaseHelper.getUsers(widget.name);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isp = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MealPage()));
        },
      ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Nutrition Coaching',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.access_time,
                color: CupertinoColors.activeOrange,
              ),
              onPressed: () {
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavList("Favorites")));*/
              },
            ),
          ],
        ),
        drawer: Drawer(
            child: Container(
          color: CupertinoColors.lightBackgroundGray,
          child: ListView(
            children: [
              Container(
                height: size.height * 0.25,
                alignment: Alignment.center,
                child: DrawerHeader(
                  child: Container(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/logo.png"),
                          fit: BoxFit.scaleDown)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
                 "${widget.name}",
                  style: TextStyle(color: CupertinoColors.black, fontSize: 18),
                ),
              ),
              listtile("Appointments", context,
                  Icon(Icons.people, color: Colors.black), null),
              listtile(
                  "Daily Activities",
                  context,
                  Icon(
                    Icons.timeline,
                    color: Colors.black,
                  ),
                  null),
              listtile(
                  "Settings",
                  context,
                  Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  null),
              Container(
                margin: EdgeInsets.fromLTRB(80, 25, 80, 0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: CupertinoColors.systemGreen),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                    //Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    'Quit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        )),
        body: Container(
          color: CupertinoColors.white,
          // customer or dietician check
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: const Radius.circular(40),
                ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 40, left: 32, right: 16, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "Hello, ${widget.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Text("BMI: ${bmi==null ? "-" : '$bmi' }", style: TextStyle(fontSize: 15),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          _RadialProgress(
                            width: size.width * 0.38,
                            height: size.width * 0.38,
                            progress: 0.7,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _IngredientProgress(
                                ingredient: "Protein",
                                progress: 0.3,
                                progressColor: Colors.green,
                                leftAmount: 72,
                                width: size.width * 0.28,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _IngredientProgress(
                                ingredient: "Carbs",
                                progress: 0.2,
                                progressColor: Colors.red,
                                leftAmount: 252,
                                width: size.width * 0.28,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _IngredientProgress(
                                ingredient: "Fat",
                                progress: 0.1,
                                progressColor: Colors.yellow,
                                leftAmount: 61,
                                width: size.width * 0.28,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 15),
               Container(child: Text("Available Dietitians", style: TextStyle(
                 fontWeight: FontWeight.w800,
                 fontSize: 22,
                 color: Colors.black,
               ),
               ),
               ),
               Expanded(
                 flex: 3,
                 child:ListView(children: <Widget>[
                  dieticianCard("Dietician Merve Tuna ", 100, "İstanbul", size,
                      context, 'asset/1.jpg'),
                  dieticianCard("Dietician Adem Portakal ", 150, "Ankara", size,
                      context, 'asset/2.jpg'),
                  dieticianCard("Dietician Yeşim Güler ", 200, "Bursa", size,
                      context, 'asset/logo.jpg'),
                ]),),
            ],
          ),
        ));
  }
}

listtile(String title, BuildContext context, Icon ic, dynamic data) {
  return InkWell(
    splashColor: Colors.grey,
    onTap: () {
       if(title=="Settings"){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => settings()));
      }/*else{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieList(title, data)));
      }*/
    },
    child: Card(
      color: CupertinoColors.systemGreen,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(40, 20),
            bottomRight: Radius.elliptical(0, 0),
          ),
          side: BorderSide(color: CupertinoColors.black)),
      child: ListTile(
        leading: ic,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

dieticianCard(String name, int price, String location, Size size,
    BuildContext context, String image) {
  return Container(
    child: Column(
      children: [
        Container(
          height: size.height * 0.062,
          child: Container(
            decoration: BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(20, 20),
                  topRight: Radius.elliptical(20, 20),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    )),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage("Altuntas",image)));


                  },
                  child: Text('Details'),
                )
              ],
            ),
          ),
        ),
        Container(
          color: CupertinoColors.lightBackgroundGray,
          height: size.height * 0.22,
          child: Card(
            color: CupertinoColors.lightBackgroundGray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: size.width * size.height * 0.000189,
                  backgroundColor: CupertinoColors.systemGreen,
                  child: CircleAvatar(
                    backgroundColor: CupertinoColors.darkBackgroundGray,
                    backgroundImage: AssetImage(image),
                    radius: size.width * size.height * 0.00018,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Price Hourly: $price',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Location: $location',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

class _IngredientProgress extends StatelessWidget {
final String ingredient;
final int leftAmount;
final double progress, width;
final Color progressColor;

const _IngredientProgress({Key key, this.ingredient, this.leftAmount, this.progress, this.progressColor, this.width}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        ingredient.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 10,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.black12,
                ),
              ),
              Container(
                height: 10,
                width: width * progress,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: progressColor,
                ),
              )
            ],
          ),
          SizedBox(
            width: 2,
          ),
          Text("${leftAmount}g left"),
        ],
      ),
    ],
  );
}
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;

  const _RadialProgress({Key key, this.height, this.width, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: 0.7,
      ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "1731",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal left",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = CupertinoColors.activeOrange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
