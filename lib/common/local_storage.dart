import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'dart:async';

class LocalStorage{

  static LocalStorage _singleton;
  static SharedPreferences _sp;
  static Lock _lock = Lock();

  LocalStorage._();

  Future _init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static Future<LocalStorage> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = LocalStorage._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }





  static Future<bool> putString(String key,String value){
    if(_sp == null) return null;
    return _sp.setString(key, value == null ? '' : value);
  }

  static Object getObject(String key) {
    if (_sp == null) return null;
    String data = _sp.getString(key);
    return (data == null || data.isEmpty) ? null : data;
  }

  static Future<bool> remove(String key) {
    if (_sp == null) return null;
    return _sp.remove(key);
  }
}