// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResult _$ImageResultFromJson(Map<String, dynamic> json) {
  return ImageResult(json['log_id'] as int, json['words_result_num'] as int,
      json['words_result'] as List);
}

Map<String, dynamic> _$ImageResultToJson(ImageResult instance) =>
    <String, dynamic>{
      'log_id': instance.log_id,
      'words_result_num': instance.words_result_num,
      'words_result': instance.words_result
    };
