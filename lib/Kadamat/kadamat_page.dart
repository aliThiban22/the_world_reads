import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/api.dart';
import 'kadamat_item.dart';

class Kadamat_pags extends StatefulWidget {
  Kadamat_Item _kadamat_item;

  Kadamat_pags(this._kadamat_item);

  @override
  _Kadamat_pagsState createState() => _Kadamat_pagsState();
}

class _Kadamat_pagsState extends State<Kadamat_pags> {
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
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "خدمات العالم يقرأ",
                      ),
                      flex: 9,
                    ),
                  ],
                ))),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: pag(),
          ),
        ),
      ),
    );
  }

  Widget pag() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(widget._kadamat_item.user_items.name,
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.network(
                  API.URL_IMG_USERS + widget._kadamat_item.user_items.img,
                  width: 50,
                  height: 50,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Image.network(
                      "http://storys.esy.es/images/users/reading.png",
                      width: 20,
                      height: 20,
                    );
                  },
                ),
              ],
            ),
            Divider(),
            Center(
              child: Text(
                widget._kadamat_item.title,
                style: TextStyle(color: Colors.teal, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.network(API.URL_IMG_KADAMAT + widget._kadamat_item.img,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
              return Image.network(
                  "http://storys.esy.es/images/users/reading.png",
                  width: 20,
                  height: 20);
            }),
            SizedBox(
              height: 20,
            ),
            Text(widget._kadamat_item.body),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  color: Color(0xFFC8E6C9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                            child:
                                Text("السعر : ${widget._kadamat_item.price}"))),
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(color: Colors.white),
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                                " الوقت المطلوب ${widget._kadamat_item.number_day}"))),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
