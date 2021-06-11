import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'Db.dart';
import 'home_screen.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();

}
SharedPreferences preferences;
final dbHelper = DatabaseHelper.instance;

class _loginState extends State<login> {

  bool rm=false;
  bool dietitian = false;
  final GlobalKey<ScaffoldState> _scaffoldLogin = new GlobalKey<ScaffoldState>();

  // Variables
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _birthDateController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();

  bool login = true;
  List<bool> c = [true, false];

  void initState() {

    super.initState();
    getPref();
    dbinit();
    getPrefDiet();
  }

  void dbinit() async{
    dbHelper.database;
    await DatabaseHelper.InitInserts();
  }

  getPref() async{
    preferences= await SharedPreferences.getInstance();

    setState(() {    /*Remember me process*/
      rm=preferences.getBool("remember") ?? false;
      _nameController.text= preferences.getString("name") ?? "";
      _passwordController.text=preferences.getString("password")?? "";
    });
  }

  getPrefDiet() async{
    preferences= await SharedPreferences.getInstance();
    setState(() {    /*Remember me process*/
      dietitian=preferences.getBool("dietitian") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            key:_scaffoldLogin ,
            backgroundColor: CupertinoColors.lightBackgroundGray,
            body: SizedBox.expand(
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    height: size.height * 0.25,
                    child: Image.asset(
                      "asset/logo.png",
                      height: size.height * 0.024,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: card("Log in", c[0], size),
                        onTap: () {

                          setState(() {
                            c[1] = false;
                            c[0] = true;
                            login = true;
                          });
                        },
                      ),
                      GestureDetector(
                        child: card("Sign up", c[1], size),
                        onTap: () {
                          setState(() {
                            c[0] = false;
                            c[1] = true;
                            login = false;
                          });

                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  login
                      ? Column(
                    children: [
                      info("Log in", size),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                          Checkbox(
                            activeColor: Colors.green,
                            value: rm,
                            onChanged: (newValue) {
                              setState(() {
                                rm = newValue;
                                preferences.setBool("remember", rm);
                                preferences.setString("name", _nameController.text);
                                preferences.setString("password", _passwordController.text);

                              });
                            },
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                                color: CupertinoColors.systemGreen,
                                fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  )
                      : Column(
                    children: [
                      info("Sign up", size),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  card(String s, bool c, Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.18,
        child: Column(
          children: [
            Text(
              s,
              style: TextStyle(
                fontSize: 15.0,
                color: c ? Colors.green : Colors.black,
              ),
            ),
            Divider(
              color: c ? Colors.green : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  formblock(String s, Size size, TextEditingController tec){
    return Container(
      width: size.width * 0.83,
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: tec,
        obscureText: false,
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
              borderRadius:
              BorderRadius.circular(15.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CupertinoColors.systemGreen,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
  info(String s, Size size) {
    return Column(
      children: [
        Container(
          width: size.width * 0.83,
          child: TextField(
            controller: _nameController,
            obscureText: false,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Name",
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
        SizedBox(height: size.height * 0.04),
        Container(
          width: size.width * 0.83,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Password",
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
        s == "Sign up" ? Column(
      children: [
        SizedBox(height: size.height * 0.04),
        formblock("Surname",size, _surnameController),
        SizedBox(height: size.height * 0.04),
        formblock("Gender",size , _genderController),
        SizedBox(height: size.height * 0.04),
        formblock("Birth Date",size, _birthDateController),
        SizedBox(height: size.height * 0.04),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.07,
            ),
            Checkbox(
              activeColor: Colors.green,
              value: dietitian,
              onChanged: (newValue) {
                setState(() {
                  dietitian = newValue;
                  preferences.setBool("dietitian", dietitian);
                });
              },
            ),
            Text(
              "Are you a dietitian",
              style: TextStyle(
                  color: CupertinoColors.systemGreen,
                  fontSize: 14),
            ),
          ],
        ),
    ],
    ) : SizedBox(),
        SizedBox(
          height: size.height * 0.05,
        ),
        Container(
          width: size.width * 0.2,
          height: size.height * 0.06,
          child: Center(
            child: RaisedButton(
              disabledColor: CupertinoColors.systemGreen.withOpacity(0.5),
              color: CupertinoColors.systemGreen.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: CupertinoColors.black)),
              child: Text(
                s,
                style: TextStyle(
                    color: CupertinoColors.black,fontSize: size.width*0.030
                ),
              ),
              onPressed: () async{
                  int gender=2;
                  setState(() async {
                    if (_genderController.text == "M"){
                      gender = 1;
                    }
                    else{
                      gender = 0;
                    }
                    if(s=="Sign up") {
                      /** MYSQL auth.*/
                      if(!dietitian){
                        DatabaseHelper.InsertUser(_nameController.text, _surnameController.text, _birthDateController.text, gender ,  _passwordController.text,  0 );
                      }else{
                        DatabaseHelper.InsertUser(_nameController.text, _surnameController.text, _birthDateController.text, gender ,  _passwordController.text,  1 );
                      }
                      setState(() {
                        _scaffoldLogin.currentState
                            .showSnackBar(
                            new SnackBar(content: new Text("New user has been created")));
                      });

                    }else{
                        if(!rm){
                          preferences.setString("name", "");
                          preferences.setString("password", "");
                        }
                        DatabaseHelper.checkUser(_nameController.text, _passwordController.text, context);
                    }
                  });
              },
            ),
          ),
        ),
      ],
    );
  }
}

