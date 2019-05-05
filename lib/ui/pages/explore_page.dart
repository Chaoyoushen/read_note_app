import 'package:flutter/material.dart';
import 'package:readnote/ui/widget/cards_section_alignment.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column
        (
        children: <Widget>
        [
          CardsSectionAlignment(context),
          buttonsRow()
        ],
      ),
    );
  }

  Widget buttonsRow()
  {
    return new Container
      (
      margin: new EdgeInsets.symmetric(vertical: 22.0),
      child: new Row
        (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          new FloatingActionButton
            (
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: new Icon(Icons.loop, color: Colors.yellow),
          ),
          new Padding(padding: new EdgeInsets.only(right: 8.0)),
          new FloatingActionButton
            (
            onPressed: () {},
            backgroundColor: Colors.white,
            child: new Icon(Icons.close, color: Colors.red),
          ),
          new Padding(padding: new EdgeInsets.only(right: 8.0)),
          new FloatingActionButton
            (
            onPressed: () {},
            backgroundColor: Colors.white,
            child: new Icon(Icons.favorite, color: Colors.green),
          ),
          new Padding(padding: new EdgeInsets.only(right: 8.0)),
          new FloatingActionButton
            (
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: new Icon(Icons.star, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}