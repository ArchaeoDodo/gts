import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  void _showInformation(BuildContext context) async {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text('Information'),
          content: Text(
              'This is an app being developed by Jazzley Termond.\nThe purpose of this app is to create'
              ' a gameroom for the popular game "Guess the song". After the room is made, people can join with their own username through a room code'
              '. After joining they will arrive in a lobby with the other players, only the admin can start the game.'
              ' The way to play is simple, one person searches for a song through Youtube/Spotify whilst the others can guess using their text field.'
              ' Once submitted your answer cannot be changed. There will be a timer counting down from 30 sec. After the time is up or if all answers are submitted, the game'
              ' will proceed to the next round. Ofcourse counting up the scores.'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      child: Icon(
        Icons.info,
        color: Colors.white,
      ),
      onPressed: () => _showInformation(context),
    );
  }
}
