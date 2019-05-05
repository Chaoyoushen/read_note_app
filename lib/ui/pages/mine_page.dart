import 'package:flutter/material.dart';
import 'package:readnote/utils/utils.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  BoxConstraints _boxConstraints =
      const BoxConstraints(maxHeight: 50, maxWidth: 40);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          borderSide: BorderSide(color: Color(0xFFAD9A87)),
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
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.grey,
            ),
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
                              onPressed: () {},
                              splashColor: Color(0xFFAD9A87),
                              highlightedBorderColor: Color(0xFFAD9A87),
                              child: Text(
                                'MORE',
                                style: TextStyle(fontSize: 12),
                              ),
                              borderSide: BorderSide(color: Color(0xFFAD9A87)),
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
                              'note',
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
    )
    );}
}
