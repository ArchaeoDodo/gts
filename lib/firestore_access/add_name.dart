import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_the_song/GUI/lobby.dart';
import 'file:///C:/Users/Dodo/AndroidStudioProjects/guess_the_song/lib/widgets/lobby/randomizer.dart';

void addName(String username, var roomNumber, int id) {
  int new_id = random();
  username == admin
      ? Firestore.instance
          .collection('rooms')
          .document(roomNumber)
          .collection('users')
          .document()
          .setData({
          'name': username,
          'id': new_id,
          'points': 0,
          'admin': true,
          'ingame': false,
          'active': false,
        })
      : Firestore.instance
          .collection('rooms')
          .document(roomNumber)
          .collection('users')
          .document()
          .setData({
          'name': username,
          'id': new_id,
          'points': 0,
          'admin': false,
          'ingame': false,
          'active': false,
        });
  ;
}
