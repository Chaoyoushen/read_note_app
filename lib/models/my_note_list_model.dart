
import 'package:readnote/models/my_note_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_note_list_model.g.dart';


@JsonSerializable()
class MyNoteListModel{
  List<MyNoteModel> list;
  MyNoteListModel(this.list);
  factory MyNoteListModel.fromJson(Map<String, dynamic> json) => _$MyNoteListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyNoteListModelToJson(this);
}