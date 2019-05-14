import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/my_note_list_model.dart';
import 'package:readnote/models/my_note_model.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';

class MyNoteListPage extends StatefulWidget {
  @override
  _MyNoteListPageState createState() => _MyNoteListPageState();
}

class _MyNoteListPageState extends State<MyNoteListPage> {
  MyNoteListModel _noteList;

  @override
  void initState() {
    initCollectionList();
    super.initState();
  }

  void initCollectionList()async{
    _noteList = await DioUtil.getNoteList();
    setState(() {

    });
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
      body: _noteList == null?Center(child: CircularProgressIndicator()):_buildCollectionView(_noteList.list),
    );
  }

  Widget _buildCollectionView(List<MyNoteModel> list){
    if(list == null){
      return null;
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _itemBuilder(context, index, list),
    );
  }

  Widget _itemBuilder(BuildContext context, int index,List<MyNoteModel> list) {
    return GestureDetector(
        onTap: (){goDetail(context,list[index].noteId);},
        onLongPress: (){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('提示'),
              content: Text(('是否删除该书摘')),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    deleteNote(list[index].noteId,index);
                  },
                ),
              ],
            ));},
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
  void deleteNote(String noteId,int index)async{
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在删除...',
          );
        }
    );
    bool flag = await DioUtil.deleteNote(noteId);
    if(flag){
      Navigator.pop(context);
      NoticeUtil.buildToast('delete success');
    }else{
      Navigator.pop(context);
      NoticeUtil.buildToast('delete failed');
    }
    setState(() {
      _noteList.list.removeAt(index);
    });
  }
}
