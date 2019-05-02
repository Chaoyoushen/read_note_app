import 'package:dio/dio.dart';
import 'package:readnote/data/net/token_interceptors.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = Dio();

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

}