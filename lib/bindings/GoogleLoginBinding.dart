import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/GoogleLoginController.dart';

class Googleloginbinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<Googlelogincontroller>(() => Googlelogincontroller());
  } 
}