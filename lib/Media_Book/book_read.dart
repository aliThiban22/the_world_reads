import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';

import '../network/api.dart';
import 'book_item.dart';

class Book_Read extends StatefulWidget {
  Book_Item _book_item;

  Book_Read(this._book_item);

  @override
  _Book_ReadState createState() => _Book_ReadState();
}

class _Book_ReadState extends State<Book_Read> {
  Size get screenSize => MediaQuery.of(context).size;
  WebViewXController webviewController;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ازاله البانر العلويه
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
          title: Container(
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
                  flex: 9,
                  child: Text(
                    widget._book_item.title,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
              ),
        ),
        body:Container(
          child: Container(
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: WebViewX(
                        initialContent:
                        // "http://www.storys.esy.es/book/reading/reader.php?id=%D8%A7%D9%84%D8%B5%D8%AD%D8%A7%D9%81%D8%A9_%D8%A7%D9%84%D9%85%D8%AA%D8%AE%D8%B5%D8%B5%D8%A9.epub",
//                        "http://www.storys.esy.es/book/reading/reader.php?id=${widget._book_item.book_url.toString()}",
//          'https://flutter.dev',
         'https://c-yemhs.org/test/QiuReader/reader.html',
                        initialSourceType: SourceType.url,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        onWebViewCreated: (controller) =>
                        webviewController = controller,
                        onPageStarted: (src) =>
                            debugPrint('A new page has started loading: $src\n'),
                        onPageFinished: (src) =>
                            debugPrint('The page has finished loading: $src\n'),
                        jsContent: const {
                          EmbeddedJsContent(
                            js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
                          ),
                          EmbeddedJsContent(
                            webJs:
                            "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
                            mobileJs:
                            "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
                          ),
                        },
                        dartCallBacks: {
                          DartCallback(
                            name: 'TestDartCallback',
                            callBack: (msg) =>
                                showSnackBar(msg.toString(), context),
                          )
                        },
                        webSpecificParams: const WebSpecificParams(
                          printDebugInfo: true,
                        ),
                        mobileSpecificParams: const MobileSpecificParams(
                          androidEnableHybridComposition: true,
                        ),
                        // navigationDelegate: (navigation) {
                        //   debugPrint(navigation.content.sourceType.toString());
                        //   return NavigationDecision.navigate;
                        // },
                      )),
//TODO
//                  Expanded(
//                    flex: 1,
//                    child: get_AudioPlayers(),
//                  )
                ],
              )),
        ),
      ),
    );
  }

  void showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
          duration: const Duration(seconds: 1),
        ),
      );
  }


}
