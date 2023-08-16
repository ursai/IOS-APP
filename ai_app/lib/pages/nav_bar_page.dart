import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/chat_controller.dart';
import 'package:app/controller/discovery_controller.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/controller/nav_controller.dart';
import 'package:app/pages/chat/chat_list_page.dart';
import 'package:app/pages/discovery/discovery_page.dart';
import 'package:app/pages/mine/mine_page.dart';
import 'package:app/utils/app_route_observer.dart';
import 'package:app/utils/store_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flustars/flustars.dart' as flustars;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with RouteAware {
  final List<Widget> tabPages = [
    const DiscoveryPage(),
    const ChatListPage(),
    MinePage(),
  ];

  late NavController _navController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    super.dispose();
    AppRouteObserver().routeObserver.unsubscribe(this);
  }

  @override
  void initState() {
    super.initState();

    Get.put(NavController());
    Get.put(DisCoveryController());
    Get.put(MineController());
    Get.put(ChatController());

    _navController = Get.find();
  }

  @override
  Widget build(Object context) {
    _isLogin();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 88.w + ScreenUtil().bottomBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildItems(),
        ),
      ),
      body: PageView(
        controller: _navController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabPages,
        onPageChanged: (value) {},
      ),
    );
  }

  // 判断是否需要登录
  void _isLogin() async {
    await flustars.SpUtil.getInstance();
    if (StoreUtil.isLogin() == false) {
      Get.offAllNamed(RouterName.loginRouter);
    } else {
      // 申请权限
      NotificationSettings settings = await FirebaseMessaging.instance
          .requestPermission(announcement: true, carPlay: true);
      // 上报推送token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        _navController.updatePushToken(fcmToken);
      }
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        _navController.updatePushToken(fcmToken);
      }).onError((err) {
        err.printError();
      });
      debugPrint(fcmToken);
    }
  }

  List<Widget> _buildItems() {
    List<Widget> items = [];
    Map<int, String> textMap = {0: 'Discovery', 1: 'Chat', 2: 'Me'};
    Map<int, Widget> iconMap = {
      0: Image.asset('assets/images/discovery.png', width: 24.w, height: 24.w),
      1: Image.asset('assets/images/chat.png', width: 24.w, height: 24.w),
      2: Image.asset('assets/images/me.png', width: 24.w, height: 24.w)
    };
    Map<int, Widget> activeIconMap = {
      0: Image.asset('assets/images/discovery_selected.png',
          width: 24.w, height: 24.w),
      1: Image.asset('assets/images/chat_selected.png',
          width: 24.w, height: 24.w),
      2: Image.asset('assets/images/me_selected.png', width: 24.w, height: 24.w)
    };

    for (int i = 0; i < 3; i++) {
      items.add(GestureDetector(
          onTap: () {
            _navController.tabIndex.value = i;
            _navController.pageController.jumpToPage(i);
          },
          child: Obx(() => Container(
                width: 70.w,
                height: 64.w,
                decoration: _navController.tabIndex.value == i
                    ? const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                '${BusinessConstants.imgPathPrefix}/nav_selected_bg.png'),
                            fit: BoxFit.fill))
                    : const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _navController.tabIndex.value == i
                        ? activeIconMap[i]!
                        : iconMap[i]!,
                    Text(
                      textMap[i]!,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: _navController.tabIndex.value == i
                              ? Colors.white
                              : Colors.black),
                    )
                  ],
                ),
              ))));
    }

    return items;
  }
}
