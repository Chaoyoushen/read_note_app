

import 'package:readnote/models/collection_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_list_model.g.dart';


@JsonSerializable()
class CollectionListModel{
  List<CollectionModel> list;
  CollectionListModel(this.list);
  factory CollectionListModel.fromJson(Map<String, dynamic> json) => _$CollectionListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionListModelToJson(this);
}