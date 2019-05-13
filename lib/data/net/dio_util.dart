
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/common/routes.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/models/explore_list_model.dart';
import 'package:readnote/models/image_result.dart';
import 'package:readnote/models/login_model.dart';
import 'package:readnote/models/note_detail_model.dart';
import 'package:readnote/models/note_model.dart';
import 'package:readnote/models/result_model.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';
import 'package:uuid/uuid.dart';


class DioUtil {
  static final debug = false;
  static BuildContext context;
  /// 服务器路径
  ///static final host = 'http://132.232.86.173:7002';
  static final host = 'http://192.168.2.7:7002';
  ///调用api资源
  static final baiduHost = 'https://aip.baidubce.com/rest/2.0/ocr/v1';
  ///用户向服务请求识别某张图中的所有文字,通用文字识别
  static final generalBasic = '/general_basic';
  ///图片路径
  static final imagePath = 'http://isbn.szmesoft.com/ISBN/GetBookPhoto?ID=';

  static Options _option;
  static Dio _dio = new Dio();
  static final LogicError unknowError = LogicError(-1, "未知异常");



  static Options getOption(){
    String token = LocalStorage.getObject(ConstRes.TOKEN_KEY);
    if(_option == null){
      _option = new Options();
    }
    _option.headers.addAll({'token':token});
    _option.connectTimeout = 10000;
    return _option;
  }

