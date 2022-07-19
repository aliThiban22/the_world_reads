import 'package:flutter/material.dart';

class Sind_Me extends StatefulWidget {
  @override
  _Sind_MeState createState() => _Sind_MeState();
}

class _Sind_MeState extends State<Sind_Me> {
  final key_form_read_book = GlobalKey<FormState>();

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
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 9,
                        child: Text(
                          "راسلنا",
                        ),
                      ),
                    ],
                  ))),


          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              child: Column(
                children: [
                  const Text("نستقبل رسائلكم ومقترحاتكم واستفساراتكم عبر الايميل الخاص بنا"),

                  Form(
                      key: key_form_read_book,

                      child: Directionality(
                          textDirection: TextDirection.rtl,

                          child: Column(
                            children: [

//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: TextFormField(
//                                  decoration: const InputDecoration(
//                                    labelText: 'العنوان :',
//                                    labelStyle: TextStyle(
//                                        color: Color(0xFF33b17c)),
//                                    border: OutlineInputBorder(),
//                                    focusedBorder: OutlineInputBorder(
//                                        borderSide:
//                                        BorderSide(color: Color(0xFF33b17c))),
//                                  ),
//                                  validator: (value) {
//                                    if (value.length < 2) {
//                                      return 'يجب تحديد عنوان صحيح ';
//                                    } else {
//                                      title_book = value;
//                                      return null;
//                                    }
//                                  },
//                                  maxLength: 30,
//                                  onSaved: (value) =>
//                                      setState(() => title_book = value),
//                                ),
//                              ),

                            ],
                          )
                      )
                  )

                ],
              ),
            ),
          ),


        ));
  }
}
