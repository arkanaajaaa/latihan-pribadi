import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/navigation_controller.dart';
import 'calculator_page.dart';
import 'player_list_page.dart';
import 'profile_page.dart'; // kita buat file dummy untuk profil

class BottomNavPage extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> pages = [
    CalculatorPage(),
    PlayerListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[navController.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: navController.changeTabIndex,
            selectedItemColor: Colors.deepPurple,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: 'Kalkulator',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer),
                label: 'Pemain',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ));
  }
}
