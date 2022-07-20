
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_world_reads/Media_Book/book_item.dart';
import 'package:the_world_reads/pay/pay_bag.dart';
import 'package:the_world_reads/pay/pay_item.dart';

import '../Media_Book/book_read.dart';
import '../network/api.dart';
import '../users/user_data.dart';

class Pay_Data{

  static PayItem _payItem_reel;
  static PayItem _payItem_free;

  static int conn_pay_reel = 0;
  static int conn_pay_free = 0;


  // التحقق من الخطة المجانية
  static void payFree() {
    API.Pay_Real_Get().then((pay) {
      if (pay != null || pay.id != 0) {
        _payItem_free = pay;
        conn_pay_free = 1;
      } else {
        _payItem_free = null;
        conn_pay_free = 0;
      }
    });
  }


  // البدء بتحقق من الاشتراك
  static Future<void> payStart(BuildContext context) async {
    int id_user = await User_Data.getUserDataId() ;

    if(id_user != 0 ) {// المستخدم مسجل الدخول
      pay_Message(context);

//      if (conn_pay == 1) { //تم الاتصال
//        if (_payItem.type == 1) { //تم الاشتراك
//          // الدخول
//          //TODO
//          Navigator.push(
//              context, MaterialPageRoute(
//              builder: (context) => gggggggggggggggg));
//
//        } else { //لم يشترك
//          // عرض الرسالة للاشتراك
//        }
//      } else { // لم يتم الاتصال
//        // الاتصال
//        API.Pay_Real_Get().then((pay) {
//          if (pay != null || pay.id != 0) {
//            _payItem = pay;
//            conn_pay = 1;
//            Navigator.push(
//                context, MaterialPageRoute(
//                builder: (context) => gggggggggggggggg));
//
//          } else {
//            _payItem = null;
//            conn_pay = 0;
//          }
//        });
//      }


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

  // عرض رسالة الاشتراك
  static pay_Message(BuildContext context){

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
            children: [

          FutureBuilder<PayItem>(
            future: API.Pay_Real_Get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                  if (snapshot.data.type == 1) { //تم الاشتراك
                    // الدخول
//                    Navigator.push(
//                        context, MaterialPageRoute(
//                        builder: (context) => gggggggggggggggg));
//

                    Navigator.pop(context);

                  } else { //لم يشترك
                    // عرض الرسالة للاشتراك
                    return Column(
                      children: [

                        Text("مرحبا بك في تطبيق العالم يقرأ"),
                        Text("تمتع بكافة مميزات التطبيق بجميع اقسامة"),
                        Text("يمكنك البدء بتجربة مجانية لمدة 3 ايام"),

                        Row(
                          children: [
                            // الخطة المجانية
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
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
//                                          Navigator.push(
//                                              context, MaterialPageRoute(
//                                              builder: (context) => gggggggggggggggg));


                                        }else{

                                          Fluttertoast.showToast(
                                              msg: 'انتهت الخطة المجانية',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.yellow);

                                        }
                                        Navigator.pop(context);

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
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),


                            // الشراء الحقيقي
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    // TODO
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => Pay_Bag()));

                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "البدء بالاشتراك الشهري",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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

}