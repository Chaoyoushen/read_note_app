import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readnote/res/intlres.dart';
import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/utils/camera_util.dart';

class MakeNoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
            onTap: ()=>_onImageButtonPressed(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height:50,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,              // <-- 这里需要设置为 rectangle
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(25.0),        // <-- rectangle 时，BorderRadius 才有效
                    ),
                  ),
                  child: Icon(
                    IconData(0xe665,fontFamily: 'iconfont'),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  IntlUtil.getString(context, Ids.takePhoto),
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey
                  ),
                )
              ],
            )),
            GestureDetector(
              onTap: () =>_onGalleryButtonPressed(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height:50,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,              // <-- 这里需要设置为 rectangle
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(25.0),        // <-- rectangle 时，BorderRadius 才有效
                    ),
                  ),
                  child: Icon(
                    IconData(0xe69b,fontFamily: 'iconfont'),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  IntlUtil.getString(context, Ids.selectPhoto),
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey
                  ),
                )
              ],
            )),
          GestureDetector(
            onTap: (){Routes.router.navigateTo(context, '/digestPage?text=&type=',transition: TransitionType.fadeIn);},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height:50,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,              // <-- 这里需要设置为 rectangle
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(25.0),        // <-- rectangle 时，BorderRadius 才有效
                    ),
                  ),
                  child: Icon(
                    IconData(0xe649,fontFamily: 'iconfont'),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  IntlUtil.getString(context, Ids.createByCustom),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey

                  ),
                )
              ],
            )),
          ]
        )
    );
  }


  void _onImageButtonPressed(BuildContext context) async{
    String text =await CameraUtil.addNoteByPhoto(context);
    if(text == null){
      return;
    }
    String str = base64Url.encode(utf8.encode(text));
    Routes.router.navigateTo(context, '/digestPage?text=$str&type=camera',transition: TransitionType.fadeIn);
  }


  void _onGalleryButtonPressed(BuildContext context) async{
    String text =await CameraUtil.addNoteByGallery(context);
    if(text == null){
      return;
    }
    String str = base64Url.encode(utf8.encode(text));
    print('/digestPage?text=$str');
    Routes.router.navigateTo(context, '/digestPage?text=$str&type=gallery',transition: TransitionType.fadeIn);
  }
}