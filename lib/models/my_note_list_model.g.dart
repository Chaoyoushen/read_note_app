// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_note_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyNoteListModel _$MyNoteListModelFromJson(Map<String, dynamic> json) {
  return MyNoteListModel((json['list'] as List)
      ?.map((e) =>
          e == null ? null : MyNoteModel.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$MyNoteListModelToJson(MyNoteListModel instance) =>
    <String, dynamic>{'list': instance.list};
