import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class EditPhotoModel extends Model{
  File _photo;
  get photo => _photo;

  void importPhoto(File photo) async{
    _photo = photo;
    notifyListeners();

  }
}