  static Future<bool> changeName(String newName)async{
    try{
      String path = host + '/user/changeName?newName='+newName;
      final Response response = await _dio.get(path,options: getOption());
      print(response.data);
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200) {
        NoticeUtil.buildToast("change success");
        return true;
      }
      return false;
    }catch(e){
      NoticeUtil.buildToast("some thing wrong with net");
      return false;
    }
  }

  static Future<Image> getBookImage(String imgPath)async{
    try{
      var tempDir = await getTemporaryDirectory();
      Uuid uuid = new Uuid();
      String path = tempDir.path+'/'+uuid.v1()+'.jpg';
      print(path);
      final Response response = await _dio.download(imagePath+imgPath, path);
      if(response == null){
        NoticeUtil.buildToast("no such image");
        return Image.asset(Utils.getImgPath('default_book_image'));
      }
      return Image.file(File(path));
    }catch(e){
      NoticeUtil.buildToast("some thing wrong with net");
      return Image.asset(Utils.getImgPath('default_book_image'));
    }
  }





  static void getBaiduAIToken() async {
    String path = host+'/baidu/token';
    Response response = await _dio.get(path);
    String baiduToken = response.data['token'];
    print(baiduToken);
  }

  static Future<BookInfoModel> getBookByIsbn(String isbn)async{

    try{
      String path = host+'/search/isbn?isbn=';
      final Response response = await _dio.get(path+isbn,options: getOption());
      print(response.data);
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        Map tmp = model.data;
        print('tmp='+tmp.toString());
        BookInfoModel book = BookInfoModel.fromJson(tmp['book']);
        if(book.isbn == ''||book.isbn == null){
          return null;
        }else{
          return book;
        }
      }else{
        if(!tokenExpireFlag(model)){
          NoticeUtil.buildToast("unknow error");
        }
        return null;
      }
    }catch(e){
      NoticeUtil.buildToast("some thing wrong with net");
      return null;
    }
  }

  static Future<BookInfoModel> getBookByBookId(String bookId)async{

    try{
      String path = host+'/search/bookId?bookId=';
      final Response response = await _dio.get(path+bookId,options: getOption());
      print(response.data);
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        Map tmp = model.data;
        BookInfoModel book = BookInfoModel.fromJson(tmp['book']);
        if(book.isbn == ''||book.isbn == null){
          return null;
        }else{
          return book;
        }
      }else{
        if(!tokenExpireFlag(model)){
          NoticeUtil.buildToast("unknow error");
        }
        return null;
      }
    }catch(e){
      NoticeUtil.buildToast("some thing wrong with net");
      return null;
    }
  }



  static Future<ImageResult> getMessage(data) async{
    Options baiduOption = Options(
      contentType: ContentType.parse("application/x-www-form-urlencoded")
    );
    String path =baiduHost+generalBasic+'?'+'access_token='+ConstRes.BAIDUAI_TOKEN;
    final response = await _dio.post(
      path,
      data: {'image':data},
      options: baiduOption
    );
    print(response.data);
    ImageResult imageResult = ImageResult.fromJson(response.data);
    return imageResult;
  }

  static saveNote(NoteModel data)async{
    try{
      String path = host+'/note/save';
      print(json.encode(data));
      final Response response = await _dio.post(
        path,
        data: json.encode(data),
        options: getOption()
      );
      print(response.data);
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        NoticeUtil.buildToast("save success");
      }else if(model.data == 1005){
        NoticeUtil.buildToast("some thing wrong with insert");
      }else{
        if(!tokenExpireFlag(model)){
          NoticeUtil.buildToast("unknow error");
        }
      }
    }catch(e){
      print(e);
      NoticeUtil.buildToast("some thing wrong with net");
    }
  }

  static Future<bool> login(String phone,String password)async{
    Map data = {'phone':phone,'password':password};
    try{
      String path = host+'/user/login';
      final Response response = await _dio.post(
          path,
          data:json.encode(data),
      );
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        NoticeUtil.buildToast("login success");
        print(response.data);
        LoginModel login = LoginModel.fromJson(response.data['data']);
        await LocalStorage.putString(ConstRes.TOKEN_KEY, login.token);
        await LocalStorage.putString(ConstRes.USER_ID, login.userId);
        await LocalStorage.putString(ConstRes.USER_NAME_KEY, login.nickName);
        return true;
      }if(model.code == 501) {
        NoticeUtil.buildToast("redis server error");
      }
        if(model.data == 1001){
          NoticeUtil.buildToast("wrong phone or password");
        }else{
          if(!tokenExpireFlag(model)){
            NoticeUtil.buildToast("unknow error");
          }
        }
        return false;
      }catch(e){
      print(e.toString());
      NoticeUtil.buildToast("some thing wrong with net");
      return false;
    }
  }

  static Future<bool> register(String phone,String password)async{
    try{
      Map data = {'phone':phone,'password':password};
      String path = host+'/user/register';
      final Response response = await _dio.post(
          path,
          data:json.encode(data)
      );
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        NoticeUtil.buildToast("register success");
        print(response.data);
        LoginModel login = LoginModel.fromJson(response.data['data']);
        print(response.data);
        print(login.nickName);
        await LocalStorage.putString(ConstRes.TOKEN_KEY, login.token);
        await LocalStorage.putString(ConstRes.USER_ID, login.userId);
        await LocalStorage.putString(ConstRes.USER_NAME_KEY, login.nickName);
        print(LocalStorage.getObject(ConstRes.USER_NAME_KEY));
        return true;
      }if(model.data == 1002){
        NoticeUtil.buildToast("register failed");
      }else{
        if(!tokenExpireFlag(model)){
          NoticeUtil.buildToast("unknow error");
        }
      }
      return false;
    }catch(e){
      NoticeUtil.buildToast("some thing wrong with net");
      return false;
    }
  }

  static bool tokenExpireFlag(ResultModel model){
    if(model.data == 501){
      NoticeUtil.buildToast("token expire");
      Routes.router.navigateTo(context,'/loginPage',clearStack: true);
      return true;
    }else{
      return false;
    }
  }

  static Future<bool> logout()async{
    try{
      String path = host + '/user/logout';
      final Response response = await _dio.get(path,options: getOption());
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        NoticeUtil.buildToast("logout success");
        await LocalStorage.remove(ConstRes.TOKEN_KEY);
        await LocalStorage.remove(ConstRes.USER_ID);
        await LocalStorage.remove(ConstRes.USER_NAME_KEY);
        return true;
      }if(model.data == 3000){
        NoticeUtil.buildToast("redis error");
      }else{
        if(!tokenExpireFlag(model)){
          NoticeUtil.buildToast("unknow error");
        }
      }
      return false;
    }catch(e){
      NoticeUtil.buildToast("net error");
      print(e);
      return false;
    }

  }

  static Future<bool> checkLoginStatus()async{
    String path = host + '/user/check';
    Response response = await _dio.get(path,options: getOption());
    ResultModel model = ResultModel.fromJson(response.data);
    if(model.code == 200){
      return true;
    }else{
      tokenExpireFlag(model);
      return false;
    }
  }

  static Future<ExploreListModel> getExploreModel(int current,int num)async{
    String path = host + '/explore/get?';
    Response response = await _dio.get(path+'current=$current&num=$num',options: getOption());
    ResultModel model = ResultModel.fromJson(response.data);
    if(model.code == 200){
      Map tmp = model.data;
      List list = tmp['exploreViewList'];
      ExploreListModel exploreList = ExploreListModel.fromJson(tmp);
      return exploreList;
    }
    return null;
  }

  static Future<bool> makeDiscuss(String noteId,String discuss)async{
    try{
      String path = host + '/note/discuss/add';
      Map data = {'noteId':noteId,'discuss':discuss,'createDate':DateTime.now().millisecondsSinceEpoch.toString()};
      Response response = await _dio.post(
          path,
          options: getOption(),
          data: data
      );
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        return true;
      }else if(model.data == 1010){
        NoticeUtil.buildToast("sql error");
      }else{
        NoticeUtil.buildToast("unknow error");
      }
      return false;
    }catch(e){
      NoticeUtil.buildToast("something wrong with net");
      return false;
    }
  }

  static Future<NoteDetailModel> getNoteDetail(String noteId,int type)async{
    try{
      String path = host + '/note/query/detail?noteId=';
      Response response = await _dio.get(path+noteId+'&type='+type.toString(),options: getOption());
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        NoteDetailModel noteDetail = NoteDetailModel.fromJson(model.data);
        return noteDetail;
      }else if(model.data == 1010){
        NoticeUtil.buildToast("sql error");
      }else{
        NoticeUtil.buildToast("unknow error");
      }
      return null;
    }catch(e){
      NoticeUtil.buildToast("something wrong with net");
      return null;
    }
  }

  static likeDiscuss(String discussId)async{
    try{
      String path = host + '/note/discuss/manner?discussId=';
      Response response = await _dio.get(path+discussId,options: getOption());
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        return true;
      }else if(model.data == 1010){
        NoticeUtil.buildToast("sql error");
      }else{
        NoticeUtil.buildToast("unknow error");
      }
      return false;
    }catch(e){
      NoticeUtil.buildToast("something wrong with net");
      return false;
    }
  }

  static likeNote(String noteId)async{
    try{
      String path = host + '/note/manner?noteId=';
      Response response = await _dio.get(path+noteId,options: getOption());
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        return true;
      }else if(model.data == 1010){
        NoticeUtil.buildToast("sql error");
      }else{
        NoticeUtil.buildToast("unknow error");
      }
      return false;
    }catch(e){
      NoticeUtil.buildToast("something wrong with net");
      return false;
    }
  }


}


/// 统一异常类
class LogicError {
  int errorCode;
  String msg;

  LogicError(errorCode, msg) {
    this.errorCode = errorCode;
    this.msg = msg;
  }
}
