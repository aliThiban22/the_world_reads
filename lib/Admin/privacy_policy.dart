import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class Privacy_Policy extends StatefulWidget {
  @override
  _Privacy_PolicyState createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: WebViewX(
          initialContent:
          'https://sites.google.com/view/world-reads-privacy-policy/privacy-policy',
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
        )
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
