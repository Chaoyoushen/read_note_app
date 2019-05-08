import 'package:flutter/material.dart';
import 'package:readnote/ui/widget/cards_section_alignment.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CardsSectionAlignment(context)
        ],
      ),
    );
  }
}
