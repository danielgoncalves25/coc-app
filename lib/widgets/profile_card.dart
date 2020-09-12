import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileCard extends StatelessWidget {
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

  const ProfileCard({
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
  }) : super(key: key);

  @override
  //final bool townHallUnder10 = townHall <= 10 ? true : false;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.transparent,
        elevation: .1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: screenSize.width * .85,
          height: screenSize.height * .2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                rank != 1 || rank == null
                    ? Text(
                        name,
                        style: TextStyle(color: Colors.white),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            MaterialCommunityIcons.crown,
                            color: Theme.of(context).accentColor,
                          ),
                          Text(
                            name,
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            MaterialCommunityIcons.crown,
                            color: Theme.of(context).accentColor,
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      height: 85,
                      width: 95,
                      image: townHall <= 10
                          ? AssetImage('assets/images/Town_Hall$townHall.png')
                          : AssetImage(
                              'assets/images/Town_Hall$townHall-$weaponLevel.png'),
                    ),
                    Image.network(
                      leagueUrl,
                      height: 110,
                      width: 110,
                    ),
                    Image.network(
                      badgeUrl,
                      height: 80,
                      width: 100,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          warStars != null
                              ? 'War Stars: $warStars'
                              : "Rank : $rank",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        warStars != null
                            ? Icon(
                                Icons.star,
                                color: Colors.white,
                              )
                            : Container(),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Trophies: $trophies',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Icon(
                          Icons.threed_rotation_sharp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
