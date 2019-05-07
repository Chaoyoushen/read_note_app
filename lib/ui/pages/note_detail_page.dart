import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/discuss_model.dart';
import 'package:readnote/models/explore_model.dart';
import 'package:readnote/models/note_detail_model.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';

class NoteDetailPage extends StatefulWidget {
  final String noteId;
  NoteDetailPage(this.noteId);
  @override
  _NoteDetailPageState createState() => _NoteDetailPageState(noteId);
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  var _futureBuilderFuture;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  TextEditingController controller;
  _NoteDetailPageState(this.noteId);
  final String noteId;
  ExploreModel _exploreModel;
  List<DiscussModel> list;

  @override
  void initState() {
    controller = new TextEditingController();
    _futureBuilderFuture = getData();
    super.initState();
  }

  Future getData()async{
      try{
        if(noteId == ''||noteId == null){
          NoticeUtil.buildToast('err');
        }
        return  await DioUtil.getNoteDetail(noteId);
      }catch(e) {
        NoticeUtil.buildToast('net err');
        return null;
      }
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          '笔记详情',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
            onRefresh: getData,
            child:FutureBuilder(
              builder: _buildFuture,
              future: _futureBuilderFuture,
            )
          )
        );
  }

  Widget _buildFuture(BuildContext context,AsyncSnapshot snapshot){
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildListView(context, snapshot);
      default:
        return Container();
    }

  }
  Widget _buildListView(BuildContext context,AsyncSnapshot snapshot){
    NoteDetailModel model= snapshot.data;
    print(snapshot.data.toString());
    _exploreModel = model.exploreModel;
    List<DiscussModel> list = model.discussList;
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 22, top: 22, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 40.0,
                        margin: EdgeInsets.only(right: 8),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: ExactAssetImage(Utils.getImgPath('guide1')),
                              fit: BoxFit.cover),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _exploreModel.nickname,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          Text(
                            Utils.getCurrentTime(_exploreModel.createDate) + ' ' +
                                _exploreModel.readNum.toString() + '阅读',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                    child: SizedBox(
                        height: 120,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _exploreModel.note,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 5,

                          ),
                        )
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
                              child: OutlineButton(
                                padding: EdgeInsets.only(left: 8),
                                onPressed: () {},
                                splashColor: Colors.blue,
                                highlightedBorderColor: Colors.blue,
                                child: Text(
                                  _exploreModel.page + '/《' + _exploreModel.bookName +
                                      '》',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue),
                                ),
                                borderSide: BorderSide(color: Color(0xFFFFFF)),
                              ),
                            )
                        )
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                      height: 160,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _exploreModel.digest,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          Card(
              child: Padding(
                  padding: EdgeInsets.only(right: 8,bottom: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width:250,
                          height: 65 ,
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: '请发表你的见解',
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: (){doDiscuss();},
                            child: Container(
                              height:39,
                              width: 39,
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.all(
                                  const Radius.circular(80.0),
                                ),
                              ),
                              child: Icon(
                                IconData(0xe6a0,fontFamily: 'iconfont'),
                                color: Colors.white,
                                size: 22,
                              ),
                            )
                        ),
                      ]
                  )
              )
          ),
          _buildDiscussView(list)
        ]
    );
  }

  void doDiscuss()async{
    if(controller.text == null||controller.text == ''){
      NoticeUtil.buildToast('please input your thought');
    }else{
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialog( //调用对话框
              text: '正在解析图片...',
            );
          }
      );
      await DioUtil.makeDiscuss(noteId, controller.text);
      Navigator.pop(context);
    }

  }

  Widget _buildDiscussView(List<DiscussModel> list){
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

  Widget _itemBuilder(BuildContext context, int index, movies) {
    if (index.isOdd) {
      return Divider();
    }
    index = index ~/ 2;
    return Container(
      height: 60,
      width: 300,
      margin: EdgeInsets.all(8),
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 22,top: 14,bottom: 8),
                  child:Row(
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 40.0,
                        margin: EdgeInsets.only(right: 8),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(image: ExactAssetImage(Utils.getImgPath('guide1')),fit: BoxFit.cover),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _exploreModel.nickname,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          Text(
                            Utils.getCurrentTime(_exploreModel.createDate)+' '+_exploreModel.readNum.toString()+'阅读',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(IconData(0xe644,fontFamily: 'iconfont')),
                      ),
                      Text('0')
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
