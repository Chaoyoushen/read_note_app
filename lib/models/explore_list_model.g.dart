// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreListModel _$ExploreListModelFromJson(Map<String, dynamic> json) {
  return ExploreListModel((json['exploreViewList'] as List)
      ?.map((e) =>
          e == null ? null : ExploreModel.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ExploreListModelToJson(ExploreListModel instance) =>
    <String, dynamic>{'exploreViewList': instance.exploreViewList};
