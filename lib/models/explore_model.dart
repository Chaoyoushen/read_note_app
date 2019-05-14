import 'package:json_annotation/json_annotation.dart';

part 'explore_model.g.dart';


@JsonSerializable()
class ExploreModel{
  final String digest;
  final String bookId;
  final String bookName;
  final String userId;
  final String noteId;
  final String imgPath;
  final String nickname;
  final String createDate;
  final int readNum;
  int likeNum;
  final int discussNum;
  final int collectionNum;
  final String note;
  final String page;
  int likeFlag;
  int collectionFlag;
  ExploreModel(
      this.digest,this.userId,this.page,this.bookName,this.note,this.bookId,this.createDate,
      this.discussNum,this.imgPath,this.likeNum,this.nickname,this.noteId,this.collectionNum,this.readNum,this.likeFlag,this.collectionFlag);

  factory ExploreModel.fromJson(Map<String, dynamic> json) => _$ExploreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreModelToJson(this);
}