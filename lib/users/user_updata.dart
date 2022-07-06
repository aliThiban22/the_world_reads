import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserUpData extends StatefulWidget {
  @override
  _UserUpDataState createState() => _UserUpDataState();
}

class _UserUpDataState extends State<UserUpData> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  final key_form_stat = GlobalKey<FormState>();
  final key_form_stat_pass = GlobalKey<FormState>();
  String name, email, password, city, country;

  int age;

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
                        SizedBox(
                          height: 100,
                        ),
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
                                      decoration: InputDecoration(
                                          hintText: 'الاسم',
                                          suffixIcon: Icon(Icons.text_fields)),
                                      keyboardType: TextInputType.name,
                                      initialValue: "sssssssssssss",
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
                                      decoration: InputDecoration(
                                          hintText: 'الايميل',
                                          suffixIcon: Icon(Icons.email)),
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
                                    DropdownButton<String>(
                                      items: <String>['A', 'B', 'C', 'D']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                    TextFormField(
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
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
                                          int.parse(value);
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        ElevatedButton(
                            child: Text("تعديل",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.teal),
                              // الظل
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              // الهامش
                              minimumSize: MaterialStateProperty.all(
                                  const Size(330, 40)),
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
                              if (key_form_stat.currentState.validate()) {}
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "تعديل كلمة المرور",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // بيعمل كامل الشكل
//                           boxShadow: [BoxShadow(blurRadius: 7)],
                              border: Border.all(
                                  color: Colors.teal, width: 1) // الظل
                              ),
                          child: Container(
                            width: 300,
                            child: Form(
                                key: key_form_stat_pass,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: true,
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          hintText: 'كلمة المرور',
                                          suffixIcon: Icon(Icons.password)),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return "يجب كتابة كلمة المرور ولا تقل عن 6 خانات !";
                                        } else {
                                          password = value;
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          hintText: 'تاكيد كلمة المرور',
                                          suffixIcon: Icon(Icons.password)),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return "يجب كتابة كلمة المرور ولا تقل عن 6 خانات !";
                                        } else if (value != password) {
                                          return "كلمة المرور غير متطابقة !";
                                        } else {
                                          password = value;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        ElevatedButton(
                            child: Text("تعديل كلمة المرور",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.teal),
                              // الظل
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              // الهامش
                              minimumSize: MaterialStateProperty.all(
                                  const Size(330, 40)),
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
                              if (key_form_stat_pass.currentState.validate()) {}
                            }),
                      ],
                    ),
                  ]))
                ]))));
  }
}
