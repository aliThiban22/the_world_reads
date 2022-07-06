import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_world_reads/users/user_data.dart';
import 'package:the_world_reads/users/user_sign_up.dart';
import 'package:the_world_reads/users/user_updata.dart';
import 'package:the_world_reads/users/users_item.dart';

import '../Admin/app_data.dart';
import '../network/api.dart';
import '../pay/pay_my_pay.dart';

class UserSingIn extends StatefulWidget {
  @override
  _UserSingInState createState() => _UserSingInState();
}

class _UserSingInState extends State<UserSingIn> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  final key_form_stat = GlobalKey<FormState>();
  String em = "", pass = "", name = '';
  User_Item user = new User_Item();

  // استرجاع بيانات المستخدم
  getUserData() async {
    user = await User_Data.getUserData();
    name = user.name;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (user.id == null || user.id == 0) {
      // تسجيل الدخول
      return MaterialApp(
          debugShowCheckedModeBanner: false, // ازاله البانر العلويه
          home: Scaffold(key: key_scaffold, body: _SingIn(context)));
    } else {
      // البروفايل
      return MaterialApp(
          debugShowCheckedModeBanner: false, // ازاله البانر العلويه
          home: Scaffold(key: key_scaffold, body: _Profile(context)));
    }
  }

  // صفحة البروفايل
  Container _Profile(BuildContext context) {
    return Container(
      child: Column(
//          mainAxisAlignment:MainAxisAlignment.start,
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Image.asset(
                    'images/icon_app_type_b.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  icon: new Icon(Icons.close),
                  highlightColor: Colors.green[600],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'images/ic_users.png',
          ),
          Text(name, style: TextStyle(color: Colors.teal, fontSize: 20)),
          Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.teal,
                    ),
                    // تعيين الأيقونة
                    title: Text("بيانات الحساب",
                        style: TextStyle(color: Colors.teal, fontSize: 20)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserUpData()));
                    },
                  ),
                  Divider(),
                  ListTile(
                      leading:
                          Icon(Icons.credit_card_rounded, color: Colors.teal),
                      // تعيين الأيقونة
                      title: Text("اشتراكاتي",
                          style: TextStyle(color: Colors.teal, fontSize: 20)),
                      onTap: () {
                        PayMyPay.payMessage(context);
                      }),
                  Divider(),
//                    ListTile(
//                      leading: Icon(Icons.settings,color: Colors.teal), // تعيين الأيقونة
//                      title: Text("خدماتي",style: TextStyle(
//                          color: Colors.teal, fontSize: 20)),
//                      onTap: (){
//
//
//                      },
//                    ),
//                    Divider(),
                  ListTile(
                    leading: Icon(Icons.message, color: Colors.teal),
                    // تعيين الأيقونة
                    title: Text("راسلنا",
                        style: TextStyle(color: Colors.teal, fontSize: 20)),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.shield, color: Colors.teal),
                    // تعيين الأيقونة
                    title: Text("سياسة الاستخدام",
                        style: TextStyle(color: Colors.teal, fontSize: 20)),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    // تعيين الأيقونة
                    title: Text(
                      "تسجيل الخروج",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    onTap: () {
                      User_Data.removeValues();
                      App_Data.user_item = null;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                ],
              )),
        ],
      ),
    );
  }

  // واجهة تسجيل الدخول
  Container _SingIn(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image(
                      image: new AssetImage('images/icon.png'),
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: IconButton(
                      icon: new Icon(Icons.close),
                      highlightColor: Colors.green[600],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "تسجيل الدخول",
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // بيعمل كامل الشكل
//                           boxShadow: [BoxShadow(blurRadius: 7)],
                    border:
                        Border.all(color: Colors.amberAccent, width: 1) // الظل
                    ),
                child: Container(
                  width: 300,
                  child: Form(
                      key: key_form_stat,
                      child: Column(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                hintText: 'الايميل',
                                suffixIcon: Icon(Icons.email)),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return "يجب كتابة الايميل";
                              } else {
                                em = value;
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                hintText: 'كلمة المرور',
                                suffixIcon: Icon(Icons.vpn_key)),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return "يجب كتابة كلمة المرور التي لا تقل عن 6 حروف او ارقام";
                              } else {
                                pass = value;
                              }
                              return null;
                            },
                          )
                        ],
                      )),
                ),
              ),

//                              Text("هل نسيت كلمة السر",
//                                  textDirection: TextDirection.rtl,
//                                  style: TextStyle(
//                                      fontSize: 16,
//                                      fontWeight: FontWeight.bold,
//                                      color: Colors.blue)), //TODO

              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  child: Text("تسجيل الدخول",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.teal),
                    // الظل
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    // الهامش
                    minimumSize: MaterialStateProperty.all(const Size(330, 40)),
                    //ألطول والعرض

//                                side: MaterialStateProperty.all( // رسم خط حول الزر
//                                  const BorderSide(
//                                    color: Colors.red,
//                                    width: 2,
//                                  ),
//                                ),

                    // حواف مائلة
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green[700]),
                  ),
                  onPressed: () {
                    if (key_form_stat.currentState.validate()) {
                      // TODO الاتصال بالانترنت
                      API.user_login(em, pass).then((user) {
                        if (user != null || user.id != 0) {
                          key_scaffold.currentState.showSnackBar(SnackBar(
                            content: Text("تم تسجيل الدخول"),
                          ));
                          User_Data.saveUserData(
                              user.id,
                              user.name,
                              user.about,
                              user.email,
                              user.password,
                              user.sex,
                              user.age,
                              user.city,
                              user.country,
                              user.img);

                          App_Data.user_item = user;
//
//                              setState(() {
//
//                              });
                          Navigator.pop(context);
                        } else {
                          //كلمة المرور غير صحيحة او لا يوجد اتصال بالشبكة
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
                  }),

              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // بيعمل كامل الشكل
//                           boxShadow: [BoxShadow(blurRadius: 7)],
                    border: Border.all(color: Colors.black54, width: 1) // الظل
                    ),
                child: InkWell(
                    onTap: () {
                      // TODO ألذهاب للتسجيل
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserSingUp()));
                    },
                    child: Text(
                      "اذا لم تكن مسجل حساب من قبل يمكنك تسجيل حساب جديد بالضغط هنا",
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ]))
      ]),
    );
  }
}
