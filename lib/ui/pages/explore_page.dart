import 'package:flutter/material.dart';
import 'package:readnote/ui/widget/cards_section_alignment.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: Column
        (
        children: <Widget>
        [
          CardsSectionAlignment(context),
        ],
      ),
    );
  }

}