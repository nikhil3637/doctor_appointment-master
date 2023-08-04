import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/providers/firebase_provider.dart';
import 'app/providers/laravel_provider.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/theme1_app_pages.dart';
import 'app/services/auth_service.dart';
import 'app/services/firebase_messaging_service.dart';
import 'app/services/global_service.dart';
import 'app/services/settings_service.dart';
import 'app/services/translation_service.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => GlobalService().init());
  try {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyDRNYzqnpHPenkiCmUdJhI01s8fQqHOBFA',
            appId: '1:87627482121:android:22b271fa9f202de36364d8',
            messagingSenderId: '87627482121',
            projectId: 'apnaopd-747bf'
        )
      );
  } catch (e) {
    print(e);
  }
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => LaravelApiClient().init());
  try {
    await Get.putAsync(() => FirebaseProvider().init());
  } catch (e) {
    print(e);
  }
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => TranslationService().init());
  Get.log('All services started...');
}

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initServices();

  bool isUserLoggedIn = await checkUserLoggedIn();

  runApp(
    GetMaterialApp(
      title: Get.find<SettingsService>().setting.value.appName ?? '',
      initialRoute: isUserLoggedIn ? Theme1AppPages.INITIAL : Routes.LOGIN, // Adjust this based on your route setup
      onReady: () async {
        FlutterNativeSplash.remove();
       await Get.putAsync(() => FireBaseMessagingService().init());
      },
      getPages: Theme1AppPages.routes,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<TranslationService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().getLocale(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      themeMode: Get.find<SettingsService>().getThemeMode(),
      theme: Get.find<SettingsService>().getLightTheme(),
      darkTheme: Get.find<SettingsService>().getDarkTheme(),
    ),
  );
}
Future<bool> checkUserLoggedIn() async {
  return await Get.find<AuthService>().isAuth; // Adjust this based on your AuthService
}