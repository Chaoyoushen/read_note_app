// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteDetailModel _$NoteDetailModelFromJson(Map<String, dynamic> json) {
  return NoteDetailModel(
      json['exploreModel'] == null
          ? null
          : ExploreModel.fromJson(json['exploreModel'] as Map<String, dynamic>),
      (json['discussList'] as List)
          ?.map((e) => e == null
              ? null
              : DiscussModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NoteDetailModelToJson(NoteDetailModel instance) =>
    <String, dynamic>{
      'exploreModel': instance.exploreModel,
      'discussList': instance.discussList
    };
