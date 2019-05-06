import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';


@JsonSerializable()
class NoteModel{
    String userId;
    String noteId;
    String bookId;
    String digest;
    String note;
    String page;
    String bookName;
    String createDate;
    NoteModel(this.userId,this.noteId,this.bookId,this.digest,this.note,this.page,this.bookName,this.createDate);

    factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);

    Map<String, dynamic> toJson() => _$NoteModelToJson(this);


}