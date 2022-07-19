import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_world_reads/find/find_book.dart';
import 'package:the_world_reads/pay/pay_bag.dart';
import 'package:the_world_reads/pay/pay_my_pay.dart';
import 'package:the_world_reads/users/user_sing_in.dart';

import 'Admin/app_data.dart';
import 'Media_Audio/play_music.dart';
import 'main/home/home.dart';
import 'main/store/store_home.dart';
import 'main/today/today_home.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: MyHomePage(title: 'العالم يقرأ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  int _currentIndex = 2;
  List<Widget> _children;

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserSingIn(),
        ));
  }

  @override
  void initState() {
    super.initState();
    App_Data.getUserData(); //جلب بيانات المستخدم لمرة واحدة
    _children = [Store_Home(), Today_Home(), Home()];
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: key_scaffold,
        debugShowCheckedModeBanner: false, // ازاله البانر العلويه

        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => Pay_Bag()));

//                            if (App_Data.getUserID() == 0) {
//                              Fluttertoast.showToast(
//                                  msg: 'يجب تسجيل الدخول اولاً !',
//                                  toastLength: Toast.LENGTH_SHORT,
//                                  timeInSecForIosWeb: 3,
//                                  backgroundColor: Colors.red,
//                                  textColor: Colors.yellow);
//                            } else {
//                              PayMyPay.payMessage(context);
//                            }
                          },
                          child: const Icon(
                            Icons.shopping_cart,
                            size: 30,
                            color: Colors.teal,
                          )),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                               Navigator.push(
                                   context, MaterialPageRoute(
                                   builder: (context) => Find_Book()));
                          },
                          child: const Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.teal,
                          )),
                    ),
                    Expanded(
                      flex: 6,
                      child: Image.asset(
                        'images/icon_app_type_b.png',
                        width: 40,
                        height: 40,
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
//                                Navigator.push(
//                                    context, MaterialPageRoute(
//                                    builder: (context) => FindFood()));
                        },
                        child: Image.asset(
                          'images/ic_notifaction.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _awaitReturnValueFromSecondScreen(context);
                        },
                        child: Image.asset(
                          'images/ic_users.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'images/img_main_news.png',
                    width: 30,
                    height: 30,
                  ),
                  label: ('الرصيد المعرفي'),
                  backgroundColor: Colors.teal),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'images/img_main_today.png',
                    width: 30,
                    height: 30,
                  ),
                  label: ('الإنجاز اليومي'),
                  backgroundColor: Colors.teal),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: ('الرئيسية'),
                  backgroundColor: Colors.teal),
            ],
            //  type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
            iconSize: 20,
            elevation: 8,
          ),
        ));
  }
}
