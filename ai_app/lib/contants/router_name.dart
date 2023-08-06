import 'package:app/controller/login_controller.dart';
import 'package:app/pages/chat/chat_page.dart';
import 'package:app/pages/discovery/profile_page.dart';
import 'package:app/pages/mine/login_page.dart';
import 'package:app/pages/mine/login_register_page.dart';
import 'package:app/pages/mine/set_username_page.dart';
import 'package:app/pages/nav_bar_page.dart';
import 'package:get/get.dart';

class RouterName {
  // 登录
  static const loginRouter = '/login';
  static const loginRegisterRouter = '/loginRegister';
  static const usernameRouter = '/usernameRegister';
  static const profileRouter = '/profileRoute';
  static const chatPageRouter = '/chatPageRoute';

  static final List<GetPage> routerNames = [
    GetPage(name: '/', page: () => const NavBarPage()),
    GetPage(
        name: loginRouter,
        page: () => const LoginPage(),
        binding: BindingsBuilder<LoginController>(() {
          Get.lazyPut(() => LoginController());
        })),
    GetPage(name: loginRegisterRouter, page: () => LoginRegisterPage()),
    GetPage(name: usernameRouter, page: () => SetUserNamePage()),
    GetPage(name: profileRouter, page: () => const ProfilePage()),
    GetPage(name: chatPageRouter, page: () => ChatPage()),
  ];
}
