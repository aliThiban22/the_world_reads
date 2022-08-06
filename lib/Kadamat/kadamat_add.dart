import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../network/api.dart';

class Kadamat_add extends StatefulWidget {
  const Kadamat_add({Key key}) : super(key: key);

  @override
  State<Kadamat_add> createState() => _Kadamat_addState();
}

class _Kadamat_addState extends State<Kadamat_add> {

  final key_form_stat = GlobalKey<FormState>();
  List<String> list_title = [
    "خدمات تطوير القراءة والاستماع",
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
  String v_type, title = "", body = "", img = "", time_post = "";
  int _type = 0, price = 0, number_day = 0;
  BuildContext cxn ;

  //--------------------------------------------------------------------------------------------------
  File _image;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
//--------------------------------------------------------------------------------------------------

  // رفع الصورة
  Upload(File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://storys.esy.es/images/kadamat/");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      if ( response.statusCode == 200 ) {

        img = basename( imageFile.path ) ;

        API.Kadamat_Add(title, body, img, price, _type, number_day, time_post , cxn).then((item) {
          print(item);

            Fluttertoast.showToast(
                msg: "تم اضافة الخدمة",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.teal,
                textColor: Colors.yellow);

            Navigator.pop(cxn);


        });

      } else {
        // فشلت العملية
        Fluttertoast.showToast(
            msg: "فشل الاتصال بالشبكة ،، اعد المحاولة مجدداً",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);

      }
      // print(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // ازاله البانر العلويه
        home: Scaffold(
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 40,
            width: (MediaQuery.of(context).size.width),
            color: Colors.teal,
            child: InkWell(
              onTap: () {
                if(key_form_stat.currentState.validate()){

                  if(_type == 0){
                    Fluttertoast.showToast(
                        msg: "يجب تحديد قسم الخدمة اولاً ..",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.yellow);

                  }else if(_image == null ){

                    Fluttertoast.showToast(
                        msg: "يجب اضافة صورة اولاً ...",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.yellow);

                  }else{
                    cxn = context ;
                    Upload(_image);

                  }

                }
              },
              child: const Center(
                child: Text(
                  "نشر",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
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
                        child: Text("اضافة خدمة جديدة"),
                        flex: 7,
                      ),
                    ],
                  ))),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: book(),
            ),
          ),
        ));
  }

  Widget book() {
    return Form(
      key: key_form_stat,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFF33b17c))),
                  child: DropdownButton<String>(
                    value: v_type,
//                                  elevation: 100,
                    style: TextStyle(color: Colors.teal),
                    items: <String>[
                      'خدمات تطوير القراءة والاستماع',
                      'خدمات البحث العلمي',
                      'خدمات الكتابة والتحرير والترجمة',
                      'خدمات التصميم والمنتاج',
                      'خدمات الترجمة والتطبيقات والمواقع',
                      'خدمات الفنون',
                      'خدمات الاعلان والنشر والتسويق',
                      'الخدمات القانونية',
                      'خدمات الوظائف التعليمية',
                      'خدمات الاستشارات والدراسات',
                      'خدمات التدريب والتعليم عن بعد',
                      'اخرئ',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text(
                      "حدد قسم الخدمة :",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _type = getType(value);
                        v_type = value;
//                print(type_plan);
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: "$title",
                  decoration: const InputDecoration(
                    labelText: 'عنوان الخدمة :',
                    labelStyle: TextStyle(color: Color(0xFF33b17c)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF33b17c))),
                  ),
                  validator: (value) {
                    if (value.length < 2) {
                      return 'يجب تحديد عنوان صحيح ';
                    } else {
                      title = value;
                      return null;
                    }
                  },
                  maxLength: 30,
                  onSaved: (value) => setState(() => title = value),
                ),
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: "$body",
                  decoration: const InputDecoration(
                    labelText: 'تفاصيل الخدمة :',
                    labelStyle: TextStyle(color: Color(0xFF33b17c)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF33b17c))),
                  ),
                  validator: (value) {
                    if (value.length < 2) {
                      return 'يجب كتابة التفاصيل ';
                    } else {
                      body = value;
                      return null;
                    }
                  },
                  onSaved: (value) => setState(() => body = value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    //هذا عشان ما يكتب الا رقم بس
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  // initialValue: "$price",
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الميزانية المتوقعة :',
                    labelStyle: TextStyle(color: Color(0xFF33b17c)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF33b17c))),
                  ),
                  validator: (value) {
                    if (value.length < 1) {
                      return 'يجب تحديد الميزانية ';
                    } else {
                      price = int.parse(value);
                      return null;
                    }
                  },
                  maxLength: 7,
                  onSaved: (value) => setState(() => price = int.parse(value)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    //هذا عشان ما يكتب الا رقم بس
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  // initialValue: "$number_day",
                  decoration: const InputDecoration(
                    labelText: 'عدد الايام المتوقعة للتسليم :',
                    labelStyle: TextStyle(color: Color(0xFF33b17c)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF33b17c))),
                  ),
                  validator: (value) {
                    if (value.length < 1) {
                      return 'يجب كتابة الايام ';
                    } else {
                      number_day = int.parse(value);
                      return null;
                    }
                  },
                  maxLength: 5,
                  onSaved: (value) => setState(() => number_day = int.parse(value)),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.teal, width: 1) // الظل
                ),
                child: get_img_app(),
              )
            ],
          )),
    );
  }

  int getType(String tt) {
    if (tt.compareTo("خدمات تطوير القراءة والاستماع") == 0) {
      return 1;
    } else if (tt.compareTo("خدمات البحث العلمي") == 0) {
      return 2;
    } else if (tt.compareTo("خدمات الكتابة والتحرير والترجمة") == 0) {
      return 3;
    } else if (tt.compareTo("خدمات التصميم والمنتاج") == 0) {
      return 4;
    } else if (tt.compareTo("خدمات الترجمة والتطبيقات والمواقع") == 0) {
      return 5;
    } else if (tt.compareTo("خدمات الفنون") == 0) {
      return 6;
    } else if (tt.compareTo("خدمات الاعلان والنشر والتسويق") == 0) {
      return 7;
    } else if (tt.compareTo("الخدمات القانونية") == 0) {
      return 8;
    } else if (tt.compareTo("خدمات الوظائف التعليمية") == 0) {
      return 9;
    } else if (tt.compareTo("خدمات الاستشارات والدراسات") == 0) {
      return 10;
    } else if (tt.compareTo("خدمات التدريب والتعليم عن بعد") == 0) {
      return 11;
    } else if (tt.compareTo("اخرئ") == 0) {
      return 12;
    }
  }

  // جلب الصور للايفون
  Widget get_img_app() {
    return Column(
      children: [
        MaterialButton(
            color: Colors.teal,
            child: const Text("اضغط لتحديد صورة",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              _openImagePicker();
            }),

        const SizedBox(height: 50,),

        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 300,
          color: Colors.grey[300],
          child: _image != null
              ? Image.file(_image, fit: BoxFit.cover)
              : const Text('Please select an image'),
        ),
      ],
    );
  }

}
