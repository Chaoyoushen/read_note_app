import 'package:json_annotation/json_annotation.dart';

part 'result_model.g.dart';


@JsonSerializable()
class ResultModel<T>{
  final int code;
  final String message;
  final Object data;
  ResultModel(this.code,this.message,this.data);

  factory ResultModel.fromJson(Map<String, dynamic> json) => _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);

}