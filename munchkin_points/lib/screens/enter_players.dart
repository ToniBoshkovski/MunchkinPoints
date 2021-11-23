import 'package:flutter/material.dart';
import 'package:munchkin_points/globals.dart';
import 'package:munchkin_points/models/player.dart';

class PlayersNames extends StatefulWidget {
  final int? numPlayers;

  const PlayersNames({Key? key, this.numPlayers}) : super(key: key);

  @override
  _PlayersNamesState createState() => _PlayersNamesState();
}

class _PlayersNamesState extends State<PlayersNames> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> textEditingControllers = [];

  List<Widget> createTextFields(int? players) {
    List<Widget> fieldsList = [];
    for (int i = 0; i < players!; i++) {
      TextEditingController _controller = TextEditingController();
      fieldsList.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Player ${i + 1}',
              labelStyle: const TextStyle(fontSize: 14),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
            },
          ),
        ),
      );
      textEditingControllers.add(_controller);
    }

    return fieldsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter names"),
      ),
      body: Container(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 30.0, right: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: createTextFields(widget.numPlayers),
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: OutlinedButton(
                  child: const Text(
                    "New Game",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      for (var controller in textEditingControllers) {
                        Player player = Player(null, controller.text, 1);
                        await dbHelper.insertPlayer(player);
                      }
                      Navigator.pushNamed(context, showPlayersRoute);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey.shade100;
                      }
                      return Colors.blue;
                    }),
                    shape:
                        MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                      return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20));
                    }),
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
