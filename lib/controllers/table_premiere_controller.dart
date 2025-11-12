import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_pribadiiflutter/models/table_premiere.dart';

class TablePremiereController extends GetxController {
  var isLoading = false.obs;
  var tableStandings = <TablePremiere>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTablePremiere();
  }

  Future<void> fetchTablePremiere() async {
    const url = 'https://www.thesportsdb.com/api/v1/json/3/lookuptable.php?l=4328&s=2024-2025';
    
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      print('🔄 Fetching data from: $url');
      
      final response = await http.get(Uri.parse(url));
      
      print('📊 Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Check if data contains 'table' key
        if (data['table'] != null) {
          final List standings = data['table'];
          
          // Parse data menggunakan model
          tableStandings.value = standings
              .map((e) => TablePremiere.fromJson(e))
              .toList();
          
          print('✅ Data loaded: ${tableStandings.length} teams');
          
          Get.snackbar(
            'Success',
            'Loaded ${tableStandings.length} teams',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        } else {
          errorMessage.value = 'No table data found';
          Get.snackbar(
            'Error',
            'No table data found in response',
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode}';
        Get.snackbar(
          'Error',
          'Failed to load data: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print('❌ Error: $e');
      Get.snackbar(
        'Error',
        'Exception: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    await fetchTablePremiere();
  }
}