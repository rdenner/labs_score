import 'package:flutter/material.dart';
import 'app_data.dart';
import 'team_widget.dart';
import 'user.dart';

class Game extends StatefulWidget {
  final AppData _appData = AppData();
  final List<User> teamA = List();
  final List<User> teamB = List();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameState();
  }
}

class _GameState extends State<Game> {
  bool _start = false;

  @override
  Widget build(BuildContext context) {
    widget.teamA.add(widget._appData.getCurrentUser());

    return 
    Scaffold(
      body: Container(
        height: 500.0,
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TeamWidget("Team A", widget.teamA, _start),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
            ),
            TeamWidget("Team B", widget.teamB, _start)
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            setState(() {
              _start = true; 
            });
          },
        ),
    );
  }
}
