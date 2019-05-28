import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/res/intlres.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'common/routes.dart';
import 'common/local_storage.dart';
import 'package:readnote/res/constres.dart';


void main() {
  loadAsync();
  routerConf();
  runApp(MyApp());
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
      debugShowCheckedModeBanner: false,
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