import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../network/api.dart';
import 'book_item.dart';

class Book_Lists extends StatefulWidget {
  String title;

  Book_Lists(this.title);

  @override
  _Book_ListsState createState() => _Book_ListsState();
}

class _Book_ListsState extends State<Book_Lists> {
  void initState() {
    super.initState();
    getTheMat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // ازاله البانر العلويه
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PopupMenuButton(
                            iconSize: 40,
                            itemBuilder: (BuildContext con) {
                              return [
                                PopupMenuItem(
                                    child: const Text('تصفية الكتب حسب الاحدث'),
                                    onTap: () {}),
                                PopupMenuItem(
                                    child:
                                        const Text('تصفية الكتب حسب الاكثر مشاهدة'),
                                    onTap: () {})
                              ];
                            }),
                      )

//                      Expanded(
//                        child: InkWell(
//                            onTap: () {
//                              /////////------
//                            },
//                            child: Icon(
//                              Icons.more_vert,
//                              size: 40,
//                              color: Colors.white,
//                            )),
//                        flex: 1,
//                      ),
                    ],
                  ))),
          body: Container(
            child: book(),
          ),
        ));
  }

  // جلب بيانات الكتب
  Widget book() {
    return FutureBuilder(
      future: API.Book_Lists(widget.title), // async work
      builder:
          (BuildContext contextBook, AsyncSnapshot<List<Book_Item>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              print(snapshot.error);
              return book();
//              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      Book_Item.bookItemWidget(snapshot.data[index], context),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getTheMat(),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 300
                  ),
                ),
              );
            }
        }
      },
    );
  }

  // لمعرفة اذا كان التبيق ايفون او اندرويد
  int getTheMat() {
    var platformName = '';
    var platformNumber = 0;
    if (kIsWeb) {
      platformName = "Web";
      platformNumber = 5;
    } else {
      if (Platform.isAndroid) {
        platformName = "Android";
      } else if (Platform.isIOS) {
        platformName = "IOS";
      } else if (Platform.isFuchsia) {
        platformName = "Fuchsia";
      } else if (Platform.isLinux) {
        platformName = "Linux";
      } else if (Platform.isMacOS) {
        platformName = "MacOS";
      } else if (Platform.isWindows) {
        platformName = "Windows";
      }
      platformNumber = 2;
    }
//    print("platformName :- "+platformName.toString());
    return platformNumber;
  }
}
