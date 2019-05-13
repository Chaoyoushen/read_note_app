import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:readnote/ui/pages/book_info_page.dart';
import 'package:readnote/ui/pages/check_note_page.dart';
import 'package:readnote/ui/pages/digest_page.dart';
import 'package:readnote/ui/pages/home_page.dart';
import 'package:readnote/ui/pages/login_page.dart';
import 'package:readnote/ui/pages/note_detail_page.dart';
import 'package:readnote/ui/pages/select_book_page.dart';
import 'package:readnote/ui/pages/setting_page.dart';
import 'package:readnote/ui/pages/splash_page.dart';
import 'package:readnote/ui/pages/register_page.dart';
import 'package:readnote/ui/pages/camera_page.dart';
import 'package:readnote/ui/pages/note_page.dart';

var homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return HomePage();
  }
);

var loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return LoginPage();
  }
);

var registerHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return RegisterPage();
  }
);

var splanshHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return SplashPage();
  }
);

var cameraHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return CameraPage();
  }
);

var digestHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    var text = params['text']?.first;
    var type = params['type']?.first;
    return DigestPage(
      text,
      type
    );
  }
);

var noteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      var uuid = params['uuid']?.first;
      return NotePage(
        uuid
      );
    }
);

var selectBookHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      //var digest = params['digest']?.first;
      return SelectBookPage();
    }
);

var noteDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      String noteId = params['noteId']?.first;
      return NoteDetailPage(noteId);
    }
);

var checkNoteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      var uuid = params['uuid']?.first;
      return CheckNotePage(
        uuid
      );
    }
);

var bookInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      var bookId = params['bookId']?.first;
      return BookInfoPage(
          bookId
      );
    }
);

var settingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return SettingPage();
    }
);
