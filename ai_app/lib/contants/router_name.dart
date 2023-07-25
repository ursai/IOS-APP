import 'package:app/controller/login_controller.dart';
import 'package:app/pages/mine/login_page.dart';
import 'package:app/pages/nav_bar_page.dart';
import 'package:get/get.dart';

class RouterName {
  // 登录
  static const loginRouter = '/login';

  static final List<GetPage> routerNames = [
    GetPage(name: '/', page: () => const NavBarPage()),
    GetPage(
        name: loginRouter,
        page: () => const LoginPage(),
        binding: BindingsBuilder<LoginController>(() {
          Get.lazyPut(() => LoginController());
        }))
  ];
}
