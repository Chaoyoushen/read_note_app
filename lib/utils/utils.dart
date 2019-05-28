

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';

class Utils {

  static String getImgPath(String name, {String format: 'jpg'}) {
    return 'assets/images/$name.$format';
  }
  
  static Future scanBookInfo(BuildContext context) async {
    String barcode = await BarcodeScanner.scan();
    //String barcode = '9787534155550';
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在解析ISBN...',
          );
        });
    BookInfoModel book = await DioUtil.getBookByIsbn(barcode);
    Navigator.pop(context);
    print(book);
    if(book == null){
      return NoticeUtil.buildToast("no such book,try use name");
    }else{
      Navigator.pop(context,book);
    }
  }

  static String getCurrentTime(String stamp){
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(int.parse(stamp));
    return date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString();

  }


}