import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/utils/notice_util.dart';




class SelectBookPage extends StatefulWidget {
  @override
  _SelectBookPageState createState() => _SelectBookPageState();
}

class _SelectBookPageState extends State<SelectBookPage> {

  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
            ),
            onPressed:(){
              Navigator.pop(context);
            }
        ),
        title: _buildTextField(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                IconData(0xe6b9,fontFamily: 'iconfont'),
                color: Color(0xFFAD9A87),
              ),
              onPressed: (){_buildScanButton();}
          )
        ],
      ),
      body: _buildBody()


    );
  }


  _buildTextField(){
    return TextField(
      cursorColor: Color(0xFFAD9A87),
      controller: _controller,
      decoration: InputDecoration(
        icon: Icon(
            Icons.search,
            color: Color(0xFFAD9A87),
        ),
        focusedBorder: InputBorder.none,
        border:InputBorder.none
      ),
    );
  }

  _buildBody(){
    return ListView();
  }

  _buildScanButton()async{
    //String barcode = await BarcodeScanner.scan();
    String barcode = '9787534155550';
    print(barcode);
    BookInfoModel book = await DioUtil.getBookByIsbn(barcode);
    print(book);
    if(book == null){
      return NoticeUtil.buildToast("no such book,try use name");
    }else{
      Navigator.pop(context,book);
    }
  }
}

