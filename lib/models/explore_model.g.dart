// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreModel _$ExploreModelFromJson(Map<String, dynamic> json) {
  return ExploreModel(
      json['digest'] as String,
      json['userId'] as String,
      json['page'] as String,
      json['bookName'] as String,
      json['note'] as String,
      json['bookId'] as String,
      json['createDate'] as String,
      json['discussNum'] as int,
      json['imgPath'] as String,
      json['likeNum'] as int,
      json['nickname'] as String,
      json['noteId'] as String,
      json['sharedNum'] as int,
      json['readNum'] as int);
}

Map<String, dynamic> _$ExploreModelToJson(ExploreModel instance) =>
    <String, dynamic>{
      'digest': instance.digest,
      'bookId': instance.bookId,
      'bookName': instance.bookName,
      'userId': instance.userId,
      'noteId': instance.noteId,
      'imgPath': instance.imgPath,
      'nickname': instance.nickname,
      'createDate': instance.createDate,
      'readNum': instance.readNum,
      'likeNum': instance.likeNum,
      'discussNum': instance.discussNum,
      'sharedNum': instance.sharedNum,
      'note': instance.note,
      'page': instance.page
    };
