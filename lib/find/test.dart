import 'dart:ui';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
          body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {}, // Image tapped
                child: Image.asset(
                  'images/img_aa.png',
                  fit: BoxFit.cover, // Fixes border issues
                  width: 110.0,
                  height: 110.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {}, // Image tapped
                child: Image.asset(
                  'images/img_aa.png',
                  fit: BoxFit.cover, // Fixes border issues
                  width: 110.0,
                  height: 110.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {}, // Image tapped
                child: Image.asset(
                  'images/img_aa.png',
                  fit: BoxFit.cover, // Fixes border issues
                  width: 110.0,
                  height: 110.0,
                ),
              ),
            ),
            ListView.separated(
//                scrollDirection: Axis.horizontal,
              itemCount: 30,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Text(
                    'ddd',
                    textDirection: TextDirection.rtl,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
            ),

            Container(
              height: 100,
//                    width: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
//                      shrinkWrap: true,
//                      physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'ddd',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            ),

//                  Container(
//                    // Change the height until the problem is solved
//                    height: 140,
//                    child: ListView.separated(
//                        scrollDirection: Axis.horizontal,
//                        itemBuilder: (context , index) => buildStory(),
//                        separatorBuilder: (context , index) => SizedBox(width: 15,),
//                        itemCount: 20),
//                  ),
          ],
        )),
//        child: CustomScrollView(
//          slivers: [
//            SliverList(
//                delegate: SliverChildListDelegate([
//                  ListView.separated(
//                    scrollDirection: Axis.horizontal,
//                    itemCount: 10,
//                    itemBuilder: (context, index) {
//                      return InkWell(
//                            onTap: () {},
//                              child: Text(
//                                'ddd',
//                                textDirection: TextDirection.rtl,
//                              ),
//                          );
//                    },
//                    separatorBuilder: (context, index) => Divider(),
//                  )
//            ]))
//          ],
//        ),
      )),
    );
  }

  Widget buildStory() => Container(
        width: 60,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://images.milledcdn.com/2020-09-07/7K4PQLg4D1D_kROF/9Pvr832Ur5nk.png'),
                ),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.grey[900],
                ),
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.red[300],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                padding: EdgeInsetsDirectional.only(start: 5),
                child: Text(
                  "Ahmed mahmoud",
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      );
}
