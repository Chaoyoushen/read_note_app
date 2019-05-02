import 'package:json_annotation/json_annotation.dart';

part 'book_info_model.g.dart';


@JsonSerializable()
class BookInfoModel{
  final String isbn;
  final String bookName;
  final String author;
  final String publishing;
  final String asin;
  final String brand;
  final String weight;
  final String size;
  final String pages;
  final String price;
  final String photoUrl;
  final String id;
  final String bookId;
  BookInfoModel(this.isbn,this.bookName,this.author,this.asin,this.brand,this.id,this.pages,this.bookId,this.photoUrl,this.price,this.publishing,this.size,this.weight);

  factory BookInfoModel.fromJson(Map<String, dynamic> json) => _$BookInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookInfoModelToJson(this);
}