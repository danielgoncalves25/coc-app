import 'package:flutter/material.dart';

class Player {


final String name;
  final String clanName;
  final int townHall;
  final int weaponLevel;
  final int warStars;
  final int trophies;
  final int rank;
  final String badgeUrl;
  final String leagueUrl;
  final Size screenSize;

  const Player({
    Key key,
    @required this.name,
    this.clanName,
    this.townHall,
    this.weaponLevel,
    this.warStars,
    this.rank,
    @required this.trophies,
    this.badgeUrl,
    @required this.leagueUrl,
    this.screenSize,
  });
  
  factory Player.fromMap(Map<String, dynamic> map){
    return Player(
      name: map['name'],
      clanName: map['clan']['name'],
      townHall: map['townHallLevel'] == null ? 13 : map['townHallLevel'],
      weaponLevel: map['townHallLevelWeaponLevel'] == null ? 5 : map['townHallLevelWeaponLevel'],
      warStars: map['warStars'] == null ? 0 : map['warStars'],
      trophies: map['trophies'],
      rank: map['rank'] == null ? 0 : map['rank'],
      badgeUrl: map['clan']['badgeUrls']['small'],
      leagueUrl: map['league']['iconUrls']['small'],
    );
  }

}