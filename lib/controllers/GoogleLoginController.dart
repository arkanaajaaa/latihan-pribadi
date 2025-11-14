import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlelogincontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoggedIn = false.obs;
  var isLoadingg = false.obs; // Sudah ada

  @override
  void onInit() {
    super.onInit();
    // tambahkan di splashscreen
    // _auth.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     isLoggedIn.value = false;
    //     Get.offAll(() => const LoginPage());
    //   } else {
    //     isLoggedIn.value = true;
    //     Get.offAll(() => const HomePage());
    //   }
    // });
  }

  Future<void> signInWithGoogle() async {
    isLoadingg.value = true;

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoadingg.value = false;
        return; // batal login
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // proses sign in ke Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      // kalau berhasil (user tidak null)
      if (userCredential.user != null) {
        Get.snackbar(
          "Success",
          "Welcome, ${userCredential.user!.displayName ?? 'User'}",
          snackPosition: SnackPosition.TOP,
        );

        // ==========================================================
        // KODE NAVIGASI DITAMBAHKAN DI SINI (SETELAH LOGIN SUKSES)
        // ==========================================================
        // Tunggu 1 detik untuk memberi waktu SnackBar terlihat
        await Future.delayed(const Duration(seconds: 1));

        // Ganti AppRoutes.homePage dengan rute halaman utama Anda.
        // Jika Anda menggunakan widget secara langsung (seperti di komentar onInit):
        Get.offAll(() => const ());

        // ATAU jika Anda menggunakan Named Routes:
        // Get.offAllNamed(AppRoutes.bottomNavPage);
      }
    } catch (e) {
      Get.snackbar("Error", "Login gagal: ${e.toString()}");

      // Baris print sudah benar
      print("error login " + e.toString());
    } finally {
      // Hanya mengatur status loading, tidak ada navigasi di sini
      isLoadingg.value = false;
    }
  }
}
