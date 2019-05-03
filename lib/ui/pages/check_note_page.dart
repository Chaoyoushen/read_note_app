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
        padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 15.0),
        height: 550,
        width: 500,
        child: Card(
          color: Colors.white,
          elevation: 2,
          child:Padding(
              padding: EdgeInsets.all(8.0),
              child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Text(
                  'dest',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 330,
                child: Text(
                  'note',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                child: Text(
                  'dest',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          )
        ),
      )
    );
  }
}

























