import 'package:flutter/material.dart';
import 'package:fluintl/fluintl.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/res/intlres.dart';
import 'package:fluro/fluro.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  Color _eyeColor;

  var _userPhoneController = new TextEditingController();
  var _userPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child:Scaffold(
      body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      children: <Widget>[
        SizedBox(
          height: kToolbarHeight,
        ),
        buildTitle(),
        buildTitleLine(),
        SizedBox(height: 70.0),
        buildPhoneTextFiled(),
        SizedBox(height: 30.0),
        buildPasswordTextField(context),
        //buildForgetPasswordText(context),
        SizedBox(height: 60.0),
        buildLoginButton(context),
        SizedBox(height: 30.0),
        buildRegisterText(context),
      ],
    )));
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        IntlUtil.getString(context, Ids.loginTitle),
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 100.0,
          height: 2.0,
        ),
      ),
    );
  }

  TextFormField buildPhoneTextFiled() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(),
      controller: _userPhoneController,
      decoration: InputDecoration(
        labelText: IntlUtil.getString(context, Ids.phoneInputText),
      ),
      validator: (String value) {
        var phoneReg = RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
        if (!phoneReg.hasMatch(value)) {
          return IntlUtil.getString(context, Ids.phoneInputNotice);
        }
      },
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _userPasswordController,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.length < 4) {
          return IntlUtil.getString(context, Ids.passwordInputNotice);
        }
      },
      decoration: InputDecoration(
          labelText: IntlUtil.getString(context, Ids.passwordInputText),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            IntlUtil.getString(context, Ids.forgetPasswordText),
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            IntlUtil.getString(context, Ids.loginBottom),
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () =>forSave(context),
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(IntlUtil.getString(context, Ids.toRegisterText)),
            GestureDetector(
              child: Text(
                IntlUtil.getString(context, Ids.toRegisterBottom),
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Routes.router.navigateTo(context, '/registerPage', transition: TransitionType.fadeIn);
              },
            ),
          ],
        ),
      ),
    );
  }

  void forSave(BuildContext context) async{
      String phone = _userPhoneController.text;
      String password = _userPasswordController.text;
      print("phone:"+phone+", password:"+password);
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialog( //调用对话框
              text: '正在登录...',
            );
          });
      bool flag = await DioUtil.login(phone, password);
      Navigator.pop(context);
      if(flag){
        Routes.router.navigateTo(context, '/homePage',transition: TransitionType.fadeIn,clearStack: true);
      }

  }
}
