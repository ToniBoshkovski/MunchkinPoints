import 'package:flutter/material.dart';
import 'package:munchkin_points/globals.dart';
import 'package:munchkin_points/screens/enter_players.dart';
import 'package:munchkin_points/screens/loading_page.dart';
import 'package:munchkin_points/screens/num_players.dart';
import 'package:munchkin_points/screens/show_players.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Munchkin Points',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loadingRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case loadingRoute:
            return MaterialPageRoute(builder: (context) => const LoadingPage());
          case numPlayersRoute:
            return MaterialPageRoute(builder: (context) => const NumPlayers());
          case enterPlayersRoute:
            final value = settings.arguments as int;
            return MaterialPageRoute(
                builder: (_) => PlayersNames(numPlayers: value));
          case showPlayersRoute:
            return MaterialPageRoute(builder: (context) => const ShowPlayers());
        }
      },
    );
  }
}
