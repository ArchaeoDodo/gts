import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'GUI/homescreen.dart';

void main() => runApp(MyApp());

//TODO Add a way so that the user gets deleted when the app is on pause(tabbed out) but does not crash
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: 'Guess the song',
      home: Homescreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.cyan[600],
      ),
    );
  }
}
