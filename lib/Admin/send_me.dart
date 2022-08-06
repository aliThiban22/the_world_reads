import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Sind_Me extends StatefulWidget {
  @override
  _Sind_MeState createState() => _Sind_MeState();
}

class _Sind_MeState extends State<Sind_Me> {
  final key_form_read_book = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String title , body , email;

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
                        flex: 5,
                        child: Text(
                          "راسلنا",
                        ),
                      ),
                    ],
                  ))),


          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    const Text("نستقبل رسائلكم ومقترحاتكم واستفساراتكم عبر الايميل الخاص بنا",
                    style: TextStyle(fontSize: 20, color: Colors.teal),
                    textAlign: TextAlign.center),

                    SizedBox(height: 20,),

                    Form(
                        key: key_form_read_book,

                        child: Directionality(
                            textDirection: TextDirection.rtl,

                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
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
                                        return 'يجب كتابة عنوان صحيح ';
                                      } else {
                                        title = value;
                                        return null;
                                      }
                                    },
                                    maxLength: 30,
                                    onSaved: (value) =>
                                        setState(() => title = value),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      labelText: 'الموضوع :',
                                      labelStyle: TextStyle(color: Color(0xFF33b17c)),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFF33b17c))),
                                    ),
                                    validator: (value) {
                                      if (value.length < 2) {
                                        return 'يجب كتابة موضوع صحيح ';
                                      } else {
                                        body = value;
                                        return null;
                                      }
                                    },
                                    maxLength: 500,
                                    onSaved: (value) =>
                                        setState(() => body = value),
                                  ),
                                ),

                                ElevatedButton(
                                    style: ButtonStyle(
                                      shadowColor: MaterialStateProperty.all(Colors.teal),
                                      // الظل
                                      padding:
                                      MaterialStateProperty.all(const EdgeInsets.all(10)),
                                      // الهامش
                                      minimumSize: MaterialStateProperty.all(const Size(330, 20)),

                                      // حواف مائلة
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),

                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors.green[700]),
                                    ),
                                    onPressed: ()async {
                                      if (key_form_read_book.currentState.validate()) {
                                          final Email email = Email(
                                            body: body,
                                            subject: title,
                                            recipients: ["world.reads.2023@gmail.com"],
                                            isHTML: false,
                                          );
                                          await FlutterEmailSender.send(email);
                                        }
                                      },
                                    child: const Text("ارسال",
                                        style: TextStyle(color: Colors.white, fontSize: 20))),

                                const SizedBox(height: 30,)
                              ],
                            )
                        )
                    )

                  ],
                ),
              ),
            ),
          ),


        ));
  }
}
