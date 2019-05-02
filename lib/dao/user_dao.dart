import 'dart:convert';

import 'package:readnote/common/local_storage.dart';
import 'package:readnote/res/constres.dart';


class UserDao{
  static login(userPhone,userPassword,store) async {
    String type = userPhone + ":" + userPassword;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    print(base64Str);
    

    Map requestParams = {
      "scopes": ['user','repo','gist','notification'],
      "note": "admin_script"
    };


    
  }
}