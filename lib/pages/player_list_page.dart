import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/player_controller.dart';
import 'package:latihan_pribadiiflutter/models/player.dart';
import 'package:latihan_pribadiiflutter/routes/routes.dart';

class PlayerListPage extends StatelessWidget {
  final PlayerController controller = Get.put(PlayerController());

  PlayerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tampilkan snackbar setelah build selesai
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final args = Get.arguments;
    //   if (args != null && args['fromCalculator'] == true) {
    //     Get.snackbar(
    //       'Sukses',
    //       'Kamu tiba di halaman Football Players!',
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: Colors.green[700],
    //       colorText: Colors.white,
    //       duration: const Duration(seconds: 2),
    //       margin: const EdgeInsets.all(12),
    //       borderRadius: 12,
    //     );
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pemain'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 111, 112, 111),
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.players.length,
          itemBuilder: (context, index) {
            final player = controller.players[index];

            final backgroundColor = index % 2 == 0
                ? Colors.grey[100]
                : const Color.fromARGB(255, 187, 184, 184);

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(player.image),
                ),
                title: Text(
                  player.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  '${player.position} • #${player.number}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.playerEdit,
                          arguments: {
                            'index': index,
                            'player': player,
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removePlayer(index);
                        Get.snackbar(
                          'Berhasil',
                          'Pemain berhasil dihapus',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(10),
                          duration: const Duration(seconds: 2),
                          borderRadius: 12,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.playerEdit, arguments: {
            'index': -1,
            'player': Player(name: '', position: '', number: 0, image: ''),
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 111, 112, 111),
      ),
    );
  }
}