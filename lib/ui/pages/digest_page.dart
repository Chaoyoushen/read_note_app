import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/models/add_note_type.dart';
import 'package:readnote/models/note_model.dart';
import 'package:readnote/utils/camera_util.dart';
import 'package:fluro/fluro.dart';
import 'package:uuid/uuid.dart';

class DigestPage extends StatefulWidget {

  final String _text;
  final String _type;
  DigestPage(this._text,this._type);
  @override
  _DigestPageState createState() => _DigestPageState(_text,_type);
}



class _DigestPageState extends State<DigestPage> {

  _DigestPageState(String text,String type){
    this._text = text;
    if(type == 'gallery'){
      _type = AddNoteType.gallery;
    }else if(type == 'camera'){
      _type = AddNoteType.camera;
    }else{
      _type = AddNoteType.normal;
    }
  }

  NoteModel _note;

  AddNoteType _type;

  String _text;
  TextEditingController _digestController;
  int _digestNum;


  @override
  void initState() {
    _digestController = new TextEditingController();
    _digestNum = 0;
    getText(_text);
    super.initState();

  }


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
          '编辑书摘',
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
              '下一步',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            onPressed: (){
              setDigest(context);
              },
          )   
        ],
      ),
      body: makeDigest(context)

    );
  }

  addNote(String text){
    setState(() {
      if(text != null) {
        _digestController.text += text;
      }
    });
  }

  makePhoto(BuildContext context)async{
    String text = await CameraUtil.addNoteByPhoto(context);
    addNote(text);
  }
  fromGallery(BuildContext context)async{
    String text = await CameraUtil.addNoteByGallery(context);
    addNote(text);
  }

  getText(String str){
     addNote(utf8.decode(base64Url.decode(str)));
  }

  Container makeDigest(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      child: ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 8,right: 8,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "书摘内容",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                  ),
                ),
                setButton(context)
              ],
            )
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, top: 4.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Color(0xFFAD9A87),
              width: 110.0,
              height: 2.0,
            ),
          ),
        ),
        TextField(
          maxLength: 1000,
          style: TextStyle(
              fontSize: 20
          ),
          cursorColor: Color(0xFFAD9A87),
          decoration: InputDecoration(
            fillColor: Color(0xFFF5F5F5),
            filled: true,
            border: InputBorder.none,
          ),
          controller: _digestController,
          onChanged: setWordNum(_digestController.text.length),
          maxLines: 20,
        ),


      ],)
    );
  }

  setButton(BuildContext context){
    if (_type == AddNoteType.gallery) {
      return OutlineButton(
        onPressed: ()=>fromGallery(context),
        splashColor: Color(0xFFAD9A87),
        highlightedBorderColor: Color(0xFFAD9A87),
        child: Text(
          '追加书摘',
          style: TextStyle(
            fontSize: 10
          ),
        ),
        borderSide: BorderSide(
          color: Color(0xFFAD9A87)
        ),
      );
    } else if(_type == AddNoteType.camera){
      return OutlineButton(
        onPressed: ()=>makePhoto(context),
        splashColor: Color(0xFFAD9A87),
        highlightedBorderColor: Color(0xFFAD9A87),
        child: Text(
          '追加书摘',
          style: TextStyle(
            fontSize: 10
          ),
        ),
        borderSide: BorderSide(
          color: Color(0xFFAD9A87)
        ),
      );
    }else{
      return Container();
    }
  }


  setWordNum(int number){
    setState(() {
      _digestNum = number;
    });
  }

  setDigest(BuildContext context) async{
    String uuid = new Uuid().v1();
    _note = new NoteModel('','','','','','','',DateTime.now().millisecondsSinceEpoch.toString());
    _note.digest = _digestController.text;
    await LocalStorage.putString(uuid, json.encode(_note.toJson()));
    String codes = base64Url.encode(utf8.encode(uuid));
    Routes.router.navigateTo(context, '/notePage?uuid=$codes',transition: TransitionType.inFromRight);
  }

}