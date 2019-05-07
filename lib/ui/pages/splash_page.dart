import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';


import 'package:fluintl/fluintl.dart';
import 'package:readnote/res/intlres.dart';

import 'package:fluro/fluro.dart';
import 'package:readnote/common/routes.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TransitionType _transitionType = TransitionType.fadeIn;

  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
  ];

  List<Widget> _bannerList = List();

  ///控制页面显示状态，status= 0 显示启动图,status = 1 显示引导图
  int _status = 0;


  @override
  void initState() {
    super.initState();
    _doDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          Offstage(
            offstage: !(_status == 1),
            child:ObjectUtil.isEmpty(_bannerList)
                ? new Container()
                : Swiper(
                  loop: false,
                  itemBuilder:(BuildContext context,int index){
                    return _bannerList[index];
                  },
              itemCount: 3,
            )
          )
        ],
      ),
    );
  }

  Widget _buildSplashBg() {
    return Image.asset(
      Utils.getImgPath('launch'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
    
  }

  void _doDelay() async{
    await Future.delayed(Duration(milliseconds: 3000));
    try{
    if(LocalStorage.getObject(ConstRes.TOKEN_KEY)!=null) {
        bool flag = await DioUtil.checkLoginStatus();
        if (flag) {
          _goMain(context);
        }else{
          _goLogin(context);
        }
    }else{
      _initBanner();
    }
      }catch(e){
      NoticeUtil.buildToast('net error');
    }

  }

  void _goMain(BuildContext context) {
    Routes.router.navigateTo(context, "/homePage",transition: TransitionType.inFromRight,clearStack: true);
  }

    void _goLogin(BuildContext context) {
      Routes.router.navigateTo(context, "/loginPage",transition: _transitionType,clearStack: true);
    }

  void _initBanner() {  
    _initBannerData();
    setState(() {
      _status = 1;
    });
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  _goLogin(context);
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      IntlUtil.getString(context, Ids.outOfBannerButton),
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                width: 0.33, color: Colors.grey))),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }
}