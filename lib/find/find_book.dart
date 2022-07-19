import 'dart:ui';

import 'package:flutter/material.dart';

import '../Media_Book/book_item.dart';
import '../network/api.dart';

class Find_Book extends StatefulWidget {
  @override
  _Find_BookState createState() => _Find_BookState();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class _Find_BookState extends State<Find_Book> {
  var _controller = TextEditingController();
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
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
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text("البحث"),
                    ),
                  ],
                ))),

          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      height: 100,
                      child: TextField(
                      onSubmitted : (_) => setState((){}) ,
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      maxLength: 60,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (text) {
                          inputText = text;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "اكتب جملة البحث",
                          prefixIcon: IconButton(icon: Icon(Icons.search)),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                              splashColor: Colors.redAccent,
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  inputText = "";
                                });
                              })
                      ),
                      ),
                    ),

                    Container(
                        height: 1000,
                        child: book()),


                  ],
                ),
              ),
              ),
            ),
          ),
      );
  }



  // Widget hidingIcon() {
  //   if (inputText.length > 0) {
  //     return IconButton(
  //         icon: Icon(
  //           Icons.clear,
  //           color: Colors.red,
  //         ),
  //         splashColor: Colors.redAccent,
  //         onPressed: () {
  //           setState(() {
  //             _controller.clear();
  //             inputText = "";
  //           });
  //         });
  //   } else {
  //     return null;
  //   }
  // }

  Widget book() {
    return FutureBuilder(
      future: API.Book_Find(inputText), // async work
      builder:
          (BuildContext contextBook, AsyncSnapshot<List<Book_Item>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      Book_Item.bookItemWidget(snapshot.data[index], context),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                ),
              );
            }
        }
      },
    );
  }

  getDataBook(){

  }
}
