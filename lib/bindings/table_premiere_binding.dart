import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/table_premiere_controller.dart';

class TablePremiereBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TablePremiereController>(() => TablePremiereController());
  }
}