import 'package:flutter/material.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  ///final String path;

  ///const CameraPage(this.path);

  @override
  _CameraPageState createState() => _CameraPageState();
//_CameraPageState createState() => _CameraPageState(path);
}

class _CameraPageState extends State<CameraPage> {
  // _CameraPageState(String path){
  //   _imageFile = File(String.fromCharCodes(base64.decode(path)));
  // }
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    //print(_imageFile.path);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Note',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2.0,
        ),
        body: Container(
          //color: Colors.black26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 380,
                  child: Card(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '所属书籍',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: SizedBox(
                height: 150,
                width: 380,
                child: Card(
                    child: Text(
                  '正文内容',
                  style: TextStyle(color: Colors.grey),
                )),
              )),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: SizedBox(
                height: 150,
                width: 380,
                child: Card(
                    child: Text(
                  '此刻的想法',
                  style: TextStyle(color: Colors.grey),
                )),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 50.0,
                  width: 350.0,
                  child: RaisedButton(
                    child: Text(
                      '发布',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    color: Colors.blue,
                    onPressed: () {},
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
