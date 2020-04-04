import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> removeName(var username, var roomNumber, var id) async {
  Firestore.instance
      .collection('rooms')
      .document(roomNumber)
      .collection('users')
      .where("name", isEqualTo: username.toString())
      .where("id", isEqualTo: id)
      .getDocuments()
      .then(
    (snapshot) {
      snapshot.documents.last.reference.delete();
    },
  );
}
