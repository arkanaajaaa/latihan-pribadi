import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/models/Loginmodel.dart';
import 'package:latihan_pribadiiflutter/routes/routes.dart';
import 'package:latihan_pribadiiflutter/services/auth_service.dart';

class LoginController extends GetxController {
  // Text Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var loginResult = Rxn<Loginmodel>();

  // Method untuk toggle visibility password
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Method untuk login
  Future<void> login() async {
    // Validasi input
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Username dan password harus diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call API
      final result = await AuthService.login(
        username: usernameController.text,
        password: passwordController.text,
      );

      loginResult.value = result;

      if (result.status) {
        // Login berhasil
        Get.snackbar(
          'Sukses',
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[700],
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
        );

        // Simpan token (gunakan GetStorage atau SharedPreferences)
        print('Token: ${result.token}');

        // Navigate ke halaman utama
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.bottomNavPage);

        // Clear form
        usernameController.clear();
        passwordController.clear();
      } else {
        // Login gagal
        Get.snackbar(
          'Login Gagal',
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[700],
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}