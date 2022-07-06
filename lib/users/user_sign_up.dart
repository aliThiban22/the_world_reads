import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_world_reads/users/user_data.dart';

import '../network/api.dart';

class UserSingUp extends StatefulWidget {
  @override
  _UserSingUpState createState() => _UserSingUpState();
}

class _UserSingUpState extends State<UserSingUp> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  final key_form_stat = GlobalKey<FormState>();
  String edName, edEmail, edEmailTow, edPass, edPassTow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ازاله البانر العلويه
      home: Scaffold(
        key: key_scaffold,
        body: Container(
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
                    "التسجيل",
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
                        border: Border.all(
                            color: Colors.amberAccent, width: 1) // الظل
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
                                    hintText: 'الاسم',
                                    suffixIcon:
                                        Icon(Icons.supervised_user_circle)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 2) {
                                    return "يجب كتابة الاسم";
                                  } else {
                                    edName = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    hintText: 'البريد الالكتروني',
                                    suffixIcon: Icon(Icons.email)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return "يجب كتابة الايميل";
                                  } else {
                                    edEmail = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    hintText: 'تاكيد البريد الالكتروني',
                                    suffixIcon: Icon(Icons.email)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return "يجب كتابة الايميل";
                                  } else if (value != edEmail) {
                                    return "الايميل غير متطابق";
                                  } else {
                                    edEmailTow = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    hintText: 'كلمة المرور',
                                    suffixIcon: Icon(Icons.vpn_key)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return "يجب كتابة كلمة المرور التي لا تقل عن 6 حروف او ارقام";
                                  } else {
                                    edPass = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    hintText: 'تاكيد كلمة المرور',
                                    suffixIcon: Icon(Icons.vpn_key)),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return "يجب كتابة كلمة المرور التي لا تقل عن 6 حروف او ارقام";
                                  } else if (value != edPass) {
                                    return "الايميل غير متطابق";
                                  } else {
                                    edPassTow = value;
                                  }
                                  return null;
                                },
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      child: Text("التسجيل",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.teal),
                        // الظل
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        // الهامش
                        minimumSize:
                            MaterialStateProperty.all(const Size(330, 40)),
                        //ألطول والعرض
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
                          API
                              .user_Sing_Up(edName, edEmail, edPass)
                              .then((user) {
                            if (user != null || user.id != 0) {
                              key_scaffold.currentState.showSnackBar(SnackBar(
                                content: Text("تم التسجيل بنجاح"),
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
                ],
              ),
            ]))
          ]),
        ),
      ),
    );
  }
}
