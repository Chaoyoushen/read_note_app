import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/explore_list_model.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/utils/utils.dart';
import 'package:readnote/common/routes.dart';
import 'package:fluro/fluro.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {


  @override
  Widget build(BuildContext context) {
    return buildListView();}

    Widget buildListView(){
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: <Widget>[
          SizedBox(
            height: 220,
            child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('我的书架'),
                          SizedBox(
                            height: 18,
                            width: 70,
                            child: OutlineButton(
                              onPressed: () {},
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    Utils.getImgPath('guide1'),
                                    height: 130,
                                    width: 93,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text('111')
                                ],
                              )),
                          GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    Utils.getImgPath('guide1'),
                                    height: 130,
                                    width: 93,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text('111')
                                ],
                              )),
                          GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    Utils.getImgPath('guide1'),
                                    height: 130,
                                    width: 93,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text('111')
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(
              height: 300,
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
                                  fun();
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
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 200,
                                  child: Text(
                                    LocalStorage.getObject(ConstRes.TOKEN_KEY),
                                    maxLines: 4,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
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
}
