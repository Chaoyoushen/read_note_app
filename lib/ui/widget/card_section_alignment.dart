import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readnote/bloc/bloc.dart';
import 'package:readnote/bloc/explore_bloc.dart';
import 'package:readnote/common/local_storage.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/explore_list_model.dart';
import 'package:readnote/models/explore_model.dart';
import 'package:readnote/res/constres.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';
import 'profile_card_alignment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

List<Alignment> cardsAlign = [ new Alignment(0.0, 1.0), new Alignment(0.0, 0.8), new Alignment(0.0, 0.0) ];
List<Size> cardsSize = new List(3);

class CardsSectionAlignment extends StatefulWidget
{
  CardsSectionAlignment(BuildContext context)
  {
    cardsSize[0] = new Size(MediaQuery.of(context).size.width * 0.92, MediaQuery.of(context).size.height * 0.75);
    cardsSize[1] = new Size(MediaQuery.of(context).size.width * 0.90, MediaQuery.of(context).size.height * 0.70);
    cardsSize[2] = new Size(MediaQuery.of(context).size.width * 0.88, MediaQuery.of(context).size.height * 0.65);
  }

  @override
  _CardsSectionState createState() => new _CardsSectionState();
}

class _CardsSectionState extends State<CardsSectionAlignment> with SingleTickerProviderStateMixin
{
  final ExploreBloc _exploreBloc = ExploreBloc();
  ///记录划过的卡片数量
  int cardsCounter = 0;

  List<ProfileCardAlignment> cards = new List();
  AnimationController _controller;

  final Alignment defaultFrontCardAlign = new Alignment(0.0, 0.0);
  Alignment frontCardAlign;
  double frontCardRot = 0.0;
  bool initComplete = false;
  ExploreModel defaultModel = ExploreModel('', '', '', '', '', '', '0', 0, '', 0, '', '', 0, 0,0,0);
  ProfileCardAlignment nextCard;

  @override
  void initState()
  {
    initCard();
    _exploreBloc.dispatch(LoadEvent());
    super.initState();
    frontCardAlign = cardsAlign[2];

    _controller = new AnimationController(duration: new Duration(milliseconds: 700), vsync: this);
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status)
    {
      if(status == AnimationStatus.completed) {
        changeCardsOrder();
      }
    });
  }

  Widget buildNextCard(BuildContext context){
    return BlocBuilder(
      bloc: _exploreBloc,
      builder: (BuildContext context,ExploreState state){
        if(state is LoadExplore){
          return ProfileCardAlignment(state.model);
        }
      },
    );
  }



  void initCard()async{
    ExploreListModel model = await DioUtil.getExploreModel(0, 3);
    model.exploreViewList.forEach((el){cards.add(ProfileCardAlignment(el));});
    setState(() {
      initComplete = true;
    });
  }
  void setNextCard()async{
    ExploreListModel model = await DioUtil.getExploreModel(cardsCounter%3, 1);
      nextCard = ProfileCardAlignment(model.exploreViewList[0]);
  }

  @override
  Widget build(BuildContext context)
  {
    return !initComplete?
    Center(child: CircularProgressIndicator()):
    new Expanded
      (
        child: new Stack
          (
          children: <Widget>
          [
            backCard(),
            middleCard(),
            frontCard(),

            // Prevent swiping if the cards are animating
            _controller.status != AnimationStatus.forward ? new SizedBox.expand
              (
                child: new GestureDetector
                  (
                  // While dragging the first card
                  onPanUpdate: (DragUpdateDetails details)
                  {
                    // Add what the user swiped in the last frame to the alignment of the card
                    setState(()
                    {
                      // 20 is the "speed" at which moves the card
                      frontCardAlign = new Alignment
                        (
                          frontCardAlign.x + 20 * details.delta.dx / MediaQuery.of(context).size.width,
                          frontCardAlign.y + 40 * details.delta.dy / MediaQuery.of(context).size.height
                      );

                      frontCardRot = frontCardAlign.x; // * rotation speed;
                    });
                  },
                  // When releasing the first card
                  onPanEnd: (_)
                  {
                    // If the front card was swiped far enough to count as swiped
                    if(frontCardAlign.x > 3.0 || frontCardAlign.x < -3.0)
                    {
                      animateCards();
                    }
                    else
                    {
                      // Return to the initial rotation and alignment
                      setState(()
                      {
                        frontCardAlign = defaultFrontCardAlign;
                        frontCardRot = 0.0;
                      });
                    }
                  },
                )
            ) : new Container(),
          ],
        )
    );
  }

  Widget backCard()
  {
    return new Align
      (
      alignment: _controller.status == AnimationStatus.forward ? CardsAnimation.backCardAlignmentAnim(_controller).value : cardsAlign[0],
      child: new SizedBox.fromSize
        (
          size: _controller.status == AnimationStatus.forward ? CardsAnimation.backCardSizeAnim(_controller).value : cardsSize[2],
          child: cards[2]
      ),
    );
  }

  Widget middleCard()
  {
    return new Align
      (
      alignment: _controller.status == AnimationStatus.forward ? CardsAnimation.middleCardAlignmentAnim(_controller).value : cardsAlign[1],
      child: new SizedBox.fromSize
        (
          size: _controller.status == AnimationStatus.forward ? CardsAnimation.middleCardSizeAnim(_controller).value : cardsSize[1],
          child: cards[1]
      ),
    );
  }

  Widget frontCard()
  {
    return new Align
      (
        alignment: _controller.status == AnimationStatus.forward ? CardsAnimation.frontCardDisappearAlignmentAnim(_controller, frontCardAlign).value : frontCardAlign,
        child: new Transform.rotate
          (
          angle: (pi / 180.0) * frontCardRot,
          child: new SizedBox.fromSize
            (
              size: cardsSize[0],
              child: cards[0]
          ),
        )
    );
  }

  void changeCardsOrder()
  {
    setState(()
    {
      // Swap cards (back card becomes the middle card; middle card becomes the front card, front card becomes a new bottom card)
        cards[0] = cards[1];
        cards[1] = cards[2];
        cards[2] = nextCard;
        setNextCard();
        cardsCounter++;
        frontCardAlign = defaultFrontCardAlign;
        frontCardRot = 0.0;
    });
  }



  void animateCards()
  {
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }

  @override
  void dispose() {
    _exploreBloc.dispose();
    super.dispose();
  }
}

