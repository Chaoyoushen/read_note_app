import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/note_model.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';

class CheckNotePage extends StatefulWidget {
  final String _codes;
  CheckNotePage(this._codes);
  @override
  _CheckNotePageState createState() => _CheckNotePageState(_codes);
}

class _CheckNotePageState extends State<CheckNotePage> {
  _CheckNotePageState(String codes){
    _uuid = utf8.decode(base64Url.decode(codes));
    _note = NoteModel.fromJson(json.decode(LocalStorage.getObject(_uuid)));
    print(_note.toJson().toString());
  }

  String _uuid;
  NoteModel _note;



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
            onPressed: (){onComplete();},
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
                  _note.digest,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 330,
                child: Text(
                  _note.note,
                  maxLines: 15,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                child: Text(
                  '第'+_note.page+'页/《'+_note.bookName+'》',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
            ],
          ),
          )
        ),
      )
    );
  }
  onComplete()async{
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在上传...',
          );
        });
    await DioUtil.saveNote(_note);
    Navigator.pop(context);
    Routes.router.navigateTo(context, '/homePage',clearStack: true,transition: TransitionType.fadeIn);
  }
}

























