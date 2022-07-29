import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../Kadamat/kadamat_list.dart';
import '../../Media_Book/book_item.dart';
import '../../Media_Book/book_lists.dart';
import '../../banner/banner_item.dart';
import '../../network/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// تعريف ضغطة الماوس
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

@override
class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    getDataBanner();
  }

  List<Banner_Item> list_banner = new List.from([]);
  int number_list_banner = 1;
  List<String> images = ['img1.jpg'];

  // البيانات الخاصة بالبانر
  getDataBanner() async {
    list_banner = await API.Banner_Get();
    number_list_banner = list_banner.length;
    images.clear();
    for (int i = 0; i < list_banner.length; i++) {
      images.add(list_banner[i].imageLink);
      setState(() {});
    }
  }

  // الاتصال وجلب بيانات الكتب الرئيسية
//  getBookMain()async{
//    listMainBook = await API.Book_Get_MainActivity();
//    setState(() {});
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false, // ازاله البانر العلويه
        home: Scaffold(
            body: Container(
          margin: MediaQuery.of(context).padding,
          child: SingleChildScrollView(
              child: Container(
            child: Column(children: [
              banner(),
              Divider(),

//              Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: GestureDetector(
//                  onTap: () {}, // Image tapped
//                  child: Image.asset(
//                    'images/img_home_main_a.png',
//                    width: 200.0,
//                    height: 110.0,
//                  ),
//                ),
//              ),

              SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'الخدمات',
                  style: TextStyle(fontSize: 20, color: Colors.teal),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  height: 130,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (conx, index) {
                      return getKadamats(index);
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
              ),

              Divider(),
              book(),
            ]),
          )),
        )));
  }

  // جلب بيانات الكتب
  Widget book() {
    return FutureBuilder(
      future: API.Book_Get_MainActivity(), // async work
      builder:
          (BuildContext contextBook, AsyncSnapshot<List<Book_Item>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
//                            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
//              print(snapshot.error);
              return  book();

//              return Text('Error: لا يوجد اتصال بالانترنت');
            } else {

              List<Book_Item> listMainBook = List.from([]),
                  listA = new List.from([]),
                  listB = new List.from([]),
                  listC = new List.from([]),
                  listD = new List.from([]),
                  listE = new List.from([]);

              for (int i = 0; i < snapshot.data.length; i++) {
                if (snapshot.data[i].name_list_main.compareTo("خلاصة العلم") ==
                    0) {
                  listA.add(snapshot.data[i]);
                }
              }
//
              for (int i = 0; i < snapshot.data.length; i++) {
                if (snapshot.data[i].name_list_main
                        .compareTo("الموجز في العلوم") ==
                    0) {
                  listB.add(snapshot.data[i]);
                }
              }

              for (int i = 0; i < snapshot.data.length; i++) {
                if (snapshot.data[i].name_list_main
                        .compareTo("المنتخب من كتب الادب") ==
                    0) {
                  listC.add(snapshot.data[i]);
                }
              }
              for (int i = 0; i < snapshot.data.length; i++) {
                if (snapshot.data[i].name_list_main
                        .compareTo("المستعذب من كتب") ==
                    0) {
                  listD.add(snapshot.data[i]);
                }
              }
              for (int i = 0; i < snapshot.data.length; i++) {
                if (snapshot.data[i].name_list_main
                        .compareTo("المستعذب من كتب") ==
                    0) {
                  listE.add(snapshot.data[i]);
                }
              }

//              return Text('ff');
//              print(snapshot.data.length);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Book_Lists('خلاصة العلم')));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'images/back_item_home_pag_a.png',
                                width: 50.0,
                                height: 50.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('خلاصة العلم'),
                              ),
                            ],
                          )),
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: listA.length,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (conx, index) {
                            return Book_Item.bookItemWidget(
                                listA[index], context);
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Book_Lists('الموجز في العلوم')));

                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'images/img_esdarat_b.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('الموجز في العلوم'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(50.0),
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: listB.length,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Book_Item.bookItemWidget(
                                listB[index], context);
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Book_Lists('المنتخب من كتب الادب')));

                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'images/img_esdarat_d.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('المنتخب من كتب الادب'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(50.0),
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: listC.length,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Book_Item.bookItemWidget(
                                listC[index], context);
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Book_Lists('المستعذب من كتب الادب')));

                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'images/img_esdarat_a.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('المستعذب من كتب الادب'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(50.0),
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: listD.length,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Book_Item.bookItemWidget(
                                listD[index], context);
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Book_Lists('الخلاصة الثقافية')));

                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'images/back_item_home_pag_ff.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('الخلاصة الثقافية'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(50.0),
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: listE.length,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Book_Item.bookItemWidget(
                                listE[index], context);
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                    ],
                  ),
                )),
              );
            }
        }
      },
    );
  }

  // البانر
  Widget banner() {
    return CarouselSlider.builder(
      itemCount: number_list_banner,
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        initialPage: 0,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
//                                  onPageChanged: callbackFunction,

        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        return Image.network(
          '${API.URL_POST_BANNER}${images[index]}',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        );
      },
    );
  }

  // الخدمات
  Widget getKadamats(int index) {
    List<String> img = [
      "images/img_home_ff_a.png",
      "images/img_home_ff_b.png",
      "images/img_home_ff_c.png",
      "images/img_home_ff_d.png",
      "images/img_home_ff_e.png",
      "images/img_home_ff_f.png",
      "images/img_home_ff_g.png",
      "images/img_home_ff_h.png",
      "images/img_home_ff_i.png",
      "images/img_home_ff_j.png",
      "images/img_home_ff_k.png",
      "images/img_home_ff_l.png"
    ];

    List<String> title = [
      "خدمات القراءة والاستماع",
      "خدمات البحث العلمي",
      "خدمات الكتابة والتحرير والترجمة",
      "خدمات التصميم والمنتاج",
      "خدمات الترجمة والتطبيقات والمواقع",
      "خدمات الفنون",
      "خدمات الاعلان والنشر والتسويق",
      "الخدمات القانونية",
      "خدمات الوظائف التعليمية",
      "خدمات الاستشارات والدراسات",
      "خدمات التدريب والتعليم عن بعد",
      "اخرئ"
    ];

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Kadamat_List(title[index], index + 1)));
      },
      child: Container(
          margin: const EdgeInsets.all(5.0),
//          padding: const EdgeInsets.all(5.0),
          width: 130,
          height: 130,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Column(
//            mainAxisAlignment:MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      child: Image.asset(
                        "${img[index]}",
//                        fit: BoxFit.fill,
//                        height: double.infinity,
//                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Text(
                        title[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.teal, fontSize: 13),
                      )),
                    ))
              ],
            ),
          )),
    );
  }
}
