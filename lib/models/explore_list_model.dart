import 'package:readnote/models/explore_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'explore_list_model.g.dart';


@JsonSerializable()
class ExploreListModel{
  final List<ExploreModel> exploreViewList;
  ExploreListModel(this.exploreViewList);

  factory ExploreListModel.fromJson(Map<String, dynamic> json) => _$ExploreListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreListModelToJson(this);
}