import 'package:json_annotation/json_annotation.dart';

part 'my_note_model.g.dart';


@JsonSerializable()
class MyNoteModel{
  String noteId;
  String digest;
  String note;
  String bookName;
  MyNoteModel(this.bookName,this.noteId,this.digest,this.note);
  factory MyNoteModel.fromJson(Map<String, dynamic> json) => _$MyNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyNoteModelToJson(this);
}