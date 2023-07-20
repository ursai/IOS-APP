import 'dart:io';

import 'package:app/contants/messages.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/utils/app_route_observer.dart';
import 'package:app/utils/keyboard_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(FMApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class FMApp extends StatelessWidget {
  FMApp({super.key});

  final easyload = EasyLoading.init();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            builder: (context, child) {
              child = easyload(context, child);
              child = Scaffold(
                  // Global GestureDetector that will dismiss the keyboard
                  body: GestureDetector(
                onTap: () => KeyboardUtils.hideKeyboard(context),
                child: child,
              ));

              return child;
            },
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('zh', 'CN'),
            translations: Messages(),
            navigatorObservers: [AppRouteObserver().routeObserver],
            defaultTransition: Transition.cupertino,
            getPages: RouterName.routerNames,
            initialRoute: '/',
          );
        });
  }
}
