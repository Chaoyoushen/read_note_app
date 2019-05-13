import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(
          IconData(0xe679, fontFamily: 'iconfont'),
            color: Colors.black,
          ),
          onPressed: () {Navigator.pop(context);}
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '个人信息',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          MaterialButton(
            onPressed: (){submit();},
            child: Text(
              '保存',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(

                labelText: '请输入新的昵称',
                hintText: LocalStorage.getObject(ConstRes.USER_NAME_KEY),
              ),
            ),
          )
        ],
      ),
    );
  }

  void submit()async{
    if(!RegExp('^[\u4e00-\u9fa5_a-zA-Z0-9]+\$').hasMatch(controller.text)){
      NoticeUtil.buildToast('wrong format');
      return;
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在修改...',
          );
        }
    );
    bool flag = await DioUtil.changeName(controller.text);
    if(flag == true){
      await LocalStorage.putString(ConstRes.USER_NAME_KEY, controller.text);
      Navigator.pop(context);
      NoticeUtil.buildToast('change success');
    }else{
      Navigator.pop(context);
      NoticeUtil.buildToast('change failed');
    }


  }
}
