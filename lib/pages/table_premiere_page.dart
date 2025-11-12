import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/table_premiere_controller.dart';

class TablePremierePage extends StatelessWidget {
  const TablePremierePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(TablePremiereController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premier League Table'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[700],
        foregroundColor: Colors.white,
        actions: [
        ],
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading data...'),
              ],
            ),
          );
        }

        // Error state
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${controller.errorMessage.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Empty state
        if (controller.tableStandings.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        }

        // Success state - Display data
        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.tableStandings.length,
            itemBuilder: (context, index) {
              final team = controller.tableStandings[index];
              
              // Tentukan warna berdasarkan posisi
              Color? backgroundColor;
              if (index < 4) {
                // Top 4: Champions League
                backgroundColor = Colors.blue[50];
              } else if (index == 4) {
                // 5th: Europa League
                backgroundColor = Colors.orange[50];
              } else if (index >= controller.tableStandings.length - 3) {
                // Bottom 3: Relegation
                backgroundColor = Colors.red[50];
              }

              return Card(
                color: backgroundColor,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  
                  // Rank number
                  leading: Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      team.intRank,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  
                  // Team badge and name
                  title: Row(
                    children: [
                      // Team badge
                      CircleAvatar(
                        backgroundImage: NetworkImage(team.strBadge),
                        radius: 20,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      
                      // Team name
                      Expanded(
                        child: Text(
                          team.strTeam,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Statistics
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 44),
                    child: Text(
                      'P: ${team.intPlayed} | W: ${team.intWin} | D: ${team.intDraw} | L: ${team.intLoss}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  
                  // Points
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      team.intPoints,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                  // Tap to show details
                  onTap: () {
                    _showTeamDetails(context, team);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }

  // Dialog untuk menampilkan detail tim
  void _showTeamDetails(BuildContext context, team) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(team.strBadge),
              radius: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                team.strTeam,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(value),
        ],
      ),
    );
  }
}