import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_song/admin/admin_buttons.dart';
import 'package:guess_the_song/firestore_access/add_name.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/information.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/start_game.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/firestore_access/remove_name.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/user_list.dart';

var id = 0;
const String admin = 'dodo';

class Lobby extends StatefulWidget {
  Lobby({Key key, @required this.userName, @required this.roomNumber})
      : super(key: key);

  final String userName;
  final String roomNumber;

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        print('$state inactive');
        await removeName(widget.userName, widget.roomNumber, id);
        break;

      case AppLifecycleState.paused:
        print('$state paused');
        await removeName(widget.userName, widget.roomNumber, id);
        break;

      case AppLifecycleState.resumed:
        print('$state resumed');
        break;

      case AppLifecycleState.detached:
        print('$state detached');
        await removeName(widget.userName, widget.roomNumber, id);
        break;
    }
  }

  @override
  void initState() {
    addName(widget.userName, widget.roomNumber, id);
    WidgetsBinding.instance.addObserver(this);
    _startedListener();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to leave the lobby'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => {
                  removeName(widget.userName, widget.roomNumber, id),
                  Navigator.of(context).pop(true),
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _startedListener() async {
    Firestore.instance
        .collection('rooms')
        .where('room_id', isEqualTo: '0001')
        .snapshots()
        .listen((changes) {
      if (changes.documents[0]['started'] == true) {
        setState(() {
          print('changed');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => StartGame(),
            ),
            //_GameStarted,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Information(),
            ],
            title: Text("Lobby : " + widget.roomNumber),
          ),
          body: Container(
            child: UserList(
              admin: admin,
              currentUser: widget.userName,
            ),
          ),
          floatingActionButton:
              widget.userName == admin ? new AdminButtons() : null,
        ),
        onWillPop: _onWillPop);
  }
}
