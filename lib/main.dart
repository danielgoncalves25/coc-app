import 'package:coc_app/services/api_service.dart';
import 'package:flutter/material.dart';

import './widgets/widgets.dart';
import './models/player.dart';
import './services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 15),
          headline4: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Player _player;
  List<Player> _rankedPlayers;
  String playerTag = '';
  String dannyTag = "2y2ccgu2y";
  bool playerNotFound;

  @override
  void initState() {
    super.initState();
    _initPlayer();
    _initRankedPlayers();
  }

  _initPlayer() async {
    var data = await APIService.instance.fetchPlayerData(playerTag);
    if (data != null) {
      Player player = data;
      this.setState(() {
        playerNotFound = false;
        _player = player;
      });
    } else {
      this.setState(() => playerNotFound = true);
    }
  }

  _initRankedPlayers() async {
    var data = await APIService.instance.fetchRankedPlayersData();
    if (data != null) {
      List<Player> players = data;
      this.setState(() {
        _rankedPlayers = players;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clash of Clans App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              //MediaQuery
              SizedBox(height: 5),
              Container(
                width: screenSize.width * .8,
                child: TextField(
                  cursorColor: Theme.of(context).accentColor,
                  autocorrect: false,
                  style: TextStyle(color: Colors.white),
                  onChanged: (val) {
                    this.setState(() => playerTag = val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Enter a player tag",
                    hintStyle: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              //MediaQuery
              SizedBox(height: 10),
              FutureBuilder(
                future: _initPlayer(),
                builder: (context, snapshot) {
                  if (playerTag == '') return Container();
                  if (playerNotFound == true)
                    return Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Text(
                        "$playerTag was not found",
                        style: TextStyle(color: Colors.red[300]),
                      ),
                    );
                  if (_player != null)
                    return ProfileCard(
                      screenSize: screenSize,
                      name: _player.name,
                      clanName: _player.clanName,
                      trophies: _player.trophies,
                      townHall: _player.townHall,
                      weaponLevel: _player.weaponLevel,
                      warStars: _player.warStars,
                      leagueUrl: _player.leagueUrl,
                      badgeUrl: _player.badgeUrl,
                    );
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 5),
              Text(
                "Top Players in the United States",
                style: Theme.of(context).textTheme.headline4,
              ),
              FutureBuilder(
                future: _initRankedPlayers(),
                builder: (context, snapshot) {
                  if (_rankedPlayers != null)
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _rankedPlayers.length,
                        itemBuilder: (context, index) {
                          var player = _rankedPlayers[index];
                          return ProfileCard(
                            screenSize: screenSize,
                            name: player.name,
                            clanName: player.clanName,
                            trophies: player.trophies,
                            townHall: 13,
                            weaponLevel: 5,
                            rank: player.rank,
                            leagueUrl: player.leagueUrl,
                            badgeUrl: player.badgeUrl,
                          );
                        },
                      ),
                    );
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
