import 'package:flutter/material.dart';
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
                        Text(' ينتهي الاشتراك الشهري الخاص بك في '),
                        Divider(),
                        SizedBox(),
                        Text('${snapshot.data.date_end}'),
                        SizedBox(),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "موافق",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ]));
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
