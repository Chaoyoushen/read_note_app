import 'package:json_annotation/json_annotation.dart';

part 'image_result.g.dart';


@JsonSerializable()
class ImageResult{
  final int log_id;
  final int words_result_num;
  final List words_result;

  ImageResult(this.log_id,this.words_result_num,this.words_result);

  factory ImageResult.fromJson(Map<String, dynamic> json) => _$ImageResultFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResultToJson(this);


}