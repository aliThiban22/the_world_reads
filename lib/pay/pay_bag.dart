import 'package:flutter/material.dart';

class Pay_Bag extends StatefulWidget {
  @override
  _Pay_BagState createState() => _Pay_BagState();
}

class _Pay_BagState extends State<Pay_Bag> {
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
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text("الاشتراك الشهري"),
                      ),
                    ],
                  ))),

          body: Center(
            child: Column(
              children: [
                SizedBox(height: 200,),
                Text("تمتع بوصول غير محدود لكامل خدمات التطبيق",
                  style: TextStyle(fontSize: 18, color: Colors.teal),),
                SizedBox(height: 100,),

                ElevatedButton(
                    style: ButtonStyle(
                      shadowColor:
                      MaterialStateProperty.all(Colors.teal),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                      minimumSize: MaterialStateProperty.all(const Size(325, 20)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green[700]),
                    ),



                    onPressed: () {
                      // TODO بش مهندس عبدالله هنا بتتم عملية الاشتراك
                      // TODO سعر الاشتراك  7  دولار



                    },



                    child: const Text("الاشتراك",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20)))
              ],
            ),
          ),
        )
    );
  }
}
