import 'package:flutter/material.dart';
import 'package:munchkin_points/globals.dart';
import 'package:munchkin_points/models/player.dart';

class ShowPlayers extends StatefulWidget {
  const ShowPlayers({Key? key}) : super(key: key);

  @override
  _ShowPlayer createState() => _ShowPlayer();
}

class _ShowPlayer extends State<ShowPlayers> {
  List<Player> listOfPlayers = <Player>[];
  final List<Color> colorsList = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purpleAccent,
    Colors.yellow,
    Colors.pinkAccent
  ];

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text("Do you really want to quit?"),
      actions: [
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text(
            "Confirm",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () async {
            await dbHelper.deleteAllPlayers();
            Navigator.pushNamedAndRemoveUntil(
                context, homeRoute, (route) => false);
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Widget> customGridView() {
    List<Widget> list = <Widget>[];
    int index = 0;
    for (var player in listOfPlayers) {
      ValueNotifier<int> levelCounter = ValueNotifier(player.points!);
      list.add(
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: colorsList[index],
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                player.name ?? "N/A",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () async {
                                        if (levelCounter.value == 1) return;
                                        levelCounter.value--;
                                        player.points = levelCounter.value;
                                        await dbHelper.updatePlayer(player);
                                      },
                                      child: const SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: levelCounter,
                                  builder: (context, value, child) => Text(
                                    "$value",
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                ),
                                ClipOval(
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () async {
                                        if (levelCounter.value == 10) return;
                                        levelCounter.value++;
                                        player.points = levelCounter.value;
                                        await dbHelper.updatePlayer(player);
                                      },
                                      child: const SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      index++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Players points"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextButton(
                child: const Text(
                  "Quit Game",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => showAlertDialog(context),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Player>>(
          future: dbHelper.getAllPlayers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                listOfPlayers = snapshot.data!;
                return Column(
                  children: customGridView(),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
