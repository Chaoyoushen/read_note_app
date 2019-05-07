// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discuss_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussModel _$DiscussModelFromJson(Map<String, dynamic> json) {
  return DiscussModel(
      json['createDate'] as String,
      json['nickname'] as String,
      json['likeNum'] as int,
      json['imgPath'] as String,
      json['userId'] as String,
      json['discuss'] as String,
      json['discussId'] as String);
}

Map<String, dynamic> _$DiscussModelToJson(DiscussModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'discussId': instance.discussId,
      'imgPath': instance.imgPath,
      'nickname': instance.nickname,
      'discuss': instance.discuss,
      'createDate': instance.createDate,
      'likeNum': instance.likeNum
    };
