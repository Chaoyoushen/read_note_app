import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readnote/data/net/dio_util.dart';
import 'package:readnote/models/book_info_model.dart';
import 'package:readnote/ui/widget/loading_dialog.dart';
import 'package:readnote/utils/notice_util.dart';
import 'package:readnote/utils/utils.dart';




class SelectBookPage extends StatefulWidget {
  @override
  _SelectBookPageState createState() => _SelectBookPageState();
}

class _SelectBookPageState extends State<SelectBookPage> {
  List<BookInfoModel> list = null;
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
      onSubmitted: (key)=>buildResult(key),
      maxLines: 1,
      decoration: InputDecoration(
        icon: Icon(
            Icons.search,
            color: Color(0xFFAD9A87),
        ),
        focusedBorder: InputBorder.none,
        border:InputBorder.none,
      ),
    );
  }

  void buildResult(String key)async{
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '正在搜索...',
          );
        });
    list = await DioUtil.getBookByBookName(key);
    Navigator.pop(context);
    setState(() {

    });
  }

  _buildBody(){
    return _buildBookView(list);
  }

  Widget _buildBookView(List<BookInfoModel> list){
    if(list == null||list.length==0){
      return Center(
        child: Text(
            '抱歉没有查找到相关图书...',
          style: TextStyle(
            color: Colors.grey
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _itemBuilder(context, index, list),
    );
  }

  Widget _itemBuilder(BuildContext context, int index,List<BookInfoModel> list) {
    return GestureDetector(
        onTap: (){selectBook(list[index]);},
        child:Column(
          children: <Widget>[
            Container(
              height: 130,
              margin: EdgeInsets.all(10),
              child:Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: DioUtil.imagePath+list[index].photoUrl,
                    placeholder: (context, url) => Image.asset(Utils.getImgPath('default_book_image')),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                list[index].bookName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '作者：'+list[index].author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                          ]
                        ),
                        Text(
                          'ISBN号：'+list[index].isbn,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  )
                ],
              ),

            ),
            index == list.length-1 ? Container():Divider()
          ],
        )
    );

  }

  selectBook(BookInfoModel book){
    Navigator.pop(context,book);
  }

}

