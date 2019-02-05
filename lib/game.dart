import 'package:flutter/material.dart';
import 'app_data.dart';
import 'team_widget.dart';
import 'user.dart';

class Game extends StatefulWidget {
  final AppData _appData = AppData();
  final List<User> _teamA = List();
  final List<User> _teamB = List();
  final String _game;

  Game(this._game);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool _start = false;
  String _teamAName = "Team A", _teamBName = "Team B";

  @override
  Widget build(BuildContext context) {
    widget._teamA.add(widget._appData.getCurrentUser());

    return 
    Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TeamWidget(_teamAName, widget._teamA, "images/" + widget._game + "A", _start),
            TeamWidget(_teamBName, widget._teamB, "images/" + widget._game + "B", _start)
          ],
        ),
      ),
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
