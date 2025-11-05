import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/table_premiere_controller.dart';

class TablePremierePage extends StatelessWidget {
  const TablePremierePage({super.key});

  final controller = Get.find<TablePremiereController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Table Premiere")),
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(child: CircularProgressIndicator(),);
            
        }
    return ListView.builder(
      itemCount: controller.tableStandings[index];
      itemBuilder: (context, index){
      final team = controller.tableStandings[index];
      return Card(
        child: ListTile(
          title: Text(team.srtTeam),
          leading: CircleAvatar(backgroundImage: NetworkImage(team.strBadge), radius:25,),
          subtitle: Text("D :"+team.intDraw + "W :" + team.intWin + "L :" + team.intloss),
          trailing: Text(team.intPoints),
        )
      ),

      },
    );
      }),
    );
  }
}
