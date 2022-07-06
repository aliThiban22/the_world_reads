import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_world_reads/main/store/store_item.dart';
import 'package:the_world_reads/main/store/store_item_plan.dart';
import 'package:toggle_bar/toggle_bar.dart';

import '../../Admin/app_data.dart';
import '../../find/test.dart';
import '../../network/api.dart';

class Store_Home extends StatefulWidget {
  @override
  _Store_HomeState createState() => _Store_HomeState();
}

class _Store_HomeState extends State<Store_Home> {
  final key_scaffold = GlobalKey<ScaffoldState>();

  List<String> labels = ["الرصيد العام", "القراءة", "الاستماع", "التأليف"];
  int currentIndex = 0;

  List<Store_Item_Plan> list_plan = new List.from([]);

  List<Store_Item> list_books = new List.from([]);

  // كل البيانات
  int max_num_pag = 0, max_num_book = 0, max_num_minute = 0;
  int max_num_pages_plan = 0,
      max_num_articles_plan = 0,
      max_num_search_plan = 0,
      max_num_books_plan = 0;

  // بيانات اليوم
  int max_num_read_day_pag = 0,
      max_num_read_day_book = 0,
      max_num_read_day_minute = 0,
      max_num_plan_day_pages = 0,
      max_num_plan_day_articles = 0,
      max_num_plan_day_search = 0,
      max_num_plan_day_books = 0;

  // بيانات الشهر
  int max_num_read_month_pag = 0,
      max_num_read_month_book = 0,
      max_num_read_month_minute = 0,
      max_num_plan_month_pages = 0,
      max_num_plan_month_articles = 0,
      max_num_plan_month_search = 0,
      max_num_plan_month_books = 0;

  // بيانات السنة
  int max_num_read_year_pag = 0,
      max_num_read_year_book = 0,
      max_num_read_year_minute = 0,
      max_num_plan_year_pages = 0,
      max_num_plan_year_articles = 0,
      max_num_plan_year_search = 0,
      max_num_plan_year_books = 0;

  var currDt = DateTime.now();
  var dd = DateTime.now();

  @override
  void initState() {
    super.initState();
    App_Data.getUserData();
    getData();
  }

