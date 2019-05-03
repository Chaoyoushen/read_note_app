import 'package:dio/dio.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/res/constres.dart';

class TokenInterceptors extends InterceptorsWrapper {
  
  String _token;

  @override
  onRequest(RequestOptions options) async {
    if(_token.isEmpty){
      var authCode = await getAuthCode();
      if(authCode != null){
        _token = authCode;
      }
    }
    options.headers["token"] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try{
      var respJson = response.data;
      if (response.statusCode == 200 && respJson["token"] != null) {
        _token = respJson["token"];
        await LocalStorage.putString(ConstRes.TOKEN_KEY, _token); 
      }
    }catch(e){
      print(e);
    }
    return response;
  }

  getAuthCode() {
    String token = LocalStorage.getObject(ConstRes.TOKEN_KEY);
    if(token.isEmpty){
      String basic = LocalStorage.getObject(ConstRes.BASE_CODE_KEY);
      if (basic.isEmpty) {
        //TODO 去登录界面
      } else {
        //TODO 通过basic获取token
        return "Basic $basic";
      }
    } else {
      return token;
    }
  }

  removeAuthCode(){
    this._token = null;
    LocalStorage.remove(ConstRes.TOKEN_KEY);
  }
}