import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_world_reads/network/api.dart';
import 'package:the_world_reads/users/user_data.dart';
import 'package:the_world_reads/users/users_item.dart';

import '../Admin/app_data.dart';

class UserUpData extends StatefulWidget {
  User_Item _user_item = new User_Item();

  UserUpData(this._user_item);

  @override
  _UserUpDataState createState() => _UserUpDataState();
}

class _UserUpDataState extends State<UserUpData> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  final key_form_stat = GlobalKey<FormState>();
  final key_form_stat_pass = GlobalKey<FormState>();

  String name = "", email = "", password = "", password_2 = "",  country  ;
  int age = 0, six = 1;
//  List<String> contry = ["المملكة العربية السعودية", "مصر", "الإمارات العربية المتحدة", "البحرين", "الجزائر",
//    "السودان", "الصومال", "العراق", "الكويت", "اليمن", "تونس", "سلطنة عمان", "سوريا", "فلسطين",
//    "قطر","لبنان","ليبيا","المغرب"] ;

  @override
  void initState() {
    super.initState();

    name = widget._user_item.name ;
    email = widget._user_item.email ;
    age = widget._user_item.age ;
    country = widget._user_item.country ;
    password = widget._user_item.password;

    setState(() {

    });
  }

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
                                    }))
                          ],
                        ),
                        SizedBox(height: 100,),
                        Text(
                          "تعديل بياناتي",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Colors.teal, width: 1) // الظل
                              ),
                          child: Container(
                            width: 300,

                            child: Form(
                                key: key_form_stat,

                                child: Column(
                                  children: [

                                    TextFormField(
                                      textAlign: TextAlign.end,
                                      decoration: const InputDecoration(
                                          hintText: 'الاسم',
                                          suffixIcon: Icon(Icons.text_fields)),
                                      keyboardType: TextInputType.name,
                                      initialValue: widget._user_item.name,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 2) {
                                          return "يجب كتابة الاسم";
                                        } else {
                                          name = value;
                                        }
                                        return null;
                                      },
                                    ),

                                    TextFormField(
                                      textAlign: TextAlign.end,
                                      decoration: const InputDecoration(
                                          hintText: 'الايميل',
                                          suffixIcon: Icon(Icons.email)),
                                      initialValue: widget._user_item.email,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return "يجب كتابة الايميل بشكل صحيح !";
                                        } else {
                                          email = value;
                                        }
                                        return null;
                                      },
                                    ),

                                    TextFormField(
                                      textAlign: TextAlign.end,
                                      initialValue: "${widget._user_item.age}",
                                      decoration: const InputDecoration(
                                          hintText: 'العمر',
                                          suffixIcon:
                                          Icon(Icons.date_range_outlined)),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        //هذا عشان ما يكتب الا رقم بس
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 1) {
                                          return "يجب ادخال عمرك الصحيح !";
//                                    } else if (value.) {
                                        } else {
                                          age = int.parse(value);
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 10,),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding:
                                        const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Color(0xFF33b17c))),
                                        child: DropdownButton<String>(
//                                  elevation: 100,
                                          style: TextStyle(color: Colors.teal),
                                          items: <String>[
                                            "السعودية", "مصر", "الإمارات العربية المتحدة", "البحرين", "الجزائر",
                                            "السودان", "الصومال", "العراق", "الكويت", "اليمن", "تونس", "سلطنة عمان", "سوريا", "فلسطين",
                                            "قطر","لبنان","ليبيا","المغرب"
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: country,
                                          hint: const Text(
                                            "حدد الدولة",
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              country = value;
//                                      print(type_plan);
                                            });
                                          },
                                        ),
                                      ),
                                    ),

