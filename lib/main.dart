import 'package:assignment5_vallente/FirstPage.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green
    ),
    home: const FirstPage(),
   )
  );
}