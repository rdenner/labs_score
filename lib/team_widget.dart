import 'package:flutter/material.dart';
import 'user.dart';

class TeamWidget extends StatefulWidget {
  final List<User> _players;

  TeamWidget(this._players);

  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  void _increment() {
    setState(() {
      _score++;
    });
  }

  void _decrement() {
    if (_score > 0) {
      setState(() {
        _score--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _score = 0;
  }

  int _score;

  @override
  Widget build(BuildContext context) {
    Column players = Column(
        children: (widget._players.isEmpty)
            ? <Widget>[
                Column(children: <Widget>[
                  CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage("images/anonymous.svg")),
                  Text("Anonymous", style: TextStyle(color: Colors.black)),
                ])
              ]
            : widget._players.map((player) {
                return Column(children: <Widget>[
                  CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(player.photoUrl)),
                  Text(player.name, style: TextStyle(color: Colors.black)),
                ]);
              }).toList());

    return Material(
        color: Colors.greenAccent,
        child: InkWell(
          child: Card(
              shape: StadiumBorder(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Team X"),
                    players,
                    Text(
                      _score.toString(),
                      style: TextStyle(fontSize: 50.0),
                    ),
                  ])),
          onTap: _increment,
          onLongPress: _decrement,
        ));
  }
}
