import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/api.dart';
import 'kadamat_add.dart';
import 'kadamat_item.dart';
import 'kadamat_page.dart';

class Kadamat_List extends StatefulWidget {
  String title;
  int type;

  Kadamat_List(this.title, this.type);

  @override
  _Kadamat_ListState createState() => _Kadamat_ListState();
}

class _Kadamat_ListState extends State<Kadamat_List> {
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
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          widget.title,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => Kadamat_add()));
                          },
                          child: const Icon(
                            Icons.add_circle,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ))),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: book(),
            ),
          ),
        ));
  }

  Widget book() {
    return FutureBuilder(
        future: API.Kadamat_Get(widget.type),
        // async work
        builder: (BuildContext contextBook,
            AsyncSnapshot<List<Kadamat_Item>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: 190,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Kadamat_pags(snapshot.data[index])));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Text(
                                            snapshot.data[index].title,
                                            style:
                                                TextStyle(color: Colors.teal),
                                          )),
                                          Text(
                                            " ${snapshot.data[index].body}",
                                            maxLines: 3,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "تاريخ النشر : ${snapshot.data[index].time_post}",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                          Row(
                                            children: [
                                              Image.network(
                                                API.URL_IMG_USERS +
                                                    snapshot.data[index]
                                                        .user_items.img,
                                                width: 20,
                                                height: 20,
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                  return Image.network(
                                                    "http://storys.esy.es/images/users/reading.png",
                                                    width: 20,
                                                    height: 20,
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  snapshot.data[index]
                                                      .user_items.name,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.blueAccent)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Image.network(
                                        API.URL_IMG_KADAMAT +
                                            snapshot.data[index].img,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) => Divider(),
                );
              }
          }
        });
  }
}
