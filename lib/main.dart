import 'package:flutter/material.dart';
import 'ui/pages/login_page.dart';
import 'package:readnote/res/intlres.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:readnote/ui/pages/register_page.dart';
import 'package:readnote/ui/pages/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'common/routes.dart';
import 'common/local_storage.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  loadAsync();
  routerConf();
  runApp(MyApp());
  //setStatusBar();
}

loadAsync() async {
  await LocalStorage.getInstance();
}



void routerConf(){
  final router = new Router();
  Routes.configureRoutes(router);
  Routes.router = router;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  @override
  void initState() {
    super.initState();
    setLocalizedValues(localizedValues);

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.router.generator,
      //国际化相关
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      locale: _locale,
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}