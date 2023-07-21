import 'package:app/pages/chat/chat_page.dart';
import 'package:app/pages/discovery/discovery_page.dart';
import 'package:app/pages/mine/mine_page.dart';
import 'package:app/utils/app_route_observer.dart';
import 'package:app/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    const MinePage(),
  ];

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
  }

  @override
  Widget build(Object context) {
    FlutterNativeSplash.remove();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        unselectedItemColor: CommonUtil.hexColor(0xEEEDE9),
        selectedItemColor: CommonUtil.hexColor(0xE5FF73),
        onTap: (index) {},
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: tabPages,
        onPageChanged: (value) {},
      ),
    );
  }
}
