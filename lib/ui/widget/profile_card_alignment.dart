import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/models/explore_model.dart';
import 'package:readnote/utils/utils.dart';

class ProfileCardAlignment extends StatelessWidget {
  final ExploreModel _exploreModel;
  ProfileCardAlignment(this._exploreModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){goDetail(context);},
      child: Card(
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
            Padding(
                padding: EdgeInsets.only(left: 16,right: 16,bottom: 8),
                child: SizedBox(
                    height: 110,
                    child:Align(
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
                            onPressed: () {},
                            splashColor: Colors.blue,
                            highlightedBorderColor: Colors.blue,
                            child: Text(
                              '第'+_exploreModel.page+'页/《'+_exploreModel.bookName+'》',
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
              padding: EdgeInsets.only(left: 16,right: 16),
              child: SizedBox(
                  height: 125,
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
            Padding(
              padding: EdgeInsets.only(left: 12,right: 24,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(IconData(0xe6f3,fontFamily: 'iconfont'),color: Colors.black),
                          onPressed: (){share();},
                        ),
                        Text(_exploreModel.sharedNum.toString())
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
                        Text(_exploreModel.discussNum.toString())
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                              IconData(0xe669,fontFamily: 'iconfont'),color: Colors.red),
                          onPressed: (){addLike();},
                        ),
                        Text(_exploreModel.likeNum.toString())
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goDetail(BuildContext context){
    print(_exploreModel.noteId);
    Routes.router.navigateTo(context, '/noteDetailPage?noteId='+_exploreModel.noteId,transition: TransitionType.fadeIn);
  }

  void addLike(){}
  void share(){}
  void goDiscuss(BuildContext context){
    goDetail(context);
  }

}
