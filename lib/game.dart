import 'package:flutter/material.dart';
import 'team_widget.dart';

class Game extends StatefulWidget {
  final String _game;

  Game(this._game);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool _start = false;
  
  @override
  Widget build(BuildContext context) {

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
            TeamWidget("A", "images/" + widget._game, _start),
            TeamWidget("B", "images/" + widget._game, _start)
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
