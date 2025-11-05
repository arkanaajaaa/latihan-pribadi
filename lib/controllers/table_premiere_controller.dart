import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class TablePremiereController extends GetxController{
  var isloading = false.obs;
  // var tablestanding = <Tab>[];  (bikin model telebih dahulu)

  @override
  void onInit() {
    super.onInit();
    fetchTablePremiere();
  }

  void fetchTablePremiere() async {
    const url = https://www.thesportsdb.com/api/v1/json/3/lookuptable.php?l=4328&s=2025-2026;
    try {
      isloading.value = true;
      final response = await http.get(Uri.parse(url));
      print("status code" + response.statusCode.toString());
      print("json resonse" + response.body.toString());

      if (response.statusCode == 200) {
        
        final data = jsonDecode(response.body);
        final List standings = data['table'];
        tableStanding.assignAll(standings.map((e) => Table.fromJson(e)).toList());

      } else {
        Get.snackbar("Error", "message: error dari BE");
      }
      
    }
      catch (e) {
      Get.snackbar("Error",e.toString());
    } 

    isloading.value = false;
  }
}