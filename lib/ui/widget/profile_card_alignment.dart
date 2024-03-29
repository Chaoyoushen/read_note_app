import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/explore_list_model.dart';
import 'package:readnote/models/explore_model.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';



class ProfileCardAlignment extends StatelessWidget {
  ExploreModel exploreModel;
  ProfileCardAlignment(this.exploreModel);
  @override
  Widget build(BuildContext context) {
    return buildCard(context);

  }
  Widget buildCard(BuildContext context){
    return Card(
        child: Column(
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
                      image: DecorationImage(image: ExactAssetImage(Utils.getImgPath('header')),fit: BoxFit.cover),
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
                        exploreModel.nickname,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Text(
                        Utils.getCurrentTime(exploreModel.createDate)+' '+exploreModel.readNum.toString()+'阅读',
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){goDetail(context);},
              child:Padding(
                padding: EdgeInsets.only(left: 16,right: 16,bottom: 8),
                child: SizedBox(
                    height: 110,
                    child:Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        exploreModel.note,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 5,

                      ),
                    )
                )
            )),
            Padding(
                padding: EdgeInsets.only(left: 8,right: 8),
                child:Column(
                  children: <Widget>[
                    Divider(color: Colors.black),
                    Align(
                        alignment: Alignment.centerLeft,
                        child:SizedBox(
                          height: 20,
                          child: OutlineButton(
                            padding: EdgeInsets.only(left: 8),
                            onPressed: () {goBookInfo(context);},
                            splashColor: Colors.blue,
                            highlightedBorderColor: Colors.blue,
                            child: Text(
                              '第'+exploreModel.page+'页/《'+exploreModel.bookName+'》',
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
            GestureDetector(
              onTap: (){goDetail(context);},
              child:Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
                child: SizedBox(
                  height: 125,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      exploreModel.digest,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                  )
              ),
            )),
            Padding(
              padding: EdgeInsets.only(left: 12,right: 24,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(IconData(0xe7e1,fontFamily: 'iconfont'),color: Colors.black),
                          onPressed: (){goDetail(context);},
                        ),
                        Text(exploreModel.collectionNum.toString())
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(IconData(0xe667,fontFamily: 'iconfont'),color: Colors.black),
                          onPressed: (){goDiscuss(context);},
                        ),
                        Text(exploreModel.discussNum.toString())
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: exploreModel.likeFlag == 1?Icon(IconData(0xe668,fontFamily: 'iconfont'),color: Colors.red)
                              :Icon(IconData(0xe669,fontFamily: 'iconfont'),color: Colors.red),
                          onPressed: (){mannerLike(context);},
                        ),
                        Text(exploreModel.likeNum.toString())
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  void goDetail(BuildContext context){
    print(exploreModel.noteId);
    Routes.router.navigateTo(context, '/noteDetailPage?noteId='+exploreModel.noteId,transition: TransitionType.fadeIn);
  }

  void mannerLike(BuildContext context){
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在注销...',
          );
        });
    DioUtil.likeNote(exploreModel.noteId);
    Navigator.pop(context);
    NoticeUtil.buildToast('success');
  }
  void goDiscuss(BuildContext context){
    goDetail(context);
  }

  void goBookInfo(BuildContext context){
    Routes.router.navigateTo(context, '/bookInfoPage?bookId='+exploreModel.bookId,transition: TransitionType.fadeIn);
  }
}



