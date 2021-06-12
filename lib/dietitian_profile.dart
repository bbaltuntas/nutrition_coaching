import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Db.dart';

class DietitianProfile extends StatefulWidget {
  String name;
  int id;

  DietitianProfile(this.name, this.id);

  @override
  _DietitianProfileState createState() => _DietitianProfileState();
}

class _DietitianProfileState extends State<DietitianProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset("asset/1.jpg", height: 220),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 222,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 32),
                          ),
                          Text(
                            "Dietitian",
                            style: TextStyle(fontSize: 19, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "Activity",
                style: TextStyle(
                    color: Color(0xff242424),
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xffFBB97C),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            child: Expanded(
                              child: Text(
                                "List Of Schedule",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xffA5A5A5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            child: Expanded(
                              child: Text(
                                "Doctor's Available Hours",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                width: 400,
                child: FutureBuilder(
                    future: DatabaseHelper.showRelationship(widget.id),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        print("null");
                        return Container();
                      } else if (snapshot.hasError) {
                        print("haserror");
                        return Icon(
                          Icons.error,
                          size: 110,
                        );
                      } else {
                        return ListView.separated(
                            itemCount: snapshot.data[0].length,
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Divider(height: 2, color: Colors.transparent),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Color(0xffFBB97C),
                                child: ListTile(
                                  title:
                                      Text("${snapshot.data[index][0]["u_name"]} ${snapshot.data[index][0]["u_surname"]}",style: TextStyle(fontSize: 18),),
                                ),
                              );
                              //dieticianCard("Dietitian ${snapshot.data[index]["u_name"]}  ${snapshot.data[index]["u_surname"]} ", 100, "İstanbul", size,  context, 'asset/1.jpg',snapshot.data[index]["dietatian_id"]);
                            });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
