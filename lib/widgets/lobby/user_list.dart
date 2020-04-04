import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  UserList({Key key, @required this.admin, @required this.currentUser})
      : super(key: key);
  final String admin;
  final String currentUser;

  Color _TextColor(var name, bool isAdmin) {
    if (isAdmin == true) {
      return Colors.amber;
    } else if (currentUser == name) {
      return Colors.green;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    var input;
    return StreamBuilder(
      stream: Firestore.instance
          .collection("rooms")
          .document('0001')
          .collection('users')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CircularProgressIndicator(),
          );
        input = snapshot.data.documents;
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(25.0),
          itemCount: input.length,
          itemBuilder: (context, index) {
            return new ListTile(
              title: Text(
                snapshot.data.documents[index]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: _TextColor(snapshot.data.documents[index]['name'],
                      snapshot.data.documents[index]['admin']),
                ),
              ),
              leading: input[index]['admin']
                  ? Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  : Icon(
                      Icons.person,
                      color: _TextColor(snapshot.data.documents[index]['name'],
                          snapshot.data.documents[index]['admin']),
                    ),
              trailing: Text(
                input[index]['points'].toString() + ' pts',
                style: TextStyle(
                  color: _TextColor(snapshot.data.documents[index]['name'],
                      snapshot.data.documents[index]['admin']),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
