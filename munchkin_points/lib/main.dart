import 'package:flutter/material.dart';
import 'package:munchkin_points/screens/enter_players.dart';
import 'package:munchkin_points/screens/num_players.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Munchkin Points',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (context) => const NumPlayers());
          case "/enterPlayers":
            final value = settings.arguments as int;
            return MaterialPageRoute(
                builder: (_) => PlayersNames(numPlayers: value));
        }
      },
    );
  }
}
