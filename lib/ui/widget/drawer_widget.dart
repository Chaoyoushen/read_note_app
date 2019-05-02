import 'package:flutter/material.dart';
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
                accountName: Text('chaoyous'),
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
                onTap: (){},
              ),
            ],
          ),
        );
  }
}