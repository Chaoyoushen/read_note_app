import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:readnote/models/explore_model.dart';

@immutable
abstract class ExploreState extends Equatable {
  ExploreState([List props = const []]) : super(props);
}

class LoadExplore extends ExploreState {
  ExploreModel model;

  LoadExplore({
    this.model
  }) : super([model]);
}
