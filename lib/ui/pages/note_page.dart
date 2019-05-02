import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/models/book_info_model.dart';

class NotePage extends StatefulWidget {
  final String _digest;
  NotePage(this._digest);
  @override
  _NotePageState createState() => _NotePageState(_digest);
}



class _NotePageState extends State<NotePage> {
  _NotePageState(String digest){
    _digest = utf8.decode(base64Url.decode(digest));
  }


  String _digest;
  TextEditingController _noteController;
  TextEditingController _bookController;
  TextEditingController _capController;
  BookInfoModel _book;
  String _bookname= '';


  @override
  void initState() {
    _noteController = new TextEditingController();
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
              onPressed: (){Routes.router.navigateTo(context, '/checkNotePage');},
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
                          _bookname,
                          textAlign:TextAlign.right
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: (){Routes.router.navigateTo(context, '/selectBookPage').then(
                            (_result){
                              if(_result == null){
                                return;
                              }
                              setState(() {
                                _book = _result;
                                _bookname = _book.bookName;
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

}