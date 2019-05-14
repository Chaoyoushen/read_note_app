import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/collection_list_model.dart';
import 'package:readnote/models/my_note_list_model.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/utils/utils.dart';
import 'package:readnote/common/routes.dart';
import 'package:fluro/fluro.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  MyNoteListModel noteList;
  CollectionListModel collectionList;

  @override
  void initState() {
    setModel();
    super.initState();
  }

  setModel()async{
    noteList = await DioUtil.getNoteList();
    collectionList = await DioUtil.getCollectionOverview();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return buildListView();}

    Widget buildListView(){
      return noteList==null&&collectionList==null?Center(child: CircularProgressIndicator())
          :ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: <Widget>[
          SizedBox(
            height: 220,
            child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('我的收藏'),
                          SizedBox(
                            height: 18,
                            width: 70,
                            child: OutlineButton(
                              onPressed: () {goCollection(context);},
                              splashColor: Color(0xFFAD9A87),
                              highlightedBorderColor: Color(0xFFAD9A87),
                              child: Text(
                                'MORE',
                                style: TextStyle(fontSize: 12),
                              ),
                              borderSide: BorderSide(color: Color(0xFFFFFF)),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child:buildCollection()
                      )

                    ],
                  ),
                )),
          ),
          Divider(),
          SizedBox(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('我的书摘'),
                            SizedBox(
                              height: 18,
                              width: 70,
                              child: OutlineButton(
                                onPressed: () {
                                  goNoteList(context);
                                },
                                splashColor: Color(0xFFAD9A87),
                                highlightedBorderColor: Color(0xFFAD9A87),
                                child: Text(
                                  'MORE',
                                  style: TextStyle(fontSize: 12),
                                ),
                                borderSide: BorderSide(color: Color(0xFFFFFF)),
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child:buildNote(context)
                        )
                      ]
                  ),
                ),
              )
          ),
        ],
      );
    }

    void fun()async{
      //ExploreListModel model = await DioUtil.getExploreModel(1,1);
      //DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(model.exploreViewList.first.createDate));
      //print(date);
      Routes.router.navigateTo(context, '/noteDetailPage?noteId=',transition: TransitionType.inFromBottom);
    }

    Widget buildCollection(){
      if(collectionList!=null&&collectionList.list.length>=3){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
                onTap: () {goNoteInfo(context,collectionList.list[0].noteId);},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                      width: 93,
                      child: CachedNetworkImage(
                        imageUrl: DioUtil.imagePath+collectionList.list[0].photoUrl,
                        placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      collectionList.list[0].bookName,
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ],
                )),
            GestureDetector(
                onTap: () {goNoteInfo(context,collectionList.list[1].noteId);},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                      width: 93,
                      child: CachedNetworkImage(
                        imageUrl: DioUtil.imagePath+collectionList.list[1].photoUrl,
                        placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      collectionList.list[1].bookName,
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ],
                )),
            GestureDetector(
                onTap: () {goNoteInfo(context,collectionList.list[2].noteId);},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                      width: 93,
                      child: CachedNetworkImage(
                        imageUrl: DioUtil.imagePath+collectionList.list[2].photoUrl,
                        placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      collectionList.list[2].bookName,
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ],
                )),
          ],
        );
      }
      if(collectionList==null||collectionList.list.length==0){
        return Container();
      }
      if(collectionList!=null&&collectionList.list.length==1){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
                onTap: () {goNoteInfo(context,collectionList.list[0].noteId);},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                      width: 93,
                      child: CachedNetworkImage(
                        imageUrl: DioUtil.imagePath+collectionList.list[0].photoUrl,
                        placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      collectionList.list[0].bookName,
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 130,
              width: 93,
            ),
            SizedBox(
              height: 130,
              width: 93,
            )
          ],
        );
      }
      if(collectionList.list.length==2){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
                onTap: () {goNoteInfo(context,collectionList.list[0].noteId);},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                      width: 93,
                      child: CachedNetworkImage(
                        imageUrl: DioUtil.imagePath+collectionList.list[0].photoUrl,
                        placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
              collectionList.list[0].bookName,
              style: TextStyle(
                  fontSize: 10
              ),
            )
                  ],
                )),
            GestureDetector(
                onTap: () {goNoteInfo(context,collectionList.list[1].noteId);},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                      width: 93,
                      child: CachedNetworkImage(
                        imageUrl: DioUtil.imagePath+collectionList.list[1].photoUrl,
                        placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      collectionList.list[1].bookName,
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 130,
              width: 93,
            )
          ],
        );
      }

    }

    Widget buildNote(BuildContext context){
      if(noteList.list.length>0){
        return GestureDetector(
          onTap: (){goNoteInfo(context,noteList.list[0].noteId);},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      noteList.list[0].note,
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
                                '《' + noteList.list[0].bookName +
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
                    noteList.list[0].digest,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      }else{
        return Container();
      }
    }

  void goNoteInfo(BuildContext context,String noteId){
    Routes.router.navigateTo(context, '/noteDetailPage?noteId='+noteId,transition: TransitionType.fadeIn);
  }

  void goCollection(BuildContext context){
    Routes.router.navigateTo(context, '/collectionListPage',transition: TransitionType.fadeIn);
  }

  void goNoteList(BuildContext context){
    Routes.router.navigateTo(context, '/myNoteListPage',transition: TransitionType.fadeIn);
  }

}
