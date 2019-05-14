// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) {
  return CollectionModel(json['id'] as String, json['noteId'] as String,
      json['bookName'] as String, json['photoUrl'] as String);
}

Map<String, dynamic> _$CollectionModelToJson(CollectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookName': instance.bookName,
      'noteId': instance.noteId,
      'photoUrl': instance.photoUrl
    };
