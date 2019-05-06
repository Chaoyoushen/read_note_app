import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/models/note_model.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/utils/notice_util.dart';

class NotePage extends StatefulWidget {
  final String _codes;
  NotePage(this._codes);
  @override
  _NotePageState createState() => _NotePageState(_codes);
}



class _NotePageState extends State<NotePage> {
  _NotePageState(String _codes){
    _uuid = utf8.decode(base64Url.decode(_codes));
    _note = NoteModel.fromJson(json.decode(LocalStorage.getObject(_uuid)));
    LocalStorage.remove(_uuid);
  }

  String _uuid;
  NoteModel _note;
  TextEditingController _noteController;
  TextEditingController _pageController;
  BookInfoModel _book;
  String _bookName= '';


  @override
  void initState() {
    _noteController = new TextEditingController();
    _pageController = new TextEditingController();
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
              onPressed: (){checkNote(context);},
            )
          ],
        ),
        body: makeNote()

    );
  }

   makeNote(){
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8,bottom: 8),
              child: Text("笔记(选填)")
          ),
          TextField(
            maxLength:500,
            style: TextStyle(
                fontSize: 20
            ),
            cursorColor: Color(0xFFAD9A87),
            //onChanged: setWordNum(_digestController.text.length),
            decoration: InputDecoration(
              fillColor: Color(0xFFF5F5F5),
              filled: true,
              border: InputBorder.none,
            ),
            controller: _noteController,
            maxLines: 12,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 40, 8, 10),
            child: Text(
              '*标记',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8,bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("所属图书"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Text(
                          _bookName,
                          textAlign:TextAlign.right
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: (){Routes.router.navigateTo(context, '/selectBookPage',transition: TransitionType.inFromRight).then(
                            (_result){
                              if(_result == null){
                                return;
                              }
                              setState(() {
                                _book = _result;
                                _bookName = _book.bookName;
                              });
                            }
                        );},
                      )
                    ],
                  )
                ],
              ),
            ),
        Padding(
            padding: EdgeInsets.only(top: 8,bottom: 8,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("所属页码"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: TextField(
                          controller: _pageController,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border:InputBorder.none,
                          )
                      )
                    ),
                    Text('页')
                  ],
                )

              ],
            )
        ),
      ],
    );
  }

  Padding capCol(){
    return Padding(
        padding: EdgeInsets.only(top: 8,bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("所属章节"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border:InputBorder.none
                      )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: (){},
                )
              ],
            )
          ],
        )
    );
  }

  checkNote(BuildContext context)async{
    if(_book == null){
      NoticeUtil.buildToast('please select a book');
      return;
    }
    _note.bookName = _book.bookName;
    _note.bookId = _book.bookId;
    _note.userId = LocalStorage.getObject(ConstRes.USER_ID);
    _note.note = _noteController.text;
    _note.page = _pageController.text;
    await LocalStorage.putString(_uuid, json.encode(_note.toJson()));
    String codes = base64Url.encode(utf8.encode(_uuid));
    Routes.router.navigateTo(context, '/checkNotePage?uuid=$codes',transition: TransitionType.inFromRight);
  }


}