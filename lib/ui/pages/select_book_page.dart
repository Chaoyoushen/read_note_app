import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';




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
                IconData(0xe689,fontFamily: 'iconfont'),
                color: Color(0xFFAD9A87),
              ),
              onPressed: (){Utils.scanBookInfo(context);}
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

}

