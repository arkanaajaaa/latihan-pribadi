import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  final txtangka1 = TextEditingController();
  final txtangka2 = TextEditingController();
  final RxDouble hasil = 0.0.obs;

  void tambah() {
    double angka1 = double.parse(txtangka1.text);
    double angka2 = double.parse(txtangka2.text);

    double hasiljumlah = angka1 + angka2;
    print("hasilnya adalah " + hasiljumlah.toString());
    hasil.value = hasiljumlah;
  }

  void kali() {
    double angka1 = double.parse(txtangka1.text);
    double angka2 = double.parse(txtangka2.text);

    double hasiljumlah = angka1 * angka2;
    print("hasilnya adalah" + hasiljumlah.toString());
    hasil.value = hasiljumlah;
  }

  void kurang() {
    double angka1 = double.parse(txtangka1.text);
    double angka2 = double.parse(txtangka2.text);

    double hasiljumlah = angka1 - angka2;
    print("hasilnya adalah" + hasiljumlah.toString());
    hasil.value = hasiljumlah;
  }

  void bagi() {
    double angka1 = double.parse(txtangka1.text);
    double angka2 = double.parse(txtangka2.text);

    if (angka2 != 0) {
      double hasiljumlah = angka1 / angka2;
      print("hasilnya adalah" + hasiljumlah.toString());
      hasil.value = hasiljumlah;
    } else {
      print("Error: Pembagian dengan nol tidak diperbolehkan.");
      hasil.value = 0.0;
    }
  }

  void clear() {
    txtangka1.clear();
    txtangka2.clear();
    hasil.value = 0.0;
  }
}