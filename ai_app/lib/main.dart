import 'dart:io';

import 'package:app/contants/business_constants.dart';
import 'package:app/contants/messages.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/models/chat_model.dart';
import 'package:app/network/network_config.dart';
import 'package:app/utils/app_route_observer.dart';
import 'package:app/utils/db_util.dart';
import 'package:app/utils/keyboard_util.dart';
import 'package:countly_flutter/countly_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter());

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
            initialRoute: '/',
          );
        });
  }

  Future<void> _initSpUtil() async {
    FlutterNativeSplash.remove();
    // 初始化Countly
    Countly.isInitialized().then((isInitialized) {
      if (!isInitialized) {
        CountlyConfig config = CountlyConfig('http://13.250.98.107/',
            '82764596f39b40bc91f7d8abef4b3b3c0baa17c0');
        config.setLoggingEnabled(true);
        config.enableCrashReporting();
        Countly.initWithConfig(config).then((value) {
          Countly.start();
        });
      } else {
        debugPrint("Countly: Already initialized.");
      }
    });

    await SpUtil.getInstance();
    // 初始化数据库
    DbUtil.shared;
    // 获取Token放入Headers
    NetworkConfig.headers['authorization'] =
        SpUtil.getString(BusinessConstants.tokenKey);
  }
}
