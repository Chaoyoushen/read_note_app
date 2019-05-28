import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readnote/models/my_note_list_model.dart';
import 'package:readnote/models/my_note_model.dart';
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
  MyNoteListModel _noteList;
  int num;
  _BookInfoPageState(this.bookId);
  @override
  void initState() {
    setModel(bookId);
    super.initState();
  }

  setModel(String bookId)async{
    _model = await DioUtil.getBookByBookId(bookId);
    _noteList = await DioUtil.getNoteListByBook(bookId);
    setState(() {
      if(_noteList.list!=null){
        num = _noteList.list.length;
      }else{
        num = 0;
      }

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
                  fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,top: 8,bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Column(
                            children: <Widget>[
                              Text(
                                _model.bookName,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                _model.author,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '共$num条笔记',
                          textAlign: TextAlign.start,

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          Divider(),
          _buildCollectionView(_noteList.list)
        ]
    );
  }

  Widget _buildCollectionView(List<MyNoteModel> list){
    if(list == null){
      return null;
    }
    return ListView.builder(
      itemCount: list.length,
      physics:NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _itemBuilder(context, index, list),
    );
  }

  Widget _itemBuilder(BuildContext context, int index,List<MyNoteModel> list) {
    return GestureDetector(
        onTap: (){goDetail(context,list[index].noteId);},
        child:Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      list[index].note,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Divider(color: Colors.black),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 20,
                            child: Text(
                              '《' + list[index].bookName +
                                  '》',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue),
                            ),
                          )
                      )
                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16,bottom: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    list[index].digest,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void goDetail(BuildContext context,String noteId){
    Routes.router.navigateTo(context, '/noteDetailPage?noteId='+noteId,transition: TransitionType.fadeIn);
  }

}
