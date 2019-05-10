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
  TextEditingController controller;
  _NoteDetailPageState(this.noteId);
  final String noteId;
  ExploreModel _exploreModel;
  List<DiscussModel> _list;

  @override
  void initState() {
    controller = new TextEditingController();
    getData(0);
    super.initState();
  }


   getData(int type)async {
     try {
       if (noteId == '' || noteId == null) {
         NoticeUtil.buildToast('err');
       }
       NoteDetailModel model = await DioUtil.getNoteDetail(noteId, type);
       setState(() {
         if(_exploreModel == null){
           _exploreModel = model.exploreModel;
         }
         _list = model.discussList;
       });
      }catch(e) {
        NoticeUtil.buildToast('net err');
        return null;
      }
    }

    void likeDiscuss(DiscussModel model){
      print(model.likeNum);
      print(model.nickname);
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
      body: _exploreModel == null?Center(child: CircularProgressIndicator()):_buildListView(context)
        );
  }


  Widget _buildListView(BuildContext context){
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  GestureDetector(
                    onTap: (){NoticeUtil.buildToast('tap header');},
                    child: Padding(
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
                  ),
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _exploreModel.note,
                            textAlign: TextAlign.start,
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
                  padding: EdgeInsets.only(left: 16, right: 16,bottom: 16),
                  child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _exploreModel.digest,
                        ),
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
          Divider(),
          _buildDiscussView(_list)
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
              text: '正在发表评论...',
            );
          }
      );
      await DioUtil.makeDiscuss(noteId, controller.text);
      Navigator.pop(context);
      controller.text = '';
      NoticeUtil.buildToast('discuss success');
      getData(1);
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

  Widget _itemBuilder(BuildContext context, int index,List<DiscussModel> list) {
    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
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
                              list[index].nickname == null?'':list[index].nickname,
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            Text(
                              Utils.getCurrentTime(list[index].createDate),
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
                    margin: EdgeInsets.only(right: 8),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(IconData(0xe644,fontFamily: 'iconfont')),
                          onPressed: (){likeDiscuss(list[index]);},
                        ),
                        Text(list[index].likeNum.toString())
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(list[index].discuss),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
