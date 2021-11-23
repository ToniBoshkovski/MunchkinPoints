import 'package:flutter/material.dart';
import 'package:munchkin_points/globals.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  initState() {
    super.initState();
    navigateRoutes();
  }

  navigateRoutes() async {
    var players = await dbHelper.getAllPlayers();
    if (players.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!, showPlayersRoute, (route) => false);
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!, numPlayersRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
