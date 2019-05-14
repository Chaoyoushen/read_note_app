import 'package:json_annotation/json_annotation.dart';

part 'collection_model.g.dart';


@JsonSerializable()
class CollectionModel{
  String id;
  String bookName;
  String noteId;
  String photoUrl;
  CollectionModel(this.id,this.noteId,this.bookName,this.photoUrl);
  factory CollectionModel.fromJson(Map<String, dynamic> json) => _$CollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);
}