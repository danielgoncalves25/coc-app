import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/player.dart';
import './key.dart';

class APIService {
  APIService._instantiate();
  static final APIService instance = APIService._instantiate();
  static const API_KEY = APIKey;

  final String playerUrl = "https://api.clashofclans.com/v1/players/%";
  final String clanUrl = "https://api.clashofclans.com/v1/clans/%";
  final String locationUrl =
      "https://api.clashofclans.com/v1/locations/32000249/rankings/players?limit=5";
  var headers = {
    "Accept": "application/json",
    "authorization": API_KEY,
  };

  Future<Player> fetchPlayerData(playerTag) async {
    var response =
        await http.get(Uri.encodeFull(playerUrl + playerTag), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Player player = Player.fromMap(data);
      return player;
    }
  }

  Future<List<Player>> fetchRankedPlayersData() async {
    var response =
        await http.get(Uri.encodeFull(locationUrl), headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> playersJson = data['items'];
      List<Player> players = [];
      playersJson.forEach((player) => players.add(Player.fromMap(player)));
      return players;
    }
  }

  //need to call this in main.dart
  Future<Map<String, dynamic>> fetchBases(
      String townHallLevel, String baseType) async {
    var baseUrl =
        'http://127.0.0.1:5000/?townHallLevel=$townHallLevel&baseType=$baseType';
    var response = await http.get(baseUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    }
  }
}
