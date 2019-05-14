// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyNoteModel _$MyNoteModelFromJson(Map<String, dynamic> json) {
  return MyNoteModel(json['bookName'] as String, json['noteId'] as String,
      json['digest'] as String, json['note'] as String);
}

Map<String, dynamic> _$MyNoteModelToJson(MyNoteModel instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'digest': instance.digest,
      'note': instance.note,
      'bookName': instance.bookName
    };
