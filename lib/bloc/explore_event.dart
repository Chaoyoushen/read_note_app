import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ExploreEvent extends Equatable {
  ExploreEvent([List props = const []]) : super(props);
}

class changeEvent extends ExploreEvent{}

class LoadEvent extends ExploreEvent{

}
