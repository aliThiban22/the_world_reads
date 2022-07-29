import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_world_reads/main/today/plan/plan_data.dart';
import 'package:the_world_reads/main/today/plan/plan_item_data.dart';
import 'package:the_world_reads/main/today/plan/plan_item_year.dart';
import 'package:the_world_reads/main/today/reads_listens/goal_item.dart';
import 'package:the_world_reads/main/today/reads_listens/listen_item.dart';
import 'package:the_world_reads/main/today/reads_listens/read_and_listen_item.dart';
import 'package:the_world_reads/main/today/reads_listens/read_item.dart';
import 'package:toggle_bar/toggle_bar.dart';

import '../../Admin/app_data.dart';
import '../../find/find_book.dart';
import '../../network/api.dart';
import '../../pay/pay_bag.dart';
import '../../pay/pay_item.dart';
import '../../users/user_data.dart';

class Today_Home extends StatefulWidget {
  @override
  _Today_HomeState createState() => _Today_HomeState();
}

class _Today_HomeState extends State<Today_Home> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  final key_form_read_year = GlobalKey<FormState>();
  final key_form_read_book = GlobalKey<FormState>();

  List<String> labels = ["القراءة والاستماع", "البحث والتاليف", "مكتبتي"];
  List<String> labels2 = ["القراءة", "الاستماع", "التأليف", "المفضلة"];
  int currentIndex = 0;
  int currentIndex2 = 0;

  var currDt = DateTime.now();
  Plan_item_year _plan_item_year;

  Goal_item _goal_item;

  // بيانات السنة للبحث والتاليف
  double plan_year_number_hour = 0,
      plan_year_number_article = 0,
      plan_year_number_search = 0,
      plan_year_number_book = 0;

  int plan_year_number_hour_done = 0,
      plan_year_number_article_done = 0,
      plan_year_number_search_done = 0,
      plan_year_number_book_done = 0;

  // بيانات السنة للقراءة والاستماع
  int number_book_year = 0, number_song_year = 0;

  int number_book_year_done = 0, number_song_year_done = 0;

  double number_book_month = 0, number_song_month = 0;

  @override
  void initState() {
    super.initState();
    App_Data.getUserData();
    get_data_numbers();
  }

  //img
  String getStrings_img(int type) {
    String txt = '';
    if (type == 1) {
      txt = 'images/img_reads.png';
    } else {
      txt = 'images/img_listen.png';
    }
    return txt;
  }

  //اسم عدد الصفحات
  String getStrings_num_pags(int type) {
    String txt = '';
    if (type == 1) {
      txt = 'عدد صفحات الكتاب';
    } else {
      txt = 'مدة البرنامج';
    }
    return txt;
  }

  //اسم مكان الوقوف
  String getStrings_num_stop(int type) {
    String txt = '';
    if (type == 1) {
      txt = 'صفحة الوقوف';
    } else {
      txt = 'دقيقة الوقوف';
    }
    return txt;
  }

  //اسم العدد المتبقي
  String getStrings_num_pag_end(int type) {
    String txt = '';
    if (type == 1) {
      txt = 'الصفحات المتبقية';
    } else {
      txt = 'المدة المتبقية';
    }
    return txt;
  }

  //حساب مدة البرنامج او عدد الصفحات
  String getNumber_pags_or_listn(int type, int number) {
    if (type == 1) {
      return "$number";
    } else {
      int tm_hour = number ~/ 60;
      int tm_minute = number % 60;
      return "$tm_hour:$tm_minute";
    }
  }

  int getType_plan(String type) {
    if (type.compareTo("كتاب") == 0) {
      return 1;
    } else if (type.compareTo("بحث") == 0) {
      return 2;
    } else if (type.compareTo("مقال") == 0) {
      return 3;
    } else if (type.compareTo("أخرئ") == 0) {
      return 4;
    }
  }

  // جلب بيانات القاعدة
  get_data_numbers() async {
    _plan_item_year = await API.Plan_Year_Get();
    _goal_item = await API.GoalYearBook_Get(); // لازم تخليه يعرف اذا نجحج او لا وتسند المتغيرات الي تحت له

    number_book_year_done = _goal_item.number_book_year_done;
    number_song_year_done = _goal_item.number_song_year_done;
    number_book_year =
        _goal_item.number_book_year - _goal_item.number_book_year_done;
    number_song_year =
        _goal_item.number_song_year - _goal_item.number_song_year_done;
    number_book_month = setPlanYearNumbers(
        _goal_item.number_book_year - _goal_item.number_book_year_done);
    number_song_month = setPlanYearNumbers(
        _goal_item.number_song_year - _goal_item.number_song_year_done);

    plan_year_number_hour = setPlanYearNumbers(
        _plan_item_year.number_hour - _plan_item_year.number_hour_done);
    plan_year_number_hour_done = _plan_item_year.number_hour;

    plan_year_number_article = setPlanYearNumbers(
        _plan_item_year.number_article - _plan_item_year.number_article_done);
    plan_year_number_article_done = _plan_item_year.number_article;

    plan_year_number_search = setPlanYearNumbers(
        _plan_item_year.number_search - _plan_item_year.number_search_done);
    plan_year_number_search_done = _plan_item_year.number_search;

    plan_year_number_book = setPlanYearNumbers(
        _plan_item_year.number_book - _plan_item_year.number_book_done);
    plan_year_number_book_done = _plan_item_year.number_book;

    setState(() {});
  }

  // تعديل بيانات الخطة السنوية للشهر
  double setPlanYearNumbers(int number) {
    int a = 12 - currDt.month;
    return double.parse((number / a).toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ازاله البانر العلويه
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
          key: key_scaffold,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
          height: (MediaQuery.of(context).size.height),
          child: Column(
            children: [
              ToggleBar(
                  labels: labels,
                  backgroundColor: Colors.teal,
                  onSelectionUpdated: (index) =>
                      setState(() => currentIndex = index),
                ),

              Expanded(flex: 1, child: get_select_tap(currentIndex)),
            ],
          ),
            ),
          )),
    );
  }

  // الموزع للصفحات
  get_select_tap(int index) {
    if (index == 0) {
      return getReads();
    } else if (index == 1) {
      return getPlan();
    } else if (index == 2) {
      return getMy_mktbah();
    }
  }

  // القراءة والاستماع
  Widget getReads() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 40,
        width: (MediaQuery.of(context).size.width),
        color: Colors.teal,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    payStart(context, 2);
                  },
                  child: const Center(
                    child: Text(
                      "تسجيل بيانات كتاب",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            const SizedBox(
              height: 30,
              child: VerticalDivider(color: Colors.white),
            ),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    payStart(context, 3);
                  },
                  child: const Center(
                    child: Text(
                      "تسجيل بيانات برنامج",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.teal,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  ' هدف سنة ${currDt.year}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                              child: VerticalDivider(color: Colors.white),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  ' كتاب ${number_book_year}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                              child: VerticalDivider(color: Colors.white),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(' برنامج $number_song_year',
                                    style: const TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                        const Divider(color: Colors.white),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  ' هدف شهر ${currDt.month}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                              child: VerticalDivider(color: Colors.white),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  ' كتاب ${number_book_month}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                              child: const VerticalDivider(color: Colors.white),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(' برنامج $number_song_month',
                                    style: const TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                        const Divider(color: Colors.white),
                        ElevatedButton(
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.teal),
                              // الظل
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(5)),
                              // الهامش
                              minimumSize: MaterialStateProperty.all(
                                  const Size(250, 40)),
                              //ألطول والعرض

                              // حواف مائلة
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              payStart(context, 1);

                            },
                            child: const Text("تسجيل اهداف سنة جديدة",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 18))),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  SizedBox(
                    // height: 1000,
                    child: FutureBuilder(
                      future: API.Reads_Get(), // async work
                      builder: (BuildContext contextBook,
                          AsyncSnapshot<List<Read_item>> snapshot_reads) {
                        switch (snapshot_reads.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot_reads.hasError) {
//                              print(snapshot_reads.error);
                              return  getReads();
//                              return Text('Error: ${snapshot_reads.error}');
                            } else {
                              return FutureBuilder(
                                future: API.Listen_Get(), // async work
                                builder: (BuildContext contextBook,
                                    AsyncSnapshot<List<Listen_Item>>
                                        snapshot_listns) {
                                  switch (snapshot_listns.connectionState) {
                                    case ConnectionState.waiting:
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    default:
                                      if (snapshot_listns.hasError) {
                                        print(snapshot_listns.error);
                                        return  getReads();

//                                        return Text(
//                                            'Error: ${snapshot_listns.error}');
                                      } else {
//                                        print(snapshot_listns.data[0].title);

                                        List<Read_And_Listen_item> list_all =
                                            new List.from([]);

                                        // دوارة الكتب
                                        for (int i = 0;
                                            i < snapshot_reads.data.length;
                                            i++) {
                                          Read_And_Listen_item item_all =
                                              new Read_And_Listen_item();
                                          item_all.id =
                                              snapshot_reads.data[i].id;
                                          item_all.title =
                                              snapshot_reads.data[i].title;
                                          item_all.day =
                                              snapshot_reads.data[i].start_date;
                                          item_all.number_pages = snapshot_reads
                                              .data[i].number_pages;
                                          item_all.number_stop = snapshot_reads
                                              .data[i].number_pages_end;
                                          item_all.number_end = snapshot_reads
                                                  .data[i].number_pages -
                                              snapshot_reads
                                                  .data[i].number_pages_end;
                                          item_all.number_days = DateTime.now()
                                              .difference(DateTime.parse(
                                                  snapshot_reads
                                                      .data[i].start_date))
                                              .inDays;
                                          item_all.is_done =
                                              snapshot_reads.data[i].done;
                                          item_all.type = 1;

                                          list_all.add(item_all);
                                        }

                                        // دوارة الصوتيات
                                        for (int i = 0;
                                            i < snapshot_listns.data.length;
                                            i++) {
                                          Read_And_Listen_item item_all =
                                              new Read_And_Listen_item();
                                          item_all.id = snapshot_listns.data[i].id;
                                          item_all.title = snapshot_listns.data[i].title;
                                          item_all.day = snapshot_listns.data[i].start_date;
                                          item_all.number_pages = snapshot_listns.data[i].time_video;
                                          item_all.number_stop = snapshot_listns.data[i].time_end;
                                          item_all.number_end = snapshot_listns.data[i].time_video -
                                              snapshot_listns.data[i].time_end;
                                          item_all.number_days = DateTime.now().difference(DateTime.parse(
                                                  snapshot_listns.data[i].start_date)).inDays;
                                          item_all.is_done = snapshot_listns.data[i].done;
                                          item_all.type = 2;

                                          list_all.add(item_all);
                                        }

                                        return Container(
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: list_all.length,
                                            itemBuilder: (conx, index) {
                                              return Container(
                                                  margin:
                                                      const EdgeInsets.all(5.0),
                                                  height: 250,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    elevation: 10,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  Image.asset(
                                                                '${getStrings_img(list_all[index].type)}',
                                                                width: 40,
                                                                height: 40,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${list_all[index].title}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .teal,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: PopupMenuButton(
                                                                iconSize: 25,
                                                                itemBuilder: (BuildContext con) {
                                                                  return [
                                                                    PopupMenuItem(
                                                                        child: Text('تعديل'),
                                                                        onTap: () {
                                                                          if(list_all[index].type == 1){
                                                                            // قراءة
                                                                            updata_reads(snapshot_reads.data[index]);

                                                                          }else{
                                                                            // استماع
                                                                            updata_listn(snapshot_listns.data[
                                                                              index - snapshot_reads.data.length]);


                                                                          }
                                                                        }),
                                                                    PopupMenuItem(
                                                                        child: Text('حذف'),
                                                                        onTap: () {
                                                                          if(list_all[index].type == 1){
                                                                            // قراءة
                                                                            delete_reads(list_all[index].id);

                                                                          }else{
                                                                            // استماع
                                                                            delete_listn(list_all[index].id);


                                                                          }

                                                                        })
                                                                  ];
                                                                }),

                                              ),
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                          flex: 2,
                                                                          child: DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Color(0xFFF9FBE7),
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(0),
                                                                                  topRight: Radius.circular(5),
                                                                                  bottomLeft: Radius.circular(0),
                                                                                  bottomRight: Radius.circular(5),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${getStrings_num_pags(list_all[index].type)}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Colors.teal,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(5),
                                                                                  topRight: Radius.circular(0),
                                                                                  bottomLeft: Radius.circular(5),
                                                                                  bottomRight: Radius.circular(0),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                //مدة البرنامج او عد دالصفحات
                                                                                '${getNumber_pags_or_listn(list_all[index].type, list_all[index].number_pages)}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Color(0xFFF9FBE7),
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(0),
                                                                                  topRight: Radius.circular(5),
                                                                                  bottomLeft: Radius.circular(0),
                                                                                  bottomRight: Radius.circular(5),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${getStrings_num_stop(list_all[index].type)}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Colors.teal,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(5),
                                                                                  topRight: Radius.circular(0),
                                                                                  bottomLeft: Radius.circular(5),
                                                                                  bottomRight: Radius.circular(0),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${getNumber_pags_or_listn(list_all[index].type, list_all[index].number_stop)}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      const Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: BoxDecoration(
                                                                                color: Color(0xFFF9FBE7),
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(0),
                                                                                  topRight: Radius.circular(5),
                                                                                  bottomLeft: Radius.circular(0),
                                                                                  bottomRight: Radius.circular(5),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'عدد ايام الانجاز :',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Colors.teal,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(5),
                                                                                  topRight: Radius.circular(0),
                                                                                  bottomLeft: Radius.circular(5),
                                                                                  bottomRight: Radius.circular(0),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${list_all[index].number_days}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Color(0xFFF9FBE7),
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(0),
                                                                                  topRight: Radius.circular(5),
                                                                                  bottomLeft: Radius.circular(0),
                                                                                  bottomRight: Radius.circular(5),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${getStrings_num_pag_end(list_all[index].type)}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration: const BoxDecoration(
                                                                                color: Colors.teal,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(5),
                                                                                  topRight: Radius.circular(0),
                                                                                  bottomLeft: Radius.circular(5),
                                                                                  bottomRight: Radius.circular(0),
                                                                                )),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${getNumber_pags_or_listn(list_all[index].type, list_all[index].number_end)}',
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'تاريخ البدء : ${list_all[index].day} ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              maxLines: 1,
                                                              style: const TextStyle(
                                                                  fontSize: 13),
                                                            ))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: InkWell(
                                                              onTap: () {
                                                                upData_done_Read_Listn(
                                                                    list_all[
                                                                        index]);
                                                              },
                                                              child:
                                                                  const DecoratedBox(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .teal,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(0),
                                                                          topRight:
                                                                              Radius.circular(0),
                                                                          bottomLeft:
                                                                              Radius.circular(10),
                                                                          bottomRight:
                                                                              Radius.circular(10),
                                                                        )),
                                                                child: const Center(
                                                                  child: Text(
                                                                    'تسجيل انجاز',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ));
                                            },
                                            separatorBuilder:
                                                (context, index) => const Divider(),
                                          ),
                                        );
                                      }
                                  }
                                },
                              );
                            }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // تعديل او اضافة سنة جديدة للقراءة و الاستماع
  addNew_year_data() {
    showDialog(
        context: context,
        builder: (BuildContext conte) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(const Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Form(
                key: key_form_read_year,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text("تسجيل الاهداف للعام : ${currDt.year}"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue:
                                        "${number_book_year + number_book_year_done}",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length == 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        number_book_year = int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد الكتب ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue:
                                        "${number_song_year + number_song_year_done}",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        number_song_year = int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد البرامج ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        if (key_form_read_year.currentState.validate()) {
                          // الاتصال وحفظ البيانات للسنة
                          if (_goal_item == null ||
                              _goal_item.number_book_year == 0) {
                            // الاضافة الجديدة
                            API.GoalYearBook_Add(number_book_year,
                                    number_song_year, "${currDt.year}")
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                                Navigator.pop(conte);
                                get_data_numbers();
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });
                          } else {
                            // التعديل
                            API.GoalYearBook_Updata(
                                    _goal_item.id,
                                    number_book_year,
                                    number_song_year,
                                    number_book_year_done,
                                    number_song_year_done,
                                    currDt.year)
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: const Text("تم الحفظ "),
                                ));
                                Navigator.pop(conte);
                                get_data_numbers();
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية ،، اضف قيم جديدة',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF33b17c),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "حـفـظ",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // اضافة بيانات كتاب جديدة
  addNew_Data_Book() {
    showDialog(
        context: context,
        builder: (BuildContext conte) {
          String ed_read_start_date = "0000-00-00",
              title_book = "",
              writer_name = "",
              library_name = "";
          int number_pages = 0;

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                width: 400.0,
                child: SingleChildScrollView(
                  child: Form(
                    key: key_form_read_book,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          const Center(
                            child: Text(
                              "تسجيل بيانات كتاب",
                              style: const TextStyle(fontSize: 20, color: Colors.teal),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$title_book",
                              decoration: const InputDecoration(
                                labelText: 'عنوان الكتاب :',
                                labelStyle: const TextStyle(color: Color(0xFF33b17c)),
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب تحديد عنوان صحيح للكتاب';
                                } else {
                                  title_book = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => title_book = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$writer_name",
                              decoration: const InputDecoration(
                                labelText: 'اسم المؤلف :',
                                labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                border: OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب تحديد اسم صحيح للمؤلف';
                                } else {
                                  writer_name = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => writer_name = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$library_name",
                              decoration: const InputDecoration(
                                labelText: 'دار النشر :',
                                labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                border: OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب كتابة دار النشر بشكل صحيح';
                                } else {
                                  library_name = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => library_name = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                inputFormatters: [
                                  //هذا عشان ما يكتب الا رقم بس
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'عدد الصفحات :',
                                  labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF33b17c))),
                                ),
                                validator: (value) {
                                  if (value.length < 1) {
                                    return 'يجب ادخال عدد الصفحات !';
                                  } else {
                                    number_pages = int.parse(value);
                                    return null;
                                  }
                                },
                                maxLength: 7,
                                onSaved: (value) => setState(
                                    () => number_pages = int.parse(value))),
                          ),
                          const Divider(),
                          InkWell(
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));
                                ed_read_start_date =
                                    "${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}";

                                if (pickedDate != null) {
                                  setState(() {
                                    ed_read_start_date;
                                  });

//                            print("${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}");

                                } else {
                                  print("Date is not selected");
                                }
                              },
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF9FBE7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      ' حدد تاريخ البدء \n $ed_read_start_date',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () {
                              if (key_form_read_book.currentState.validate()) {
                                // الاتصال وحفظ البيانات للسنة
//                            if(_goal_item == null || _goal_item.number_book_year == 0 ){// الاضافة الجديدة
                                API.Reads_Add(
                                        title_book,
                                        writer_name,
                                        library_name,
                                        number_pages,
                                        ed_read_start_date)
                                    .then((user) {
                                  if (user.id != 0) {
                                    key_scaffold.currentState
                                        .showSnackBar(const SnackBar(
                                      content: Text(" تم اضافة الكتاب "),
                                    ));
                                    Navigator.pop(conte);

                                    getReads();
                                    get_data_numbers();

                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'فشلت العملية',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  }
                                });

                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF33b17c),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(32.0),
                                    bottomRight: Radius.circular(32.0)),
                              ),
                              child: const Text(
                                "اضافة الكتاب",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }


  // تعديل بيانات كتاب
  updata_reads(Read_item item){
    showDialog(
        context: context,
        builder: (BuildContext conte) {
          String ed_read_start_date = item.start_date,
              title_book = item.title,
              writer_name = item.writer_name,
              library_name = item.library_name;
          int number_pages = item.number_pages;
          int id = item.id ;

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                width: 400.0,
                child: SingleChildScrollView(
                  child: Form(
                    key: key_form_read_book,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          const Center(
                            child: Text(
                              "تسجيل بيانات كتاب",
                              style: const TextStyle(fontSize: 20, color: Colors.teal),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$title_book",
                              decoration: const InputDecoration(
                                labelText: 'عنوان الكتاب :',
                                labelStyle: const TextStyle(color: Color(0xFF33b17c)),
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب تحديد عنوان صحيح للكتاب';
                                } else {
                                  title_book = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => title_book = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$writer_name",
                              decoration: const InputDecoration(
                                labelText: 'اسم المؤلف :',
                                labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                border: OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب تحديد اسم صحيح للمؤلف';
                                } else {
                                  writer_name = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => writer_name = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$library_name",
                              decoration: const InputDecoration(
                                labelText: 'دار النشر :',
                                labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                border: OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب كتابة دار النشر بشكل صحيح';
                                } else {
                                  library_name = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => library_name = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                initialValue: "$number_pages",

                                inputFormatters: [
                                  //هذا عشان ما يكتب الا رقم بس
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'عدد الصفحات :',
                                  labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xFF33b17c))),
                                ),
                                validator: (value) {
                                  if (value.length < 1) {
                                    return 'يجب ادخال عدد الصفحات !';
                                  } else {
                                    number_pages = int.parse(value);
                                    return null;
                                  }
                                },
                                maxLength: 7,
                                onSaved: (value) => setState(
                                        () => number_pages = int.parse(value))),
                          ),
                          const Divider(),
                          InkWell(
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));
                                ed_read_start_date =
                                "${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}";

                                if (pickedDate != null) {
                                  setState(() {
                                    ed_read_start_date;
                                  });

//                            print("${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}");

                                } else {
                                  print("Date is not selected");
                                }
                              },
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF9FBE7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      ' عدل تاريخ البدء \n $ed_read_start_date',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () {
                              if (key_form_read_book.currentState.validate()) {
                                // الاتصال وحفظ البيانات للسنة
//                            if(_goal_item == null || _goal_item.number_book_year == 0 ){// الاضافة الجديدة
                                API.Reads_Updata_All(
                                    id ,
                                    title_book,
                                    writer_name,
                                    library_name,
                                    number_pages,
                                    ed_read_start_date)
                                    .then((user) {

                                  if (user.id != 0) {
                                    key_scaffold.currentState
                                        .showSnackBar(const SnackBar(
                                      content: Text(" تم تعديل الكتاب "),
                                    ));
                                    Navigator.pop(conte);
                                    getReads();
//                                  setState(() {});
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'فشلت العملية',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  }
                                });

                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF33b17c),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(32.0),
                                    bottomRight: Radius.circular(32.0)),
                              ),
                              child: const Text(
                                "تعديل الكتاب",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
  // حذف بيانات كتاب
  delete_reads(int id){

    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('حذف كتاب', style: TextStyle(color: Colors.red),),
            content: const Text('هل انت متاكد من حذف الكتاب !'),
            actions: [

              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    API.Reads_Delete(id).then((user) {

                      if (user.id != 0) {
                        key_scaffold.currentState
                            .showSnackBar(const SnackBar(
                          content: Text(" تم الحذف "),
                        ));
                        Navigator.of(ctx).pop();
                        setState(() {

                        });
//                        getReads();
                      } else {
                        Fluttertoast.showToast(
                            msg: 'فشلت العملية',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.yellow);
                      }
                    });

                  });
                },
                child: Text('حذف',style: TextStyle(color: Colors.red)),

              ),

              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('الغاء'),

              )
            ],
          );
        });


  }



  // اضافة بيانات برنامج جديدة
  addNew_Data_Listn() {
    showDialog(
        context: context,
        builder: (BuildContext conte) {

          String ed_read_start_date = "0000-00-00",
              title_Listn = "",
              writer_name_Listn = "",
              target_listn,
              type_video_listn;
          int number_hour = 0, number_minute = 0;

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(const Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                width: 400.0,
                child: SingleChildScrollView(
                    child: Form(
                  key: key_form_read_book,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),

                        const Center(
                          child: Text(
                            "تسجيل بيانات برنامج",
                            style: TextStyle(fontSize: 20, color: Colors.teal),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: "$title_Listn",
                            decoration: const InputDecoration(
                              labelText: 'عنوان البرنامج :',
                              labelStyle: TextStyle(color: Color(0xFF33b17c)),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF33b17c))),
                            ),
                            validator: (value) {
                              if (value.length < 2) {
                                return 'يجب تحديد عنوان صحيح للكتاب';
                              } else {
                                title_Listn = value;
                                return null;
                              }
                            },
                            maxLength: 30,
                            onSaved: (value) =>
                                setState(() => title_Listn = value),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: "$writer_name_Listn",
                            decoration: const InputDecoration(
                              labelText: 'مقدم البرنامج :',
                              labelStyle: TextStyle(color: Color(0xFF33b17c)),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF33b17c))),
                            ),
                            validator: (value) {
                              if (value.length < 2) {
                                return 'يجب تحديد اسم صحيح للمؤلف';
                              } else {
                                writer_name_Listn = value;
                                return null;
                              }
                            },
                            maxLength: 30,
                            onSaved: (value) =>
                                setState(() => writer_name_Listn = value),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xFF33b17c))),
                            child: DropdownButton<String>(
                              value: target_listn,
                              //هنــــــــــــا تحط متغيرات الي بتنعرض
//                                  elevation: 0,
                              style: const TextStyle(color: Colors.teal),
                              items: <String>[
                                'صوتي',
                                'مرئي',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: const Text(
                                "حدد شكل البرنامج",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  target_listn = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xFF33b17c))),
                            child: DropdownButton<String>(
                              value: type_video_listn,
//                                  elevation: 100,
                              style: const TextStyle(color: Colors.teal),
                              items: <String>[
                                'كتاب مسموع',
                                'دورة تدريبية',
                                'ورشة عمل',
                                'فلم وثائقي',
                                'محاضرات ودروس',
                                'أخرئ',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: const Text(
                                "حدد نوع البرنامج",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  type_video_listn = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Divider(),

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: const Center(child: Text("مدة البرنامج")),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              inputFormatters: [
                                //هذا عشان ما يكتب الا رقم بس
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'عدد الساعات :',
                                labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                border: OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'يجب ادخال عدد الساعات !';
                                } else {
                                  number_hour = int.parse(value);
                                  return null;
                                }
                              },
                              maxLength: 7,
                              onSaved: (value) => setState(
                                  () => number_hour = int.parse(value))),
                        ),
