

import 'package:readnote/models/discuss_model.dart';
import 'package:readnote/models/explore_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_detail_model.g.dart';


@JsonSerializable()
class NoteDetailModel{
  final ExploreModel exploreModel;
  final List<DiscussModel> discussList;
  NoteDetailModel(this.exploreModel,this.discussList);
  factory NoteDetailModel.fromJson(Map<String, dynamic> json) => _$NoteDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteDetailModelToJson(this);
}