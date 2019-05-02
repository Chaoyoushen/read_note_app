import 'package:flutter/material.dart';
import 'package:readnote/ui/widget/drawer_widget.dart';
import 'package:fluintl/fluintl.dart';
import 'package:readnote/res/intlres.dart';
import 'package:readnote/ui/pages/mine_page.dart';
import 'package:readnote/ui/pages/explore_page.dart';
import 'package:readnote/ui/widget/make_note_widget.dart';

bool isHomeInit = true;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final _bottomNavigationColor = Colors.black;
  final _textStyle = Colors.black;
  final _appBarColor = Colors.grey[200];
  List<Widget> pages = List<Widget>();

  @override
  void initState() { 
    super.initState();
        pages
          ..add(MinePage())
          ..add(null)
          ..add(ExplorePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: _appBarColor,
                leading: Builder(builder: (BuildContext context) {
                return IconButton(
                color: Colors.black,
                icon: const Icon(Icons.face),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            textTheme: TextTheme(
            title: TextStyle(
            color: Colors.black,
            fontSize: 20,
          )),
          title: Text(IntlUtil.getString(context, Ids.homeTitle)),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Colors.black,
            )
          ],
        ),
            drawer: DrawerWidget(),
            body: pages[_pageIndex],
            bottomNavigationBar: Container(
              height: 50,
              child: BottomNavigationBar(
                onTap: (int index){
                  if(index == 1){
                    makeNote(context);
                  }else{
                    setState((){
                        _pageIndex = index;
                      }
                    );
                  }
                },
                iconSize: 18,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconData(0xe62e,fontFamily: 'iconfont'),
                        color: _bottomNavigationColor,
                      ),
                      title: Text(
                        IntlUtil.getString(context, Ids.mine),
                        style: TextStyle(color: _textStyle,fontSize: 11),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconData(0xe618,fontFamily: 'iconfont'),
                        color: _bottomNavigationColor,
                      ),
                      title: Text(
                        IntlUtil.getString(context, Ids.addNote),
                        style: TextStyle(color: _textStyle,fontSize: 11),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconData(0xe63b,fontFamily: 'iconfont'),
                        color: _bottomNavigationColor,
                      ),
                      title: Text(
                        IntlUtil.getString(context, Ids.explore),
                        style: TextStyle(color: _textStyle,fontSize: 11),
                      )
                    )
                  ],
                )
            )
    );
  }

  void makeNote(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150.0,
          color: Color(0xfff1f1f1),
          child: MakeNoteWidget()
        );
      });
  }

}