//
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              inputFormatters: [
                                //هذا عشان ما يكتب الا رقم بس
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'عدد الدقائق :',
                                labelStyle: const TextStyle(color: const Color(0xFF33b17c)),
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: const Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'يجب ادخال عدد الدقائق !';
                                } else {
                                  number_minute = int.parse(value);
                                  return null;
                                }
                              },
                              maxLength: 7,
                              onSaved: (value) => setState(
                                  () => number_minute = int.parse(value))),
                        ),

                        const Divider(),

                        InkWell(
                            onTap: () async {
                              DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              ed_read_start_date =
                                  "${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}";

                              if (pickedDate != null) {
                                setState(() {
                                  ed_read_start_date;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    ' حدد تاريخ البدء \n $ed_read_start_date',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),

                        const SizedBox(
                          height: 50,
                        ),

                        InkWell(
                          onTap: () {
                            if (key_form_read_book.currentState.validate()) {
                              if (target_listn == null) {
                                Fluttertoast.showToast(
                                    msg: 'يجب تحديد شكل البرنامج',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              } else if (type_video_listn == null) {
                                Fluttertoast.showToast(
                                    msg: 'يجب تحديد نوع البرنامج',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              } else if (ed_read_start_date
                                      .compareTo("0000-00-00") ==
                                  0) {
                                Fluttertoast.showToast(
                                    msg: 'يجب تحديد تاريخ البدء',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              } else {
                                // اضافة الصوتيات
                                API.Listen_Add(
                                        title_Listn,
                                        target_listn,
                                        type_video_listn,
                                        writer_name_Listn,
                                        number_hour * 60 + number_minute,
                                        ed_read_start_date)
                                    .then((user) {
                                  if (user.id != 0) {
                                    key_scaffold.currentState
                                        .showSnackBar(const SnackBar(
                                      content: Text(" تم اضافة البرنامج "),
                                    ));
                                    Navigator.pop(conte);
//                                  setState(() {});
                                    get_data_numbers();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'فشلت العملية',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  }
                                });
                              }
                              // الاتصال وحفظ البيانات للسنة
//                            if(_goal_item == null || _goal_item.number_book_year == 0 ){// الاضافة الجديدة
//
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF33b17c),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: const Text(
                              "اضافة البرنامج",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            );
          });
        });
  }

  // تعديل بيانات برنامج او استماع
  updata_listn(Listen_Item item){
    showDialog(
        context: context,
        builder: (BuildContext conte) {

          String ed_read_start_date = item.start_date, title_Listn = item.title,
              writer_name_Listn = item.writer_name, target_listn = item.target, type_video_listn = item.type_video;
          int number_hour = item.time_video, number_minute = 0;

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(const Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                width: 400.0,
                child: SingleChildScrollView(
                    child: Form(
                      key: key_form_read_book,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              height: 50,
                            ),

                            const Center(
                              child: Text(
                                "تسجيل بيانات برنامج",
                                style: TextStyle(fontSize: 20, color: Colors.teal),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: "$title_Listn",
                                decoration: const InputDecoration(
                                  labelText: 'عنوان البرنامج :',
                                  labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xFF33b17c))),
                                ),
                                validator: (value) {
                                  if (value.length < 2) {
                                    return 'يجب تحديد عنوان صحيح للكتاب';
                                  } else {
                                    title_Listn = value;
                                    return null;
                                  }
                                },
                                maxLength: 30,
                                onSaved: (value) =>
                                    setState(() => title_Listn = value),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: "$writer_name_Listn",
                                decoration: const InputDecoration(
                                  labelText: 'مقدم البرنامج :',
                                  labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xFF33b17c))),
                                ),
                                validator: (value) {
                                  if (value.length < 2) {
                                    return 'يجب تحديد اسم صحيح للمؤلف';
                                  } else {
                                    writer_name_Listn = value;
                                    return null;
                                  }
                                },
                                maxLength: 30,
                                onSaved: (value) =>
                                    setState(() => writer_name_Listn = value),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF33b17c))),
                                child: DropdownButton<String>(
                                  value: target_listn,
                                  //هنــــــــــــا تحط متغيرات الي بتنعرض
//                                  elevation: 0,
                                  style: const TextStyle(color: Colors.teal),
                                  items: <String>[
                                    'صوتي',
                                    'مرئي',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: const Text(
                                    "حدد شكل البرنامج",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      target_listn = value;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF33b17c))),
                                child: DropdownButton<String>(
                                  value: type_video_listn,
//                                  elevation: 100,
                                  style: const TextStyle(color: Colors.teal),
                                  items: <String>[
                                    'كتاب مسموع',
                                    'دورة تدريبية',
                                    'ورشة عمل',
                                    'فلم وثائقي',
                                    'محاضرات ودروس',
                                    'أخرئ',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: const Text(
                                    "حدد نوع البرنامج",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      type_video_listn = value;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            const Divider(),

                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: const Center(child: Text("مدة البرنامج")),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  initialValue: "${number_hour ~/ 60}",

                                  inputFormatters: [
                                    //هذا عشان ما يكتب الا رقم بس
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'عدد الساعات :',
                                    labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                    border: OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xFF33b17c))),
                                  ),
                                  validator: (value) {
                                    if (value.length < 1) {
                                      return 'يجب ادخال عدد الساعات !';
                                    } else {
                                      number_hour = int.parse(value);
                                      return null;
                                    }
                                  },
                                  maxLength: 7,
                                  onSaved: (value) => setState(
                                          () => number_hour = int.parse(value))),
                            ),

                      Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  initialValue: "${number_hour % 60}",

                                  inputFormatters: [
                                    //هذا عشان ما يكتب الا رقم بس
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'عدد الدقائق :',
                                    labelStyle: const TextStyle(color: const Color(0xFF33b17c)),
                                    border: const OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: const Color(0xFF33b17c))),
                                  ),
                                  validator: (value) {
                                    if (value.length < 1) {
                                      return 'يجب ادخال عدد الدقائق !';
                                    } else {
                                      number_minute = int.parse(value);
                                      return null;
                                    }
                                  },
                                  maxLength: 7,
                                  onSaved: (value) => setState(
                                          () => number_minute = int.parse(value))),
                            ),

                            const Divider(),

                            InkWell(
                                onTap: () async {
                                  DateTime pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));
                                  ed_read_start_date =
                                  "${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}";

                                  if (pickedDate != null) {
                                    setState(() {
                                      ed_read_start_date;
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFF9FBE7),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        ' حدد تاريخ البدء \n $ed_read_start_date',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),

                            const SizedBox(
                              height: 50,
                            ),

                            InkWell(
                              onTap: () {
                                if (key_form_read_book.currentState.validate()) {
                                  if (target_listn == null) {
                                    Fluttertoast.showToast(
                                        msg: 'يجب تحديد شكل البرنامج',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  } else if (type_video_listn == null) {
                                    Fluttertoast.showToast(
                                        msg: 'يجب تحديد نوع البرنامج',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  } else if (ed_read_start_date
                                      .compareTo("0000-00-00") ==
                                      0) {
                                    Fluttertoast.showToast(
                                        msg: 'يجب تحديد تاريخ البدء',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  } else {
                                    // اضافة الصوتيات
                                    API.Listen_Updata_All(
                                      item.id ,
                                        title_Listn,
                                        target_listn,
                                        type_video_listn,
                                        writer_name_Listn,
                                        number_hour * 60 + number_minute,
                                        ed_read_start_date)
                                        .then((user) {
                                      if (user.id != 0) {
                                        key_scaffold.currentState
                                            .showSnackBar(const SnackBar(
                                          content: Text(" تم تعديل البرنامج "),
                                        ));
                                        Navigator.pop(conte);
//                                  setState(() {});
                                        get_data_numbers();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'فشلت العملية',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.yellow);
                                      }
                                    });
                                  }

                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF33b17c),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(32.0),
                                      bottomRight: Radius.circular(32.0)),
                                ),
                                child: const Text(
                                  "تعديل البرنامج",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            );
          });
        });
  }

  // حذف بيانات قراءة او استماع
  delete_listn(int id){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('حذف برنامج', style: TextStyle(color: Colors.red),),
            content: const Text('هل انت متاكد من حذف البرنامج !'),
            actions: [

              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    API.Listen_Delete(id).then((user) {

                      if (user.id != 0) {
                        key_scaffold.currentState
                            .showSnackBar(const SnackBar(
                          content: Text(" تم الحذف "),
                        ));
                        Navigator.of(ctx).pop();
                        setState(() {

                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: 'فشلت العملية',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.yellow);
                      }
                    });

                  });
                },
                child: const Text('حذف',style: TextStyle(color: Colors.red)),

              ),

              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('الغاء'),

              )
            ],
          );
        });
  }

  // البحث والتاليف
  Widget getPlan() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 40,
        width: (MediaQuery.of(context).size.width),
        color: Colors.teal,
        child: InkWell(
          onTap: () {
            payStart(context, 5);
          },
          child: const Center(
            child: Text(
              "تسجيل بيانات جديدة",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.teal,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'هدف شهر ${currDt.month}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                ' اختصار كتاب $plan_year_number_hour',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(color: Colors.white),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(' مقال $plan_year_number_article',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                ' بحث  $plan_year_number_search',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(color: Colors.white),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(' كتاب  $plan_year_number_book',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                      const Divider(color: Colors.white),
                      ElevatedButton(
                          child: const Text("تسجيل اهداف سنة جديدة",
                              style: TextStyle(
                                  color: Colors.teal, fontSize: 18)),
                          style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.teal),
                            // الظل
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(5)),
                            // الهامش
                            minimumSize: MaterialStateProperty.all(
                                const Size(250, 20)),
                            //ألطول والعرض

                            // حواف مائلة
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                          ),
                          onPressed: () {
                            payStart(context, 4);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: FutureBuilder(
                    future: API.Plan_Data_Get(), // async work
                    builder: (BuildContext contextBook,
                        AsyncSnapshot<List<Plan_item_data>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),

                              itemCount: snapshot.data.length,
                              itemBuilder: (conx, index) {
                                return Container(
                                    margin: const EdgeInsets.all(5.0),
                                    height: 230,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 10,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        15.0),
                                                child: Text(
                                                  '${snapshot.data[index].title}',
                                                  style: const TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    //more --------
                                                  },
                                                  child: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.green,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child:
                                                                const DecoratedBox(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color(
                                                                          0xFFF9FBE7),
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(0),
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                        bottomLeft:
                                                                            Radius.circular(0),
                                                                        bottomRight:
                                                                            Radius.circular(5),
                                                                      )),
                                                              child: const Center(
                                                                child: Text(
                                                                  'نوع المحتوئ :',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                DecoratedBox(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .teal,
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        topRight:
                                                                            Radius.circular(0),
                                                                        bottomLeft:
                                                                            Radius.circular(5),
                                                                        bottomRight:
                                                                            Radius.circular(0),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  '${Plan_Data.plan_type_data(snapshot.data[index].type)}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child:
                                                                const DecoratedBox(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color(
                                                                          0xFFF9FBE7),
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(0),
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                        bottomLeft:
                                                                            Radius.circular(0),
                                                                        bottomRight:
                                                                            Radius.circular(5),
                                                                      )),
                                                              child: const Center(
                                                                child: const Text(
                                                                  'الحالة :',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                DecoratedBox(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .teal,
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        topRight:
                                                                            Radius.circular(0),
                                                                        bottomLeft:
                                                                            Radius.circular(5),
                                                                        bottomRight:
                                                                            Radius.circular(0),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  '${Plan_Data.plan_done_data(snapshot.data[index].done)}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child:
                                                                const DecoratedBox(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color(
                                                                          0xFFF9FBE7),
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(0),
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                        bottomLeft:
                                                                            Radius.circular(0),
                                                                        bottomRight:
                                                                            Radius.circular(5),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  'عدد الصفحات :',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                DecoratedBox(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .teal,
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        topRight:
                                                                            Radius.circular(0),
                                                                        bottomLeft:
                                                                            Radius.circular(5),
                                                                        bottomRight:
                                                                            Radius.circular(0),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  '${snapshot.data[index].number_page}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const Expanded(
                                                            flex: 2,
                                                            child:
                                                                DecoratedBox(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color(
                                                                          0xFFF9FBE7),
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(0),
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                        bottomLeft:
                                                                            Radius.circular(0),
                                                                        bottomRight:
                                                                            Radius.circular(5),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  'المنجزة :',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                DecoratedBox(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .teal,
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        topRight:
                                                                            Radius.circular(0),
                                                                        bottomLeft:
                                                                            Radius.circular(5),
                                                                        bottomRight:
                                                                            Radius.circular(0),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  '${snapshot.data[index].number_page_end}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                  child: Text(
                                                'تاريخ البدء : ${snapshot.data[index].start_date} ',
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style:
                                                    const TextStyle(fontSize: 13),
                                              ))),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                updata_done_plan(
                                                    snapshot.data[index]);
                                              },
                                              child: const Expanded(
                                                  child: DecoratedBox(
                                                decoration:
                                                    BoxDecoration(
                                                        color: Colors.teal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .only(
                                                          topLeft: Radius
                                                              .circular(0),
                                                          topRight: Radius
                                                              .circular(0),
                                                          bottomLeft: Radius
                                                              .circular(10),
                                                          bottomRight:
                                                              Radius
                                                                  .circular(
                                                                      10),
                                                        )),
                                                child: const Center(
                                                  child: Text(
                                                    'تسجيل انجاز',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign:
                                                        TextAlign.center,
                                                  ),
                                                ),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                            );
                          }
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// تعديل او اضافة سنة جديدة للبحث والتاليف
  addNew_year_Plan() {
    showDialog(
        context: context,
        builder: (BuildContext conte) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 350.0,
              child: Form(
                key: key_form_read_year,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text("تسجيل الاهداف للعام : ${currDt.year}"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue: "$plan_year_number_hour_done",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length == 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        plan_year_number_hour_done =
                                            int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد الساعات البحثية ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue:
                                        "$plan_year_number_article_done",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        plan_year_number_article_done =
                                            int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد المقالات ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue:
                                        "$plan_year_number_search_done",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        plan_year_number_search_done =
                                            int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: const SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد البحوث ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue: "$plan_year_number_book_done",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        plan_year_number_book_done =
                                            int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: const SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد الكتب ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        if (key_form_read_year.currentState.validate()) {
                          // الاتصال وحفظ البيانات للسنة
                          if (_plan_item_year == null ||
                              _plan_item_year.number_hour == null ||
                              _plan_item_year.number_hour == 0) {
                            // الاضافة الجديدة

                            API.Plan_Year_Add(
                                    plan_year_number_hour_done,
                                    plan_year_number_article_done,
                                    plan_year_number_search_done,
                                    plan_year_number_book_done,
                                    "${currDt.year}")
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                                Navigator.pop(conte);
                                get_data_numbers();
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });
                          } else {
                            // التعديل
                            API.Plan_Year_Updata(
                                    _plan_item_year.id,
                                    plan_year_number_hour_done,
                                    plan_year_number_article_done,
                                    plan_year_number_search_done,
                                    plan_year_number_book_done,
                                    "${currDt.year}")
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                                Navigator.pop(conte);
                                get_data_numbers();
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية !',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF33b17c),
                          borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(32.0),
                              bottomRight: const Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "حـفـظ",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

// اضافة تسجيل بيانات الخطة البحثية
  addNew_Data_Plan() {
    showDialog(
        context: context,
        builder: (BuildContext conte) {
          String ed_read_start_date = "0000-00-00", title_book = "", v_type;
          int number_pages = 0, type_plan = 0;

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                width: 400.0,
                child: SingleChildScrollView(
                  child: Form(
                    key: key_form_read_book,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          const Center(
                            child: Text(
                              "تسجيل البيانات ",
                              style: TextStyle(fontSize: 20, color: Colors.teal),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: const Color(0xFF33b17c))),
                              child: DropdownButton<String>(
                                value: v_type,
//                                  elevation: 100,
                                style: const TextStyle(color: Colors.teal),
                                items: <String>[
                                  'كتاب',
                                  'بحث',
                                  'مقال',
                                  'أخرئ',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: const Text(
                                  "حدد نوع الحتوئ",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    type_plan = getType_plan(value);
                                    v_type = value;
//                                      print(type_plan);
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: "$title_book",
                              decoration: const InputDecoration(
                                labelText: 'العنوان :',
                                labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF33b17c))),
                              ),
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'يجب تحديد عنوان صحيح ';
                                } else {
                                  title_book = value;
                                  return null;
                                }
                              },
                              maxLength: 30,
                              onSaved: (value) =>
                                  setState(() => title_book = value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                inputFormatters: [
                                  //هذا عشان ما يكتب الا رقم بس
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'عدد الصفحات :',
                                  labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF33b17c))),
                                ),
                                validator: (value) {
                                  if (value.length < 1) {
                                    return 'يجب ادخال عدد الصفحات !';
                                  } else {
                                    number_pages = int.parse(value);
                                    return null;
                                  }
                                },
                                maxLength: 7,
                                onSaved: (value) => setState(
                                    () => number_pages = int.parse(value))),
                          ),
                          const Divider(),
                          InkWell(
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));
                                ed_read_start_date =
                                    "${pickedDate.year}-${App_Data.getDate_month(pickedDate.month)}-${App_Data.getDate_Day(pickedDate.day)}";

                                if (pickedDate != null) {
                                  setState(() {
                                    ed_read_start_date;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF9FBE7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      ' حدد تاريخ البدء \n $ed_read_start_date',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )),

                          const SizedBox(height: 50,),

                          InkWell(
                            onTap: () {
                              if (key_form_read_book.currentState.validate()) {
                                // الاتصال وحفظ البيانات للسنة
                                if (ed_read_start_date == null ||
                                    ed_read_start_date.compareTo("0000-00-00") == 0) {
                                  // الاضافة الجديدة

                                  Fluttertoast.showToast(
                                      msg: 'يجب اضافة الناريخ',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                } else {
                                  API.Plan_Data_Add(type_plan, title_book,
                                          number_pages, ed_read_start_date)
                                      .then((user) {
                                    if (user.id != 0) {
                                      key_scaffold.currentState
                                          .showSnackBar(const SnackBar(
                                        content: Text(" تم اضافة الكتاب "),
                                      ));
                                      Navigator.pop(conte);
//                                        setState(() {});
                                      get_data_numbers();

                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'فشلت العملية',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.yellow);
                                    }
                                  });
                                }
                              } else {
                                print("no");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF33b17c),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(32.0),
                                    bottomRight: Radius.circular(32.0)),
                              ),
                              child: const Text(
                                "حــفـظ",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  // تعديل انجاز على القراءة
  upData_done_Read_Listn(Read_And_Listen_item item_all) {
    int ed_num = 0;
    String name_ed = "";

    if (item_all.type == 1) {
      name_ed = "عدد الصفحات المنجزة";
    } else {
      name_ed = "عدد الدقائق المنجزة";
    }

    showDialog(
        context: context,
        builder: (BuildContext conte) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 250.0,
              child: Form(
                key: key_form_read_year,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
                                    initialValue: "$ed_num",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        ed_num = int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    ' $name_ed ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        int number_hour_done = 0,
                            number_article_done = 0,
                            number_search_done = 0,
                            number_book_done = 0;
                        int number_bookss = 0,
                            number_pagess = 0,
                            number_ments = 0;

                        if (key_form_read_year.currentState.validate()) {
                          if (item_all.number_stop + ed_num >=
                              item_all.number_pages) {
                            //تم الانجاز

                            if (item_all.type == 1) {
                              // القراءة

                              API.Reads_Updata(
                                      item_all.id, 1, item_all.number_pages)
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });

                              API.StoreBook_Add(ed_num, 1, 0,
                                      "${currDt.year}-${App_Data.getDate_month(currDt.month)}-${App_Data.getDate_Day(currDt.day)}")
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });

                              API.GoalYearBook_Updata(
                                      _goal_item.id,
                                      number_book_year,
                                      number_song_year,
                                      number_book_year_done + 1,
                                      number_song_year_done,
                                      currDt.year)
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                  Navigator.pop(conte);
                                  get_data_numbers();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية ،، اضف قيم جديدة',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });
                            } else if (item_all.type == 2) {
                              // الصوتيات

                              API.Listen_Updata(
                                      item_all.id, 1, item_all.number_pages)
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });

                              API.StoreBook_Add(0, 0, ed_num,
                                      "${currDt.year}-${App_Data.getDate_month(currDt.month)}-${App_Data.getDate_Day(currDt.day)}")
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });

                              API.GoalYearBook_Updata(
                                      _goal_item.id,
                                      number_book_year,
                                      number_song_year,
                                      number_book_year_done,
                                      number_song_year_done + 1,
                                      currDt.year)
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                  Navigator.pop(conte);
                                  get_data_numbers();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية ،، اضف قيم جديدة',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });
                            }
                          } else {
                            // تسجيل انجاز عادي

                            if (item_all.type == 1) {
                              // القراءة

                              API.Reads_Updata(item_all.id, 0,
                                      ed_num + item_all.number_stop)
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });

                              API.StoreBook_Add(ed_num, 0, 0,
                                      "${currDt.year}-${App_Data.getDate_month(currDt.month)}-${App_Data.getDate_Day(currDt.day)}")
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                  Navigator.pop(conte);
                                  get_data_numbers();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });
                            } else {
                              // للاستماع

                              API.Listen_Updata(item_all.id, 0,
                                      ed_num + item_all.number_stop)
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });

                              API.StoreBook_Add(0, 0, ed_num,
                                      "${currDt.year}-${App_Data.getDate_month(currDt.month)}-${App_Data.getDate_Day(currDt.day)}")
                                  .then((user) {
                                if (user.id != 0) {
                                  key_scaffold.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                  Navigator.pop(conte);
                                  get_data_numbers();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });
                            }
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF33b17c),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "تـم",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // تسجيل انجاز خطة البحثية
  updata_done_plan(Plan_item_data item) {
    int ed_num = 0;

    showDialog(
        context: context,
        builder: (BuildContext conte) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 250.0,
              child: Form(
                key: key_form_read_year,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(hintText: '0'),
                                    keyboardType: TextInputType.number,
//                                    initialValue: "$ed_num",
                                    inputFormatters: [
                                      //هذا عشان ما يكتب الا رقم بس
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 0) {
                                        return "القيمة فارغة!";
                                      } else if (int.parse(value) == 0) {
                                        return "لا يجب ان تكون القيمة 0 !";
                                      } else {
                                        ed_num = int.parse(value);
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9FBE7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'عدد الصفحات المنجزة ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        int number_hour_done = 0,
                            number_article_done = 0,
                            number_search_done = 0,
                            number_book_done = 0;
                        int number_articles = 0,
                            number_search = 0,
                            number_books = 0,
                            number_hours = 0;

//                        print (item.number_page_end + ed_num) ;

                        if (key_form_read_year.currentState.validate()) {



                          if (item.number_page_end + ed_num >= item.number_page) {

                            if (item.type == 1) {
                              number_book_done = 1;
                            } else if (item.type == 2) {
                              number_search_done = 1;
                            } else if (item.type == 3) {
                              number_article_done = 1;
                            } else if (item.type == 4) {
                              number_hour_done = 1;
                            }
//
                            if(_plan_item_year == null){


                            }else{
                              // الاتصال وحفظ البيانات للسنة
                              API.Plan_Year_Updata_Done(
                                  _plan_item_year.id,
                                  number_hour_done,
                                  number_article_done,
                                  number_search_done,
                                  number_book_done)
                                  .then((user) {


                                if (user.id != null) {
                                  key_scaffold.currentState.showSnackBar(const SnackBar(
                                    content: Text("تم الحفظ "),
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'فشلت العملية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });


                            }
//
                            // التعديل على الرصيد المعرفي
                            if (item.type == 1) {
                              number_articles = 0;
                              number_search = 0;
                              number_books = 1;
//                                        store_item_plan.number_hours = 0;

                            } else if (item.type == 2) {
                              number_articles = 0;
                              number_search = 1;
                              number_books = 0;
//                                        store_item_plan.number_hours = 0;

                            } else if (item.type == 3) {
                              number_articles = 1;
                              number_search = 0;
                              number_books = 0;
//                                        store_item_plan.number_hours = 0;

                            } else if (item.type == 4) {
                              number_articles = 0;
                              number_search = 0;
                              number_books = 0;
//                                        store_item_plan.number_hours = 1;
                            }
                            // الاتصال وحفظ للرصيد المعرفي
                            API.StorePlan_Add(
                                    number_articles,
                                    number_search,
                                    number_books,
                                    ed_num,
                                    "${currDt.year}-${App_Data.getDate_month(currDt.month)}-${App_Data.getDate_Day(currDt.day)}")
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            }
                            );

                            API.Plan_Data_Updata(
                                    item.id,
                                    item.type,
                                    item.title,
                                    item.number_page,
                                    item.number_page_end + ed_num,
                                    1,
                                    item.start_date)
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                                Navigator.pop(conte);
                                get_data_numbers();
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });

                          } else {

                            // الاتصال وحفظ للرصيد المعرفي
                            API.StorePlan_Add(
                                    number_articles,
                                    number_search,
                                    number_books,
                                    ed_num,
                                    "${currDt.year}-${App_Data.getDate_month(currDt.month)}-${App_Data.getDate_Day(currDt.day)}")
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });

                            API.Plan_Data_Updata(
                                    item.id,
                                    item.type,
                                    item.title,
                                    item.number_page,
                                    item.number_page_end + ed_num,
                                    0,
                                    item.start_date)
                                .then((user) {
                              if (user.id != 0) {
                                key_scaffold.currentState.showSnackBar(const SnackBar(
                                  content: Text("تم الحفظ "),
                                ));
                                Navigator.pop(conte);
                                get_data_numbers();
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'فشلت العملية',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow);
                              }
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF33b17c),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "تـم",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }


  // عرض رسالة الاشتراك
  pay_Message(BuildContext context_main, int num_bag){

    showDialog<String>(
        context: context_main,
        builder: (BuildContext con) => SimpleDialog(
            children: [

              FutureBuilder<PayItem>(
                future: API.Pay_Real_Get(),
                builder: (con, snapshot) {
                  if (snapshot.hasData) {

                    if (snapshot.data.type == 1) { //تم الاشتراك
                      // الدخول

                      Navigator.pop(con);

                      go_bag(num_bag);
                      return null ;

                    } else { //لم يشترك
                      // عرض الرسالة للاشتراك
                      return Column(
                        children: [

                          const Text("مرحبا بك في تطبيق العالم يقرأ"),
                          const Text("تمتع بكافة مميزات التطبيق بجميع اقسامة"),
                          const Text("يمكنك البدء بتجربة مجانية لمدة 10 ايام"),

                          SizedBox(height: 30,),

                          Row(
                            children: [
                              // الخطة المجانية
                              Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.green[800],
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: InkWell(
                                    onTap: () {

                                      API.Pay_Free_Get().then((pay) {
                                        if ( pay.id != 0) {

                                          if(pay.type == 1){
                                            // الدخول ............

                                            Navigator.pop(con);

                                            go_bag(num_bag);


                                          }else if(pay.type == 2){
                                            Navigator.pop(con);

                                            Fluttertoast.showToast(
                                                msg: 'انتهت الخطة المجانية',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.yellow);

                                          }else{


                                          }

                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'فشل الاتصال بالشبكة!',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.yellow);
                                        }
                                      });
                                    },
                                    child: const Text(
                                      "المتابعة بالخطة المجانية",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                              ),


                              // الشراء الحقيقي
                              Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.green[800],
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: InkWell(
                                    onTap: () {
                                      // TODO
                                      Navigator.pop(con);

                                      Navigator.push(
                                          con, MaterialPageRoute(
                                          builder: (context) => Pay_Bag()));

                                    },
                                    child: const Text(
                                      "البدء بالاشتراك الشهري",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                              ),

                            ],
                          )
                        ],
                      );
                    }

                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ]));
  }

  // البدء بتحقق من الاشتراك
  Future<void> payStart(BuildContext context, int num_bag) async {
    int id_user = await User_Data.getUserDataId() ;

    if(id_user != 0 ) {// المستخدم مسجل الدخول

      API.Pay_Real_Get().then((pay) { // فحص الاشتراك الحقيقي
        if (pay != null || pay.id != 0) {
          if(pay.type == 1){ // مشترك
            go_bag(num_bag);

          }else{
            API.Pay_Free_Get_user().then((pay) { // فحص الاشتراك التجريبي
              if (pay != null || pay.id != 0) {
                if(pay.type == 1){ // مشترك
                  go_bag(num_bag);
                  Fluttertoast.showToast(
                      msg: "ينتهي الاشتراك التجريبي في تاريخ \n ${pay.date_end}",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.yellow);

                }else{
                  pay_Message(context, num_bag);
                }
              } else {
                pay_Message(context, num_bag);
              }
            });


          }
        } else {

          API.Pay_Free_Get_user().then((pay) { // فحص الاشتراك التجريبي
            if (pay != null || pay.id != 0) {
              if(pay.type == 1){ // مشترك
                go_bag(num_bag);
                Fluttertoast.showToast(
                    msg: "ينتهي الاشتراك التجريبي في تاريخ \n ${pay.date_end}",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.yellow);

              }else{
                pay_Message(context, num_bag);
              }
            } else {
              pay_Message(context, num_bag);
            }
          });

        }
      });



    }else{
      // رسالة يجب تسجيل الدخول
      Fluttertoast.showToast(
          msg: "يجب تسجيل الدخول اولاً",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  go_bag(int num_bag){
    if(num_bag == 1 ){
      addNew_year_data();// تعديل السنة للقراءة و الاستامع

    }else if (num_bag == 2 ){
      addNew_Data_Book(); // اضافة كتاب

    }else if (num_bag == 3 ){
      addNew_Data_Listn(); // اضافة برنامج

    }else if (num_bag == 4 ){
      addNew_year_Plan(); // تعديل الخطة البحثية

    }else if (num_bag == 5 ){
      addNew_Data_Plan(); // اضافة بيانات الخطة البحثية

    }
  }


// مكتبتي
  Widget getMy_mktbah(){
    return SingleChildScrollView(
      child: Column(
        children: [
          ToggleBar(
            labels: labels2,
            backgroundColor: Colors.teal,
            onSelectionUpdated: (index) =>
                setState(() => currentIndex2 = index),
          ),
          Container(child: getMy_mktbah_done(currentIndex2))

        ],
      ),
    );

  }


  Widget getMy_mktbah_done(int indx){
    if(indx == 0){// الكتب المنجزة
      return FutureBuilder(
        future: API.Reads_Get_Done(), // async work
        builder: (BuildContext contextBook,
            AsyncSnapshot<List<Read_item>> snapshot_reads) {
          switch (snapshot_reads.connectionState) {
            case ConnectionState.waiting:

              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot_reads.hasError) {

                return  getMy_mktbah_done(indx);

              } else {

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot_reads.data.length,
                  itemBuilder: (conx, index) {
                    return Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 200,
                        child: Card(
                          shape:
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      '${getStrings_img(snapshot_reads.data[index].type)}',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshot_reads.data[index].title}',
                                      style: const TextStyle(
                                          color: Colors.teal,
                                          fontSize: 18),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(5.0),
                                    child: PopupMenuButton(
                                        iconSize: 25,
                                        itemBuilder: (BuildContext con) {
                                          return [
                                            PopupMenuItem(
                                                child: Text('تعديل'),
                                                onTap: () {
                                                  // قراءة
                                                  updata_reads(snapshot_reads.data[index]);
                                                }),
                                            PopupMenuItem(
                                                child: Text('حذف'),
                                                onTap: () {
                                                  delete_reads(snapshot_reads.data[index].id);
                                                }
                                            )
                                          ];
                                        }
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      'عدد صفحات الكتاب',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      //مدة البرنامج او عد دالصفحات
                                                      '${snapshot_reads.data[index].number_pages}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),

                                            const SizedBox(width: 5,),

                                            const Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      'صفحة الوقوف',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      '${snapshot_reads.data[index].number_pages}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 5,),

                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      'تم الانجاز :',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),

                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      '√',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),

                                            SizedBox(width: 5,),

                                            Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      'الصفحات المتبقية',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),

                                                  child: Center(
                                                    child: Text('0',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                        'تاريخ البدء : ${snapshot_reads.data[index].start_date} ',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 13),
                                      ))),
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              }
          }
        },
      );


    }else if(indx == 1 ){
      return FutureBuilder(
        future: API.Listen_Get_Done(), // async work
        builder: (BuildContext contextBook,
            AsyncSnapshot<List<Listen_Item>> snapshot_reads) {
          switch (snapshot_reads.connectionState) {
            case ConnectionState.waiting:

              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot_reads.hasError) {

                return  getMy_mktbah_done(indx);

              } else {

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot_reads.data.length,
                  itemBuilder: (conx, index) {
                    return Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 200,
                        child: Card(
                          shape:
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      '${getStrings_img(snapshot_reads.data[index].type)}',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshot_reads.data[index].title}',
                                      style: const TextStyle(
                                          color: Colors.teal,
                                          fontSize: 18),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(5.0),
                                    child: PopupMenuButton(
                                        iconSize: 25,
                                        itemBuilder: (BuildContext con) {
                                          return [
                                            PopupMenuItem(
                                                child: Text('تعديل'),
                                                onTap: () {
                                                  updata_listn(snapshot_reads.data[index]);
                                                }),
                                            PopupMenuItem(
                                                child: Text('حذف'),
                                                onTap: () {
                                                  delete_listn(snapshot_reads.data[index].id);
                                                }
                                            )
                                          ];
                                        }
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      'مدة البرنامج',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      //مدة البرنامج او عد دالصفحات
                                                      '${getNumber_pags_or_listn(2, snapshot_reads.data[index].time_video)}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),

                                            const SizedBox(width: 5,),

                                            const Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      'دقيقة الوقوف',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      '${getNumber_pags_or_listn(2, snapshot_reads.data[index].time_video)}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 5,),

                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      'تم الانجاز :',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),

                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      '√',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),

                                            SizedBox(width: 5,),

                                            Expanded(
                                                flex: 2,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF9FBE7),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(5),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(5),
                                                      )),

                                                  child: Center(
                                                    child: Text(
                                                      'المدة المتبقية',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(5),
                                                        topRight: Radius.circular(0),
                                                        bottomLeft: Radius.circular(5),
                                                        bottomRight: Radius.circular(0),
                                                      )),

                                                  child: Center(
                                                    child: Text('0',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                        'تاريخ البدء : ${snapshot_reads.data[index].start_date} ',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 13),
                                      ))),
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              }
          }
        },
      );





    }else if(indx == 2 ){
      return FutureBuilder(
        future: API.Plan_Data_Get_Done(), // async work
        builder: (BuildContext contextBook,
            AsyncSnapshot<List<Plan_item_data>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                print(snapshot.data.length);

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: snapshot.data.length,
                  itemBuilder: (conx, index) {
                    return Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 230,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        15.0),
                                    child: Text(
                                      '${snapshot.data[index].title}',
                                      style: const TextStyle(
                                          color: Colors.teal,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        8.0),
                                    child: InkWell(
                                      onTap: () {
                                        //more --------
                                      },
                                      child: const Icon(
                                        Icons.more_vert,
                                        color: Colors.green,
                                        size: 30.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          children: [
                                            const Expanded(
                                                flex: 2,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  BoxDecoration(
                                                      color: Color(
                                                          0xFFF9FBE7),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(0),
                                                        topRight:
                                                        Radius.circular(5),
                                                        bottomLeft:
                                                        Radius.circular(0),
                                                        bottomRight:
                                                        Radius.circular(5),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      'نوع المحتوئ :',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  const BoxDecoration(
                                                      color: Colors
                                                          .teal,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(5),
                                                        topRight:
                                                        Radius.circular(0),
                                                        bottomLeft:
                                                        Radius.circular(5),
                                                        bottomRight:
                                                        Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      '${Plan_Data.plan_type_data(snapshot.data[index].type)}',
                                                      style:
                                                      const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Expanded(
                                                flex: 2,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  BoxDecoration(
                                                      color: Color(
                                                          0xFFF9FBE7),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(0),
                                                        topRight:
                                                        Radius.circular(5),
                                                        bottomLeft:
                                                        Radius.circular(0),
                                                        bottomRight:
                                                        Radius.circular(5),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      'الحالة :',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  const BoxDecoration(
                                                      color: Colors
                                                          .teal,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(5),
                                                        topRight:
                                                        Radius.circular(0),
                                                        bottomLeft:
                                                        Radius.circular(5),
                                                        bottomRight:
                                                        Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      '${Plan_Data.plan_done_data(snapshot.data[index].done)}',
                                                      style:
                                                      const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          children: [
                                            const Expanded(
                                                flex: 2,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  BoxDecoration(
                                                      color: Color(
                                                          0xFFF9FBE7),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(0),
                                                        topRight:
                                                        Radius.circular(5),
                                                        bottomLeft:
                                                        Radius.circular(0),
                                                        bottomRight:
                                                        Radius.circular(5),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      'عدد الصفحات :',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  const BoxDecoration(
                                                      color: Colors
                                                          .teal,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(5),
                                                        topRight:
                                                        Radius.circular(0),
                                                        bottomLeft:
                                                        Radius.circular(5),
                                                        bottomRight:
                                                        Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      '${snapshot.data[index].number_page}',
                                                      style:
                                                      const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Expanded(
                                                flex: 2,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  BoxDecoration(
                                                      color: Color(
                                                          0xFFF9FBE7),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(0),
                                                        topRight:
                                                        Radius.circular(5),
                                                        bottomLeft:
                                                        Radius.circular(0),
                                                        bottomRight:
                                                        Radius.circular(5),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      'المنجزة :',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child:
                                                DecoratedBox(
                                                  decoration:
                                                  const BoxDecoration(
                                                      color: Colors
                                                          .teal,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(5),
                                                        topRight:
                                                        Radius.circular(0),
                                                        bottomLeft:
                                                        Radius.circular(5),
                                                        bottomRight:
                                                        Radius.circular(0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      '${snapshot.data[index].number_page_end}',
                                                      style:
                                                      const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize:
                                                        16,
                                                      ),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                        'تاريخ البدء : ${snapshot.data[index].start_date} ',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style:
                                        const TextStyle(fontSize: 13),
                                      ))),
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) =>
                  const Divider(),
                );
              }
          }
        },
      );






    }else if(indx == 3 ){
      return const Text("");


    }
  }
}
