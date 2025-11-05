import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/CalculatorController.dart'; // Pastikan path ini benar
import 'package:latihan_pribadiiflutter/components/custom_text_field.dart'; // Pastikan path ini benar
import 'package:latihan_pribadiiflutter/components/button.dart'; // Pastikan path ini benar

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller menggunakan GetX
    final CalculatorController kalkulatorController = Get.put(CalculatorController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: kalkulatorController.txtangka1,
              labeltext: "Input Angka 1",
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: kalkulatorController.txtangka2,
              labeltext: "Input Angka 2",
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Button(
                    text: "+",
                    onPressed: kalkulatorController.tambah,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Button(
                    text: "-",
                    onPressed: kalkulatorController.kurang,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Button(
                    text: "X",
                    onPressed: kalkulatorController.kali,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Button(
                    text: "/",
                    onPressed: kalkulatorController.bagi,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Obx(() {
              return Text(
                'Hasil: ${kalkulatorController.hasil.value}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            }),
            const SizedBox(height: 24.0),
            Center(
              child: Button(
                text: "Clear",
                onPressed: kalkulatorController.clear,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}