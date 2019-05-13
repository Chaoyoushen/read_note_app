import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/handler/router_handler.dart';

class Routes {
  static Router router;
  static String root = '/';
  static String _splashPage = '/splashPage';
  static String _homePage = '/homePage';
  static String _loginPage = '/loginPage';
  static String _registerPage = '/registerPage';
  static String _cameraPage = '/cameraPage';
  static String _digestPage = '/digestPage';
  static String _notePage = '/notePage';
  static String _selectBookPage = '/selectBookPage';
  static String _checkNotePage = '/checkNotePage';
  static String _noteDetailPage = '/noteDetailPage';
  static String _bookInfoPage = '/bookInfoPage';
  static String _settingPage = '/settingPage';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>>params){
          print('route not found');
        }
      );
    router.define(
      root,
      handler: splanshHandler
      //handler: noteHandler
    );
    router.define(
      _loginPage,
      handler: loginHandler
    );
    router.define(
      _registerPage,
      handler: registerHandler
    );
    router.define(
      _homePage,
      handler: homeHandler
    );
    router.define(
      _cameraPage,
      handler: cameraHandler
    );
    router.define(
      _digestPage,
      handler: digestHandler
    );
    router.define(
        _notePage,
        handler: noteHandler
    );
    router.define(
        _selectBookPage,
        handler: selectBookHandler
    );
    router.define(
        _noteDetailPage,
        handler: noteDetailHandler
    );
    router.define(
        _checkNotePage,
        handler: checkNoteHandler
    );
    router.define(
        _bookInfoPage,
        handler: bookInfoHandler
    );
    router.define(
        _settingPage,
        handler: settingHandler
    );

  }
}