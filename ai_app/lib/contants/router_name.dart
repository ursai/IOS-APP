import 'package:app/pages/nav_bar_page.dart';
import 'package:get/get.dart';

class RouterName {
  static final List<GetPage> routerNames = [
    GetPage(name: '/', page: () => const NavBarPage())
  ];
}
