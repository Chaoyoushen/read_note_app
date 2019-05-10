import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/explore_list_model.dart';
import 'package:readnote/models/explore_model.dart';
import './bloc.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  @override
  LoadExplore get initialState => LoadExplore();
  bool liked;
  int current = 3;

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) async* {
    if(event is LoadEvent){
      final ExploreListModel model = await DioUtil.getExploreModel(current%3, 1);
      current += 1;
      yield LoadExplore(model: model.exploreViewList[0]);
      return;
    }
    if(event is ChangeEvent){
      ExploreModel model = (currentState as LoadExplore).model;
      if(model.likeFlag != 1){
        model.likeFlag = 1;
      }
      model.likeNum += 1;
      yield LoadExplore(model: model);
    }



  }

}
