import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/models/player.dart';

class PlayerController extends GetxController {
  var players = <Player>[
    Player(
      image: 'https://img.okezone.com/content/2023/11/17/51/2922336/kisah-miris-alessandro-del-piero-legenda-juventus-yang-ternyata-pernah-bernasib-sama-dengan-indonesia-di-piala-dunia-u-17-F4CYzhWdT9.jpg',
      name: 'A del Piero',
      position: 'Forward',
      number: 10,
    ),
    Player(
      image: 'https://image.idntimes.com/post/20220511/fromandroid-d9f1513d467e3336bf7a9960e590a98d.jpg?tr=w-1200,f-webp,q-75&width=1200&format=webp&quality=75',
      name: 'Diego Forlan',
      position: 'forward',
      number: 21,
    ),
  ].obs;

  void updatePlayer(int index, Player updatedPlayer) {
    players[index] = updatedPlayer;
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  void removePlayer(int index) {
    players.removeAt(index);
  }
}