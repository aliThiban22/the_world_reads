import 'package:flutter/material.dart';
import 'package:the_world_reads/pay/pay_bag.dart';
import 'package:the_world_reads/pay/pay_item.dart';

import '../network/api.dart';

class PayMyPay {
  static PayItem _payItem;

  static int conn_pay = 0;

  static void payMessage(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: [
//              Visibility(child: null),
//              Center(child: CircularProgressIndicator(),),
              FutureBuilder<PayItem>(
                future: API.Pay_Real_Get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    return Column(
                      children: [
                        const SizedBox(height: 20,),

                        const Text(' ينتهي الاشتراك الشهري الخاص بك في '),
                        const Divider(),
                        const SizedBox(),
                        no_pay_or_end_pay(snapshot.data.date_end, snapshot.data.type, context),
                        const SizedBox(height: 20,),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "اخفاء",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('لا يوجد اتصال بالشبكة !');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ]));
  }

  static Widget no_pay_or_end_pay(String date_end, int type, BuildContext context){
    if(type == null || type != 1){

      return InkWell(
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => Pay_Bag()));

        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(" لا يوجد لديك اشتراكات نشطة اضغط هنا للتجديد",
            style: TextStyle(color: Colors.teal, fontSize: 20,),textAlign: TextAlign.center),
        ),
      );

    }else {
      return Text(date_end);

    }
  }

  // التحقق من الاشتراك الشهري
  static void payMyData() {
    API.Pay_Real_Get().then((pay) {
      if (pay != null || pay.id != 0) {
        _payItem = pay;
        conn_pay = 1;
      } else {
        _payItem = null;
        conn_pay = 0;
      }
    });
  }
}