  getData() async {
    list_books = await API.StoreBook_Get();
    list_plan = await API.StorePlan_Get();

    // القراءة و الاستماع
    for (int i = 0; i < list_books.length; i++) {
      // كل البيانات
      max_num_pag = max_num_pag + list_books[i].number_pages;
      max_num_book = max_num_book + list_books[i].number_book;
      max_num_minute = max_num_minute + list_books[i].number_minutes;
      dd = DateTime.parse(list_books[i].store_date);
      // بيانات اليوم
      if (currDt.day == dd.day) {
        max_num_read_day_pag =
            max_num_read_day_pag + list_books[i].number_pages;
        max_num_read_day_book =
            max_num_read_day_book + list_books[i].number_book;
        max_num_read_day_minute =
            max_num_read_day_minute + list_books[i].number_minutes;
      }
      // بيانات الشهر
      if (currDt.month == dd.month) {
        max_num_read_month_pag =
            max_num_read_month_pag + list_books[i].number_pages;
        max_num_read_month_book =
            max_num_read_month_book + list_books[i].number_book;
        max_num_read_month_minute =
            max_num_read_month_minute + list_books[i].number_minutes;
      }
      // بيانات السنة
      if (currDt.year == dd.year) {
        max_num_read_year_pag =
            max_num_read_year_pag + list_books[i].number_pages;
        max_num_read_year_book =
            max_num_read_year_book + list_books[i].number_book;
        max_num_read_year_minute =
            max_num_read_year_minute + list_books[i].number_minutes;
      }
    }

    // الخطة البحثية
    for (int i = 0; i < list_plan.length; i++) {
      max_num_pages_plan = max_num_pages_plan + list_plan[i].number_pages;
      max_num_articles_plan =
          max_num_articles_plan + list_plan[i].number_articles;
      max_num_search_plan = max_num_search_plan + list_plan[i].number_search;
      max_num_books_plan = max_num_books_plan + list_plan[i].number_books;
      dd = DateTime.parse(list_plan[i].store_date);
      // بيانات اليوم
      if (currDt.day == dd.day) {
        max_num_plan_day_pages =
            max_num_plan_day_pages + list_plan[i].number_pages;
        max_num_plan_day_articles =
            max_num_plan_day_articles + list_plan[i].number_articles;
        max_num_plan_day_search =
            max_num_plan_day_search + list_plan[i].number_search;
        max_num_plan_day_books =
            max_num_plan_day_books + list_plan[i].number_books;
      }
      // بيانات الشهر
      if (currDt.month == dd.month) {
        max_num_plan_month_pages =
            max_num_plan_month_pages + list_plan[i].number_pages;
        max_num_plan_month_articles =
            max_num_plan_month_articles + list_plan[i].number_articles;
        max_num_plan_month_search =
            max_num_plan_month_search + list_plan[i].number_search;
        max_num_plan_month_books =
            max_num_plan_month_books + list_plan[i].number_books;
      }
      // بيانات السنة
      if (currDt.year == dd.year) {
        max_num_plan_year_pages =
            max_num_plan_year_pages + list_plan[i].number_pages;
        max_num_plan_year_articles =
            max_num_plan_year_articles + list_plan[i].number_articles;
        max_num_plan_year_search =
            max_num_plan_year_search + list_plan[i].number_search;
        max_num_plan_year_books =
            max_num_plan_year_books + list_plan[i].number_books;
      }
    }

//    print(currDt.year); // 4
//    print(currDt.month); // 4
//    print(currDt.day); // 2
//    print(currDt.hour); // 15
//    print(currDt.minute); // 21
//    print(currDt.second); // 49

//    DateTime dd = DateTime.parse(list_plan[0].store_date);
//    if(dd.day == currDt.day){
//      print('ok');
//    }else{
//      print('no');
//      print(dd.day);
//
//    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ازاله البانر العلويه
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
          key: key_scaffold,
          body: Container(
              child: SingleChildScrollView(
                  child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                ToggleBar(
                  labels: labels,
                  backgroundColor: Colors.teal,
                  onSelectionUpdated: (index) =>
                      setState(() => currentIndex = index),
                ),
                get_select_tap(currentIndex),
              ],
            ),
          )))),
    );
  }

  get_select_tap(int index) {
    if (index == 0) {
      return getall();
    } else if (index == 1) {
      return getReads();
    } else if (index == 2) {
      return getLisen();
    } else if (index == 3) {
      return getPlan();
    }
  }

  //الرصيد العام
  Widget getall() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //القراءة
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'القراءة',
              style: TextStyle(fontSize: 18, color: Colors.teal),
              textDirection: TextDirection.rtl,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'images/img_news_a.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_pag',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('صفحة'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_book',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('كتاب'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
          Divider(),

          // الاستماع
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'الاستماع',
              style: TextStyle(fontSize: 18, color: Colors.teal),
              textDirection: TextDirection.rtl,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'images/img_news_b.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_minute',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('دقيقة'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '${(max_num_minute / 60).roundToDouble()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('ساعة'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
          Divider(),

          // البحث والتاليف
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'البحث والتاليف',
              style: TextStyle(fontSize: 18, color: Colors.teal),
              textDirection: TextDirection.rtl,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'images/img_news_c.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_pages_plan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('صفحة'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_articles_plan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('مقال'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_search_plan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('بحث'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.teal[100],
                                width: 100,
                                child: Text(
                                  '$max_num_books_plan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('كتاب'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  // القراءة
  Widget getReads() {
    return Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'images/asset_95.png',
              width: 50,
              height: 50,
            ),
            Text(
              '   رصيد القراءة   ',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),

      SizedBox(
        height: 40,
      ),

      //انجاز اليوم
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" يوم \n ${currDt.day} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_read_day_pag',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),

      Divider(
        height: 40,
      ),

      // انجاز الشهر
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" شـهر \n  ${currDt.month} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_read_month_pag',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${(max_num_read_month_book)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('كتاب'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),

      Divider(
        height: 40,
      ),

      // انجاز السنة
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" سنــة \n  ${currDt.year} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_read_year_pag',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_read_year_book',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('كتاب'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),

      Divider(
        height: 40,
      ),

      // منذ البداية
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text("منذ بداية التسجيل")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_pag',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${(max_num_book).roundToDouble()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('كتاب'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      )
    ]));
  }

  // الاستماع
  Widget getLisen() {
    return Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'images/img_news_b_b.png',
              width: 50,
              height: 50,
            ),
            Text(
              '    رصيد الاستماع  ',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),

      SizedBox(
        height: 40,
      ),

      //انجاز اليوم
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" انجاز \n  ${currDt.day} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${(max_num_read_day_minute).roundToDouble()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('دقيقة'),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),

      Divider(
        height: 40,
      ),

      // انجاز الشهر
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" شـهر \n  ${currDt.month} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_read_month_minute',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('دقيقة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${(max_num_read_month_minute / 60).roundToDouble()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('ساعة'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),

      Divider(
        height: 40,
      ),

      // انجاز السنة
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" سنــة \n  ${currDt.year} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_read_year_minute',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('دقيقة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${(max_num_read_year_minute / 60).roundToDouble()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('ساعة'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),

      Divider(
        height: 40,
      ),

      // منذ البداية
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text("منذ بداية التسجيل")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_minute',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('دقيقة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${(max_num_minute / 60).roundToDouble()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('ساعة'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      )
    ]));
  }

  // التاليف
  Widget getPlan() {
    return Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'images/img_news_b_d.png',
              width: 50,
              height: 50,
            ),
            Text(
              '    رصيد التاليف    ',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),

      SizedBox(
        height: 40,
      ),

      //انجاز اليوم
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" انجاز \n  ${currDt.day} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_day_pages}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_day_articles}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('مقال'),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),

      Divider(
        height: 40,
      ),

      // انجاز الشهر
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" شـهر \n  ${currDt.month} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_plan_month_pages',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_month_articles}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('مقال'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_month_search}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('بحث'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_month_books}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('كتاب'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),

      Divider(
        height: 40,
      ),

      // انجاز السنة
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text(" سنــة \n  ${currDt.year} ")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_plan_year_pages',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_year_articles}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('مقال'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_year_search}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('بحث'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_plan_year_books}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('كتاب'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),

      Divider(
        height: 40,
      ),

      // منذ البداية
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 40,
                  height: 40,
                  child: Center(child: Text("منذ بداية التسجيل")))),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_pages_plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('صفحة'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_articles_plan}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('مقال'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '${max_num_search_plan}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('بحث'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.teal[100],
                            width: 100,
                            child: Text(
                              '$max_num_books_plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('كتاب'),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      )
    ]));
  }
}
