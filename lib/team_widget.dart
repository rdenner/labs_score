import 'package:flutter/material.dart';
import 'user.dart';
import 'dart:async';

class TeamWidget extends StatefulWidget {
  final List<User> _players;
  final bool _start;
  final String _teamName;
  final String _assetImage;

  TeamWidget(this._teamName, this._players, this._assetImage, this._start);

  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  int _score = 0;
  String _assetImage, _assetImageStil, _assetImageAnim;
  
  
  void _increment() {

    setState(() {
      _assetImage = _assetImageAnim;
      _score++;
    });

    
    Timer _timer = new Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _assetImage = _assetImageStil;
      });
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

    _assetImageStil = widget._assetImage + ".png";
    _assetImageAnim = widget._assetImage + "Score.png";
    _assetImage = _assetImageStil;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> players = widget._players.map((player) {
        return PlayerWidget(player);
      }
    ).toList();

    List<Widget> upper = [
      Text(widget._teamName, style: TextStyle(fontSize: 25.0)),
      Column (
        children: players
      ),
    ];

    List<Widget> body = [
      Column(
        children: upper
      )
    ];
    
    if (!widget._start) {
      players.add(AddPlayerWidget());
    }
    else {
      upper.insert(
        1, 
        Text(_score.toString(), style: TextStyle(fontSize: 50.0))
      );

      body.add(
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          height: MediaQuery.of(context).size.height/5,
          child: GestureDetector(
            onTap: _increment,
            onLongPress: _decrement,
            child: Image.asset(_assetImage),
          ) 
        )
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: body
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final User _player;

  PlayerWidget(this._player);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: <Widget>[
        CircleAvatar(
          radius: 20.0, backgroundImage: NetworkImage(_player.photoUrl)),
        Padding(
          padding: EdgeInsets.only(right: 4.0),
        ),
        Text(_player.name, style: TextStyle(color: Colors.black)),
      ])
    );
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
