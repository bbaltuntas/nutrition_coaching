import 'package:flutter/material.dart';
import 'login.dart';
import 'Db.dart';

void main() async {


  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => login(),
    },
    debugShowCheckedModeBanner: false,
  ));

}