class CardsAnimation
{
  static Animation<Alignment> backCardAlignmentAnim(AnimationController parent)
  {
    return new AlignmentTween
      (
        begin: cardsAlign[0],
        end: cardsAlign[1]
    ).animate
      (
        new CurvedAnimation
          (
            parent: parent,
            curve: new Interval(0.4, 0.7, curve: Curves.easeIn)
        )
    );
  }

  static Animation<Size> backCardSizeAnim(AnimationController parent)
  {
    return new SizeTween
      (
        begin: cardsSize[2],
        end: cardsSize[1]
    ).animate
      (
        new CurvedAnimation
          (
            parent: parent,
            curve: new Interval(0.4, 0.7, curve: Curves.easeIn)
        )
    );
  }

  static Animation<Alignment> middleCardAlignmentAnim(AnimationController parent)
  {
    return new AlignmentTween
      (
        begin: cardsAlign[1],
        end: cardsAlign[2]
    ).animate
      (
        new CurvedAnimation
          (
            parent: parent,
            curve: new Interval(0.2, 0.5, curve: Curves.easeIn)
        )
    );
  }

  static Animation<Size> middleCardSizeAnim(AnimationController parent)
  {
    return new SizeTween
      (
        begin: cardsSize[1],
        end: cardsSize[0]
    ).animate
      (
        new CurvedAnimation
          (
            parent: parent,
            curve: new Interval(0.2, 0.5, curve: Curves.easeIn)
        )
    );
  }

  static Animation<Alignment> frontCardDisappearAlignmentAnim(AnimationController parent, Alignment beginAlign)
  {
    return new AlignmentTween
      (
        begin: beginAlign,
        end: new Alignment(beginAlign.x > 0 ? beginAlign.x + 30.0 : beginAlign.x - 30.0, 0.0)
    ).animate
      (
        new CurvedAnimation
          (
            parent: parent,
            curve: new Interval(0.0, 0.5, curve: Curves.easeIn)
        )
    );
  }


}
