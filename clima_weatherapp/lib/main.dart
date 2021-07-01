import 'package:flutter/material.dart';
import 'package:clima_weatherapp/screens/loading_screen.dart';

void main() => runApp(MyApp());

//TODO: Make the App Responsive specially for smaller screens

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
