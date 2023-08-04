import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/paypal_controller.dart';

class PayPalViewWidget extends GetView<PayPalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "PayPal Payment".tr,
          style: Get.textTheme.titleLarge?.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Obx(() {
            return WebViewWidget(
                controller: controller.webView,
               );
          }),
          Obx(() {
            if (controller.progress.value < 1) {
              return SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.2),
                ),
              );
            } else {
              return SizedBox();
            }
          })
        ],
      ),
    );
  }
}
