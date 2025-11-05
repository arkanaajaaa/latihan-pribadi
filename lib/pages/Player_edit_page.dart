import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/player_controller.dart';
import 'package:latihan_pribadiiflutter/models/player.dart';
class PlayerEditPage extends StatefulWidget {
  const PlayerEditPage({Key? key}) : super(key: key);

  @override
  State<PlayerEditPage> createState() => _PlayerEditPageState();
}

class _PlayerEditPageState extends State<PlayerEditPage> {
  late final TextEditingController nameController;
  late final TextEditingController positionController;
  late final TextEditingController numberController;
  late final TextEditingController imageController;

  final PlayerController controller = Get.find<PlayerController>();

  late final int index;
  late final Player player;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>;
    index = args['index'] as int;
    player = args['player'] as Player;

    nameController = TextEditingController(text: player.name);
    positionController = TextEditingController(text: player.position);
    numberController = TextEditingController(text: player.number.toString());
    imageController = TextEditingController(text: player.image);
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    numberController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(index == -1 ? 'Tambah Pemain' : 'Edit Pemain'),
        backgroundColor: const Color.fromARGB(255, 111, 112, 111),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildInputField(controller: nameController, label: 'Nama Pemain'),
            const SizedBox(height: 16),
            _buildInputField(controller: positionController, label: 'Posisi'),
            const SizedBox(height: 16),
            _buildInputField(
              controller: numberController,
              label: 'Nomor Punggung',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildInputField(controller: imageController, label: 'URL Gambar'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePlayer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePlayer() {
    if (nameController.text.isEmpty ||
        positionController.text.isEmpty ||
        numberController.text.isEmpty ||
        imageController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Semua field harus diisi!'),
          actions: [
            TextButton(
              onPressed: () {
                nameController.clear();
                positionController.clear();
                imageController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final updated = Player(
      name: nameController.text,
      position: positionController.text,
      number: int.tryParse(numberController.text) ?? 0,
      image: imageController.text,
    );

    if (index >= 0) {
      controller.updatePlayer(index, updated);
    } else {
      controller.addPlayer(updated);
    }

    Get.back();
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      ),
    );
  }
}