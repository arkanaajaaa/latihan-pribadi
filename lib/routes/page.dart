import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/bindings/loginAPIBinding.dart';
import 'package:latihan_pribadiiflutter/pages/Player_edit_page.dart';
import 'package:latihan_pribadiiflutter/pages/bottom_nav_page.dart';
import 'package:latihan_pribadiiflutter/pages/calculator_page.dart';
import 'package:latihan_pribadiiflutter/pages/homepagenotif.dart';
import 'package:latihan_pribadiiflutter/pages/login_page.dart';
import 'package:latihan_pribadiiflutter/pages/loginAPIPage.dart';
import 'package:latihan_pribadiiflutter/pages/player_list_page.dart';
import 'package:latihan_pribadiiflutter/routes/routes.dart';
import 'package:latihan_pribadiiflutter/bindings/table_premiere_binding.dart';
import 'package:latihan_pribadiiflutter/pages/table_premiere_page.dart';

class AppPages {
  static final pages = [
    // Login API dengan Binding
    GetPage(
      name: AppRoutes.loginAPI,
      page: () => const LoginAPIPage(),
      binding: LoginAPIBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.calculator,
      page: () => const CalculatorPage(),
    ),
    GetPage(
      name: AppRoutes.playerList,
      page: () => PlayerListPage(),
    ),
    GetPage(
      name: AppRoutes.playerEdit,
      page: () => const PlayerEditPage(),
    ),
    GetPage(
      name: AppRoutes.bottomNavPage,
      page: () => BottomNavPage(),
    ),
    GetPage(
      name: AppRoutes.homePageNotif,
      page: () => Homepagenotif(),
    ),
    GetPage(
  name: AppRoutes.tablePremiere,
  page: () => const TablePremierePage(),
  binding: TablePremiereBinding(),
),
  ];
}