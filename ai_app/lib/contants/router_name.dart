import 'package:app/controller/login_controller.dart';
import 'package:app/pages/chat/chat_page.dart';
import 'package:app/pages/discovery/profile_page.dart';
import 'package:app/pages/mine/login_page.dart';
import 'package:app/pages/mine/login_register_page.dart';
import 'package:app/pages/mine/mine_about_page.dart';
import 'package:app/pages/mine/mine_birth_page.dart';
import 'package:app/pages/mine/mine_profile_page.dart';
import 'package:app/pages/mine/mine_setting.dart';
import 'package:app/pages/mine/mine_sex_page.dart';
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
  static const minSettingPageRouter = '/mineSettingPageRoute';
  static const mineAboutRouter = '/mineAboutRouter';
  static const mineProfileRouter = '/mineProfileRouter';
  static const mineSexRouter = '/mineSexRouter';
  static const mineBirthRouter = '/mineBirthRouter';

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
    GetPage(name: minSettingPageRouter, page: () => const MineSetting()),
    GetPage(name: mineAboutRouter, page: () => MineAboutPage()),
    GetPage(name: mineProfileRouter, page: () => MineProfilePage()),
    GetPage(name: mineSexRouter, page: () => const MineSexPage()),
    GetPage(name: mineBirthRouter, page: () => const MineBirthPage()),
  ];
}
