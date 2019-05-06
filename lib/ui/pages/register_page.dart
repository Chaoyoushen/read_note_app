import 'package:flutter/material.dart';
import 'package:fluintl/fluintl.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/res/intlres.dart';
import 'package:fluro/fluro.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;
  Color _eyeColor;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child: ListView(
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
                SizedBox(height: 116.0),
                buildRegisterButton(context),
                SizedBox(height: 30.0),
                buildLoginText(context),
              ],
            )));
  }

  Align buildLoginText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(IntlUtil.getString(context, Ids.toLoginText)),
            GestureDetector(
              child: Text(
                IntlUtil.getString(context, Ids.toLoginBottom),
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Routes.router.navigateTo(context, '/loginPage',clearStack: true,transition: TransitionType.fadeIn);
              },
            ),
          ],
        ),
      ),
    );
  }

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            IntlUtil.getString(context, Ids.registerBottom),
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            register();
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
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

  TextFormField buildPhoneTextFiled(){
      return TextFormField(
        controller: _phoneController,
      keyboardType: TextInputType.numberWithOptions(),
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


  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 30.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        IntlUtil.getString(context, Ids.registerTitle),
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  void register()async{
      String phone = _phoneController.text;
      String password = _passwordController.text;
      showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialog(
              text: '正在注册...',
            );
          });
      bool flag = await DioUtil.register(phone, password);
      Navigator.pop(context);
      if(flag){
        Routes.router.navigateTo(context, '/homePage',transition: TransitionType.fadeIn,clearStack: true);
      }
    }
}
