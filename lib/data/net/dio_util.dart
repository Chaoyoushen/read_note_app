
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/models/image_result.dart';
import 'package:readnote/models/note_model.dart';
import 'package:readnote/models/result_model.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/utils/notice_util.dart';


class DioUtil {
  static final debug = false;
  static BuildContext context;
  /// 服务器路径
  static final host = 'http://192.168.2.11:7002';
  ///调用api资源
  static final baiduHost = 'https://aip.baidubce.com/rest/2.0/ocr/v1';
  ///用户向服务请求识别某张图中的所有文字,通用文字识别
  static final generalBasic = '/general_basic';

  static Dio _dio = new Dio();


  static String token;

  static final LogicError unknowError = LogicError(-1, "未知异常");


  ///获取授权token
  static getToken() {
    String token = LocalStorage.getObject(ConstRes.TOKEN_KEY);
    return token;
  }

  static void getBaiduAIToken() async {
    String path = host+'/baidu/token';
    Response response = await _dio.get(path);
    String baiduToken = response.data;
    print(baiduToken);
  }

  static Future<BookInfoModel> getBookByIsbn(String isbn)async{

    try{
      String path = host+'/search/isbn?isbn=';
      final Response response = await _dio.get(path+isbn);
      print(response.data);
      ResultModel model = ResultModel.fromJson(response.data);
      print(model);
      Map tmp = model.data;
      print('tmp='+tmp.toString());
      BookInfoModel book = BookInfoModel.fromJson(tmp['book']);
      if(book.isbn == ''||book.isbn == null){
        return null;
      }else{
        return book;
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
        data: json.encode(data)
      );
      print(response.data);
      ResultModel model = ResultModel.fromJson(response.data);
      if(model.code == 200){
        NoticeUtil.buildToast("save success");
      }else if(model.data == 1005){
        NoticeUtil.buildToast("some thing wrong with insert");
      }else{
        NoticeUtil.buildToast("some thing wrong with net");
      }
    }catch(e){
      print(e);
      NoticeUtil.buildToast("some thing wrong");
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
