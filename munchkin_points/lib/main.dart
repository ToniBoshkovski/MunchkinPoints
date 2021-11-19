import 'package:flutter/material.dart';
import 'package:munchkin_points/globals.dart';
import 'package:munchkin_points/screens/enter_players.dart';
import 'package:munchkin_points/screens/num_players.dart';

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

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        // get data from db
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Munchkin Points',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: homeRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case homeRoute:
            return MaterialPageRoute(builder: (context) => const NumPlayers());
          case enterPlayersRoute:
            final value = settings.arguments as int;
            return MaterialPageRoute(
                builder: (_) => PlayersNames(numPlayers: value));
        }
      },
    );
  }
}
