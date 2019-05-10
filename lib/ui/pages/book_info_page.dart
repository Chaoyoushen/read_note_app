import 'dart:io';

import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';

class BookInfoPage extends StatefulWidget {
  final String bookId;
  BookInfoPage(this.bookId);
  @override
  _BookInfoPageState createState() => _BookInfoPageState(bookId);
}

class _BookInfoPageState extends State<BookInfoPage> {
  BookInfoModel _model;
  String bookId;
  Image _image;
  _BookInfoPageState(this.bookId);
  @override
  void initState() {
    setModel(bookId);
    super.initState();
  }

  setModel(String bookId)async{
    _model = await DioUtil.getBookByBookId(bookId);
    //_image = await DioUtil.getBookImage(_model.photoUrl);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
            icon: Icon(
              IconData(0xe679, fontFamily: 'iconfont'),
              color: Colors.black,
            ),
            onPressed: () {Navigator.pop(context);}
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '书籍详情',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: _model == null?Center(child: CircularProgressIndicator()):_buildListView(context),
    );
  }

  Widget _buildListView(BuildContext context){
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          Container(
              height: 120,
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                  imageUrl: DioUtil.imagePath+_model.photoUrl,
                  placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,top: 8,bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                _model.bookName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Text(
                                  _model.author
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '共1条笔记',
                          textAlign: TextAlign.start,

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          Divider(),

        ]
    );
  }

}
