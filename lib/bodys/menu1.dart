import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prodictproj/models/book_model.dart';
import 'package:prodictproj/states/show_detail.dart';
import 'package:prodictproj/utility/my_constant.dart';

class Menu1 extends StatefulWidget {
  const Menu1({Key? key}) : super(key: key);

  @override
  _Menu1State createState() => _Menu1State();
}

class _Menu1State extends State<Menu1> {
  List<BookModel> bookModels = [];
  List<BookModel> searchBookModels = [];
  final debouncer = Debouncer(millisceond: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllData();
  }

  Future<Null> readAllData() async {
    String apiReadAllData =
        '${MyConstant.domain}/gtw/assets/hn_book.php?isAdd=true';
    await Dio().get(apiReadAllData).then((value) {
      print('## value form ReadAllData ==> $value');
      for (var item in json.decode(value.data)) {
        BookModel model = BookModel.fromMap(item);
        print('### bookName ==> ${model.BOOK_NAME}');
        setState(() {
          bookModels.add(model);
          searchBookModels = bookModels;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: bookModels.length == 0
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  buildSearch(),
                  buidlListView(),
                ],
              ),
            ),
    );
  }

  Container buildSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        onChanged: (value) {
          debouncer.run(() {
            setState(() {
              searchBookModels = bookModels
                  .where((element) => element.BOOK_NAME
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  ListView buidlListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: searchBookModels.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowDetail(bookModel: searchBookModels[index],),
            )),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(searchBookModels[index].BOOK_NAME),
        )),
      ),
    );
  }
}

class Debouncer {
  final int millisceond;
  Timer? timer;
  VoidCallback? callback;

  Debouncer({required this.millisceond});

  run(VoidCallback callback) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: millisceond), callback);
  }
}
