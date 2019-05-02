// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookInfoModel _$BookInfoModelFromJson(Map<String, dynamic> json) {
  return BookInfoModel(
      json['isbn'] as String,
      json['bookName'] as String,
      json['author'] as String,
      json['asin'] as String,
      json['brand'] as String,
      json['id'] as String,
      json['pages'] as String,
      json['bookId'] as String,
      json['photoUrl'] as String,
      json['price'] as String,
      json['publishing'] as String,
      json['size'] as String,
      json['weight'] as String);
}

Map<String, dynamic> _$BookInfoModelToJson(BookInfoModel instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'bookName': instance.bookName,
      'author': instance.author,
      'publishing': instance.publishing,
      'asin': instance.asin,
      'brand': instance.brand,
      'weight': instance.weight,
      'size': instance.size,
      'pages': instance.pages,
      'price': instance.price,
      'photoUrl': instance.photoUrl,
      'id': instance.id,
      'bookId': instance.bookId
    };
