import 'package:json_annotation/json_annotation.dart';

part 'discuss_model.g.dart';


@JsonSerializable()
class DiscussModel{
  final String userId;
  final String discussId;
  final String imgPath;
  final String nickname;
  final String discuss;
  final String createDate;
  final int likeNum;
  DiscussModel(this.createDate,this.nickname,this.likeNum,this.imgPath,this.userId,this.discuss,this.discussId);

  factory DiscussModel.fromJson(Map<String, dynamic> json) => _$DiscussModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscussModelToJson(this);
}