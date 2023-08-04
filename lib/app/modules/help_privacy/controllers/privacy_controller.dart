
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../services/global_service.dart';

class PrivacyController extends GetxController {
  WebViewController webViewController = WebViewController();
  @override
  void onInit() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("${Get.find<GlobalService>().baseUrl}privacy/index.html"));
    super.onInit();
  }
}