//                                    Row(
//                                      children: [
//                                        Expanded(
//                                          flex: 1,
//                                          child: Row(
//                                            children: [
//                                              Radio(
//                                                  value: 1, groupValue: six, onChanged: (index) {
//                                                setState(() {
//                                                  six = index ;
//                                                });
//                                              }),
//                                              const Expanded(
//                                                child: Text('ذكر'),
//                                              )
//                                            ],
//                                          ),
//                                        ),
//                                        Expanded(
//                                          flex: 1,
//                                          child: Row(
//                                            children: [
//                                              Radio(
//                                                  value: 2, groupValue: six, onChanged: (index) {
//                                                    setState(() {
//                                                      six = index ;
//                                                    });
//                                              }),
//                                              const Expanded(child: Text('انثئ'))
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ),


                                  ],
                                )),
                          ),
                        ),

                        ElevatedButton(
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.teal),
                              // الظل
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              // الهامش
                              minimumSize: MaterialStateProperty.all(
                                  const Size(325, 20)),
                              //ألطول والعرض

                              // حواف مائلة
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green[700]),
                            ),
                            onPressed: () {
                              if (key_form_stat.currentState.validate()) {
                                API.User_Updata(name, email , password , age, country).then((user) {
                                  if (user.id != 0) {
                                    key_scaffold.currentState.showSnackBar(const SnackBar(
                                      content: Text("تم حفظ البيانات"),
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
                            },
                            child: const Text("تعديل",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),


                        const SizedBox(height: 50,),


                        Text("تعديل كلمة المرور",
                          style: Theme.of(context).textTheme.headline5,),

                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              // بيعمل كامل الشكل
//                           boxShadow: [BoxShadow(blurRadius: 7)],
                              border: Border.all(
                                  color: Colors.teal, width: 1) // الظل
                              ),
                          child: SizedBox(
                            width: 300,
                            child: Form(
                                key: key_form_stat_pass,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: true,
                                      textAlign: TextAlign.end,
                                      decoration: const InputDecoration(
                                          hintText: 'كلمة المرور',
                                          suffixIcon: Icon(Icons.password)),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        String message ;
                                        if (value.isEmpty || value.length < 6) {
                                          return "يجب كتابة كلمة المرور ولا تقل عن 6 خانات !";

                                        }else if (!RegExp(".*[0-9].*").hasMatch(value ?? '')) {
                                            message ??= '';
                                            message += 'يجب ان تحتوي كلمة السر على رقم واحد على الاقل 1-9. ';
                                            return 'يجب ان تحتوي كلمة السر على رقم واحد على الاقل 1-9. ' ;
                                        }else if (!RegExp('.*[a-z].*').hasMatch(value ?? '')) {
                                            message ??= '';
                                            message += 'يجب ان تحتوي كلمة السر على حرف انجليزية على الاقل a-z. ';
                                            return 'يجب ان تحتوي كلمة السر على حرف انجليزية على الاقل a-z. ';

                                        } else {
                                          password = value;
                                        }
                                        return null;
                                      },
                                    ),


                                    TextFormField(
                                      obscureText: true,
                                      textAlign: TextAlign.end,
                                      decoration: const InputDecoration(
                                          hintText: 'تاكيد كلمة المرور',
                                          suffixIcon: Icon(Icons.password)),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return "يجب كتابة كلمة المرور ولا تقل عن 6 خانات !";
                                        } else if (value != password) {
                                          return "كلمة المرور غير متطابقة !";
                                        } else {
                                          password_2 = value;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.teal),
                              // الظل
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              // الهامش
                              minimumSize: MaterialStateProperty.all(
                                  const Size(325, 20)),
                              //ألطول والعرض
                              // حواف مائلة
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green[700]),
                            ),
                            onPressed: () {
                              if (key_form_stat_pass.currentState.validate()) {
                                API.User_Updata(name, email , password , age, country).then((user) {
                                  if (user.id != 0) {
                                    key_scaffold.currentState.showSnackBar(const SnackBar(
                                      content: Text("تم حفظ البيانات"),
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
                            },
                            child: const Text("تعديل كلمة المرور",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),

                        const SizedBox(height: 20,)

                      ],
                    ),
                  ]))
                ])
        )));
  }
}
