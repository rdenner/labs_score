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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: (widget._game == "foos")? Text("Foosball"): Text("Ping Pong"),
        actions: <Widget>[ (!_start)? Container(): IconButton(
          icon: Icon(Icons.check_circle, color: Theme.of(context).accentColor,),
          onPressed: () {Navigator.pop(context);},
        ),],
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientaton){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TeamWidget("A", "images/" + widget._game, _start, orientaton),
                TeamWidget("B", "images/" + widget._game, _start, orientaton)
              ],
            ),
          );
        }
      ),
      floatingActionButton: (!_start)? FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          setState(() {
            _start = true; 
          });
        },
      )
      : Container()
    );
  }
}
