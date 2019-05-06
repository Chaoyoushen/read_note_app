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
  final int likeNum;
  final int discussNum;
  final int sharedNum;
  final String note;
  final String page;
  ExploreModel(
      this.digest,this.userId,this.page,this.bookName,this.note,this.bookId,this.createDate,
      this.discussNum,this.imgPath,this.likeNum,this.nickname,this.noteId,this.sharedNum,this.readNum);
}