import 'dart:io';

import 'package:app/contants/business_constants.dart';
import 'package:app/contants/messages.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/network/network_config.dart';
import 'package:app/utils/app_route_observer.dart';
import 'package:app/utils/keyboard_util.dart';
import 'package:app/utils/store_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  runApp(AIApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class AIApp extends StatelessWidget {
  AIApp({super.key});

  final easyload = EasyLoading.init();

  @override
  Widget build(BuildContext context) {
    _initSpUtil();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
        designSize: const Size(390, 844),
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
            initialRoute: StoreUtil.isLogin() ? '/' : RouterName.loginRouter,
          );
        });
  }

  Future<void> _initSpUtil() async {
    FlutterNativeSplash.remove();

    await SpUtil.getInstance();
    // 获取Token放入Headers
    NetworkConfig.headers['authorization'] =
        SpUtil.getString(BusinessConstants.tokenKey);
  }
}
