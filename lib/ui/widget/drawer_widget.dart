import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text('mathcnaaa@gmail.com'),
                accountName: Text(LocalStorage.getObject(ConstRes.USER_NAME_KEY)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      Utils.getImgPath('header')
                    ) 
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Utils.getImgPath('header')
                    ) 
                  )
                ),
              ),
              ListTile(
                title: Text('基础设置'),
                trailing: Icon(Icons.settings),
                onTap: (){},
              ),
              ListTile(
                title: Text('消息通知'),
                trailing: Icon(Icons.notifications_none),
                onTap: (){},
              ),
              ListTile(
                title: Text('关于我们'),
                trailing: Icon(Icons.feedback),
                onTap: (){},
              ),
              Divider(),
              ListTile(
                title: Text('注销'),
                trailing: Icon(Icons.exit_to_app),
                onTap: (){logout(context);},
              ),
            ],
          ),
        );
  }

  logout(BuildContext context)async{
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在注销...',
          );
        });
    bool flag = await DioUtil.logout();
    Navigator.pop(context);
    NoticeUtil.buildToast('logout success');
    if(flag){
      Routes.router.navigateTo(context, '/loginPage',clearStack: true);
    }else{
      NoticeUtil.buildToast('logout failed');
    }
  }
}