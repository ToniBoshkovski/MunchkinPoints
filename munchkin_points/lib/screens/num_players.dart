import 'package:flutter/material.dart';

class NumPlayers extends StatefulWidget {
  const NumPlayers({Key? key}) : super(key: key);

  @override
  _NumPlayersState createState() => _NumPlayersState();
}

class _NumPlayersState extends State<NumPlayers> {
  int numPlayers = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose number of players"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Number of players",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // Button color
                      child: InkWell(
                        onTap: () {
                          if (numPlayers == 3) return;
                          setState(() {
                            numPlayers--;
                          });
                        },
                        child: const SizedBox(
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$numPlayers",
                    style: const TextStyle(fontSize: 24),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // Button color
                      child: InkWell(
                        onTap: () {
                          if (numPlayers == 6) return;
                          setState(() {
                            numPlayers++;
                          });
                        },
                        child: const SizedBox(
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 150,
                  height: 60,
                  child: OutlinedButton(
                    child: const Text(
                      "Enter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/enterPlayers", arguments: numPlayers);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey.shade100;
                        }
                        return Colors.blue;
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20));
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
