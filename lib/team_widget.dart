import 'package:flutter/material.dart';
import 'user.dart';

class TeamWidget extends StatefulWidget {
  final List<User> _players;
  bool _start;
  final String _teamName;

  TeamWidget(this._teamName, this._players, this._start);

  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  int _score;

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

  @override
  Widget build(BuildContext context) {
    List<Widget> players = widget._players.map((player) {
        return PlayerWidget(player);
      }
    ).toList();
    
    Widget card;
    
    if (!widget._start) {
      players.add(AddPlayerWidget());
      
      card = Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
      children: <Widget>[
        Text(widget._teamName),
      ],
    ),
              Column(children: players,),
            ]
          )
      );
    }
    else {
      card = InkWell(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Row(
      children: <Widget>[
        Text(widget._teamName),
        Text(
          _score.toString(),
          style: TextStyle(fontSize: 50.0),
        ),
      ],
    ),
              Column(children: players,),
            ]
          )
        ),
        onTap: _increment,
        onLongPress: _decrement,
      );
    }

    return Material(
      color: Colors.greenAccent,
      child: card
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final User _player;

  PlayerWidget(this._player);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(children: <Widget>[
        CircleAvatar(
          radius: 20.0, backgroundImage: NetworkImage(_player.photoUrl)),
        Padding(
          padding: EdgeInsets.only(right: 4.0),
        ),
        Text(_player.name, style: TextStyle(color: Colors.black)),
      ]));
  }
}

class AddPlayerWidget extends PlayerWidget {
  AddPlayerWidget(): super(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Icon(Icons.add)
    );
  }
}
