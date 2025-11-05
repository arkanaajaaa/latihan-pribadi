import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/LoginAPIController.dart';

class LoginAPIBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginAPIController>(() => LoginAPIController());
  }
}