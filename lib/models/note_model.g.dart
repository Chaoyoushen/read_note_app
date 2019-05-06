// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) {
  return NoteModel(
      json['userId'] as String,
      json['noteId'] as String,
      json['bookId'] as String,
      json['digest'] as String,
      json['note'] as String,
      json['page'] as String,
      json['bookName'] as String,
      json['data'] == null ? null : DateTime.parse(json['data'] as String));
}

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'noteId': instance.noteId,
      'bookId': instance.bookId,
      'digest': instance.digest,
      'note': instance.note,
      'page': instance.page,
      'bookName': instance.bookName,
      'data': instance.data?.toIso8601String()
    };
