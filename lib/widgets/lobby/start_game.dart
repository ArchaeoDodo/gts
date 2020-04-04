import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_song/GUI/timer/count_down_timer.dart';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CountDownTimer(),
                  ),
                ],
              ),
            ),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
            Text('test'),
          ],
        ),
      ),
    );
  }
}
