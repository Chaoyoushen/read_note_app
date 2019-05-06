import 'package:flutter/material.dart';
import 'package:readnote/utils/utils.dart';

class ProfileCardAlignment extends StatelessWidget
{

  ///example 带一个顺序参数
  ///TODO
  final int cardNum;
  ProfileCardAlignment(this.cardNum);



  @override
  Widget build(BuildContext context)
  {
    return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 22,top: 22,bottom: 8),
              child:Row(
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    margin: EdgeInsets.only(right: 8),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(image: ExactAssetImage(Utils.getImgPath('guide1')),fit: BoxFit.cover),
                      shape: BoxShape.rectangle,              // <-- 这里需要设置为 rectangle
                      borderRadius: new BorderRadius.all(
                        const Radius.circular(5.0),        // <-- rectangle 时，BorderRadius 才有效
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'chaoyous',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      Text(
                        '2019-5-5  100阅读',
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
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 90,
                child:Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'note',
                    textAlign: TextAlign.start,
                    maxLines: 15,

                  ),
                )
              )
            ),
            Padding(
                padding: EdgeInsets.all(8),
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
                            'bookinfo',
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
              padding: EdgeInsets.only(left: 8,right: 8),
              child: SizedBox(
                height: 160,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('digest'),
                )
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(IconData(0xe6f3,fontFamily: 'iconfont'),color: Colors.black),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Icon(IconData(0xe667,fontFamily: 'iconfont'),color: Colors.black),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Icon(
                            IconData(0xe669,fontFamily: 'iconfont'),color: Colors.red),
                        onPressed: (){},
                      ),
                    ],
                  ),
            ),
          ],
        ),
    );
  }
}