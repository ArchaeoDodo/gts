import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/information.dart';

import 'lobby.dart' as lobby;

class Homescreen extends StatefulWidget {
  Homescreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  bool validateName = true;
  bool validateRoom = true;
  bool roomExists = true;
  bool futureCheck = true;

  final nameController = TextEditingController();
  final roomController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkIfRoomExists() async {
    await Firestore.instance
        .collection('rooms')
        .document(roomController.text)
        .get()
        .then(
          (doc) async => {
            doc.exists
                ? roomExists = true
                : {roomExists = false, validateRoom = false},
          },
        );
    return roomExists;
  }

  @override
  void dispose() {
    nameController.dispose();
    roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Information(),
        ],
        title: Text(
          "Guess the song",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Welcome to Guess the song',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Icon(
              Icons.ac_unit,
              size: 100,
              color: Colors.deepOrange,
            ),
            TextFormField(
              controller: nameController,
              textAlign: TextAlign.center,
              autocorrect: false,
              maxLengthEnforced: true,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                errorText:
                    !validateName ? 'Invalid name, please try again' : null,
              ),
            ),
            //Flexible(child: SizedBox.expand()),
            TextFormField(
              controller: roomController,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Enter the room code',
                errorText: !validateRoom
                    ? 'Invalid room code, please try again'
                    : null,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: FlatButton(
          child: Text('Join Room'),
          onPressed: () async {
            //  something == something ? if false : if true
            setState(
              () {
                nameController.text.isNotEmpty
                    ? validateName = true
                    : validateName = false;
                roomController.text.length == 4
                    ? validateRoom = true
                    : validateRoom = false;
              },
            );
            futureCheck = await checkIfRoomExists();
            if (validateName == true &&
                validateRoom == true &&
                futureCheck == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => lobby.Lobby(
                    roomNumber: roomController.text,
                    userName: nameController.text,
                  ),
                ),
              );
            }
          },
        ),
        elevation: 0,
      ),
    );
  }
}
