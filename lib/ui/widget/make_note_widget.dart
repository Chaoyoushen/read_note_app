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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            IntlUtil.getString(context, Ids.sheetTitle),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
            onTap: ()=>_onImageButtonPressed(context),
            child: Column(
              children: <Widget>[
                Icon(
                  IconData(0xe6ba,fontFamily: 'iconfont'),
                  size: 50,
                  ),
                Text(
                  IntlUtil.getString(context, Ids.takePhoto),
                )
              ],
            )),
            SizedBox(
              width: 65,
            ),
            GestureDetector(
              onTap: () =>_onGalleryButtonPressed(context),
            child: Column(
              children: <Widget>[
                Icon(
                  IconData(0xe613,fontFamily: 'iconfont'),
                  size: 50,
                ),
                Text(
                  IntlUtil.getString(context, Ids.selectPhoto),
                )
              ],
            )),
            SizedBox(
              width: 65,
            ),
          GestureDetector(
            onTap: (){Routes.router.navigateTo(context, '/digestPage?text=&type=',transition: TransitionType.fadeIn);},
            child: Column(
              children: <Widget>[
                Icon(
                  IconData(0xe7dd,fontFamily: 'iconfont'),
                  size: 50,
                  ),
                Text(
                  IntlUtil.getString(context, Ids.createByCustom),
                )
              ],
            )),
          ]
        )
      ],
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