import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_song/GUI/lobby.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/randomizer.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/start_game.dart';

class AdminButtons extends StatefulWidget {
  @override
  _AdminButtonsState createState() => _AdminButtonsState();
}

class _AdminButtonsState extends State<AdminButtons> {
  var isStarted;
  int min = 0;
  int max = 1000000;

  @override
  void initState() {
    super.initState();
  }

  void _input() async {
    random();
    Firestore.instance
        .collection('rooms')
        .document('0001')
        .collection('users')
        .document()
        .setData(
            {'name': id.toString(), 'id': id, 'points': 0, 'admin': false});
    ;
  }

  Future<void> _clear() async {
    Firestore.instance
        .collection('rooms')
        .document('0001')
        .collection('users')
        .where('admin', isEqualTo: false)
        .getDocuments()
        .then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.documents) {
          ds.reference.delete();
        }
      },
    );
  }

  void _setStarted() async {
    Firestore.instance
        .collection('rooms')
        .document('0001')
        .setData({'started': true, 'room_id': '0001'});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            heroTag: 'start',
            onPressed: () => _setStarted(),
            backgroundColor: Colors.red,
            label: Text('Start game'),
            splashColor: Colors.grey,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            heroTag: 'fill',
            child: Text('Fill'),
            onPressed: () => _input(),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'clear',
            child: Text('clear'),
            onPressed: () => _clear(),
          ),
        ),
      ],
    );
  }
}
