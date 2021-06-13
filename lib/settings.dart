import 'package:dietician/Db.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter/cupertino.dart';

class settings extends StatefulWidget {
  int id;
  String name;
  int kcal;

  settings(this.id, this.name, this.kcal);

  @override
  _settingsState createState() => _settingsState();
}

TextEditingController _wController = new TextEditingController();
TextEditingController _hController = new TextEditingController();
String weight;
String height;

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          formblock("Weight", size, _wController),
          SizedBox(
            height: 15,
          ),
          formblock("Height", size, _hController),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  weight = _wController.text.toString();
                  height = _hController.text.toString();
                  var bmi = (int.parse(weight) * 10000.0) /
                      (int.parse(height) * int.parse(height));
                 DatabaseHelper.updateWH(
                      widget.id, int.parse(weight), int.parse(height));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => homescreen(widget.name, widget.id, widget.kcal,bmi)));
                });
              },
              child: Text("Update")),
        ],
      ),
    );
  }
}

formblock(String s, Size size, TextEditingController contr) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 20, 0, 10),
    child: Container(
      width: size.width * 0.83,
      child: TextField(
        style: TextStyle(color: Colors.black),
        obscureText: false,
        controller: contr,
        decoration: InputDecoration(
          labelText: s,
          labelStyle: TextStyle(
            color: CupertinoColors.black,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CupertinoColors.systemGreen,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CupertinoColors.systemGreen,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
  );
}
