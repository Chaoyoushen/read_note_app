


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/image_result.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';

class CameraUtil{

  static addNoteByPhoto(BuildContext context) async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if(_imageFile == null) return null;
    File file = await _cropImage(_imageFile);
    if(file == null){
      return null;
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在解析图片...',
          );
        });
    var _path = await Luban.compressImage(
      CompressObject(
        imageFile: _imageFile,
        path: _imageFile.path.substring(0,_imageFile.path.lastIndexOf('/')),
        step: 9,
        mode: CompressMode.LARGE2SMALL
      )
    );
    var data = base64.encode(File(_path).readAsBytesSync());
    ImageResult result = await DioUtil.getMessage(data);
    StringBuffer text = new StringBuffer();
    for (Map map in result.words_result) {
      text.writeln(map['words']);
    }
    Navigator.pop(context);
    return text.toString();
  }

  static addNoteByGallery(BuildContext context) async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(_imageFile == null) return null;
    File file = await _cropImage(_imageFile);
    Directory tmpPath = await getTemporaryDirectory();
    print(tmpPath.path);
    if(file == null) return null;
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在解析图片...',
          );
        }
    );
    var _path = await Luban.compressImage(
      CompressObject(
        imageFile: file,
        path:tmpPath.path,
        step: 9,
        mode: CompressMode.LARGE2SMALL
      )
    );
    print(_path);
    var data = base64.encode(File(_path).readAsBytesSync());
    ImageResult result = await DioUtil.getMessage(data);
    StringBuffer text = new StringBuffer();
    for (Map map in result.words_result) {
      text.writeln(map['words']);
    }
    Navigator.pop(context);
    return text.toString();
  }

static Future<File> _cropImage(File imageFile){
    return ImageCropper.cropImage(
      sourcePath: imageFile.path,
      toolbarTitle:'裁剪图片'
    );
  }

}