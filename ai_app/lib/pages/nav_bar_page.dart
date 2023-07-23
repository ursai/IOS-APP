import 'package:app/controller/nav_controller.dart';
import 'package:app/pages/chat/chat_page.dart';
import 'package:app/pages/discovery/discovery_page.dart';
import 'package:app/pages/mine/mine_page.dart';
import 'package:app/utils/app_route_observer.dart';
import 'package:app/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with RouteAware {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/shop.png',
          width: 24.w,
          height: 24.w,
        ),
        activeIcon: Image.asset(
          'assets/images/shop_selected.png',
          width: 24.w,
          height: 24.w,
        ),
        label: 'Discovery'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/mall.png',
          width: 24.w,
          height: 24.w,
        ),
        activeIcon: Image.asset(
          'assets/images/mall_selected.png',
          width: 24.w,
          height: 24.w,
        ),
        label: 'Chat'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/mine.png',
          width: 24.w,
          height: 24.w,
        ),
        activeIcon: Image.asset(
          'assets/images/mine_selected.png',
          width: 24.w,
          height: 24.w,
        ),
        label: 'Me'),
  ];
  final List<Widget> tabPages = [
    const DiscoveryPage(),
    const ChatPage(),
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
    _navController = Get.find();
  }

  @override
  Widget build(Object context) {
    FlutterNativeSplash.remove();

    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: bottomTabs,
            type: BottomNavigationBarType.fixed,
            currentIndex: _navController.tabIndex.value,
            unselectedItemColor: CommonUtil.hexColor(0xEEEDE9),
            selectedItemColor: CommonUtil.hexColor(0xE5FF73),
            onTap: (index) {
              _navController.tabIndex.value = index;
              _navController.pageController.jumpToPage(index);
            },
          )),
      body: PageView(
        controller: _navController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabPages,
        onPageChanged: (value) {},
      ),
    );
  }
}
