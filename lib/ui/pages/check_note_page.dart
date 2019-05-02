import 'package:flutter/material.dart';

class CheckNotePage extends StatefulWidget {
  @override
  _CheckNotePageState createState() => _CheckNotePageState();
}

class _CheckNotePageState extends State<CheckNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {Navigator.pop(context);},
          );
        }),
        title: Text(
          '书摘',
          style: TextStyle(
              color: Colors.black,
              fontSize: 21
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              '完成',
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.0),
        height: 500,
        width: 500,
        child: Card(
          color: Colors.pink,
          elevation: 2,
        ),
      )
    );
  }
}

























