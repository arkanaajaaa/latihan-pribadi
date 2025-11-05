import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/models/Loginmodel.dart';
import 'package:latihan_pribadiiflutter/services/auth_service.dart';
import 'package:latihan_pribadiiflutter/services/storage_service.dart';
import 'package:latihan_pribadiiflutter/routes/routes.dart';

class LoginAPIController extends GetxController {
  // Text Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if user already logged in
  Future<void> checkLoginStatus() async {
    final isLoggedIn = await StorageService.isLoggedIn();
    if (isLoggedIn) {
      // Auto navigate to main menu if already logged in
      Get.offAllNamed(AppRoutes.bottomNavPage);
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login method
  Future<void> login() async {
    // Validasi input
    if (usernameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Username tidak boleh kosong',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Password tidak boleh kosong',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call API
      final Loginmodel result = await AuthService.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result.status) {
        // ✅ LOGIN SUKSES
        
        // Save token ke SharedPreferences
        await StorageService.saveToken(result.token);
        await StorageService.saveUsername(usernameController.text.trim());
        await StorageService.saveLoginStatus(true);

        print('✅ Token saved: ${result.token}');

        // Show success snackbar
        Get.snackbar(
          'Sukses',
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[700],
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        );

        // Clear form
        usernameController.clear();
        passwordController.clear();

        // Navigate ke main menu setelah 1 detik
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.bottomNavPage);
        
      } else {
        // ❌ LOGIN GAGAL
        
        // Tampilkan pesan error dari server
        Get.snackbar(
          'Login Gagal',
          result.message.isNotEmpty 
            ? result.message 
            : 'Username atau password salah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[700],
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
      }
    } catch (e) {
      // ⚠️ ERROR EXCEPTION
      
      print('❌ Login error: $e');
      
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        icon: const Icon(Icons.warning_amber, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      // Clear SharedPreferences
      await StorageService.clearAll();
      
      Get.snackbar(
        'Logout',
        'Anda telah keluar',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );

      // Navigate to login
      Get.offAllNamed(AppRoutes.loginAPI);
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}