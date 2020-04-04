import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Ingamelist extends StatefulWidget {
  _IngameListState createState() => _IngameListState();
}

class _IngameListState extends State<Ingamelist> {
  @override
  void initState() {
    _getList();
    super.initState();
  }

  void _getList() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> _list = [];

    // TODO: implement build
    throw UnimplementedError();
  }
}
