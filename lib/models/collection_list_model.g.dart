// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionListModel _$CollectionListModelFromJson(Map<String, dynamic> json) {
  return CollectionListModel((json['list'] as List)
      ?.map((e) => e == null
          ? null
          : CollectionModel.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$CollectionListModelToJson(
        CollectionListModel instance) =>
    <String, dynamic>{'list': instance.list};
