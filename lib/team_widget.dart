import 'package:flutter/material.dart';
import 'user.dart';
import 'dart:async';
import 'player_widget.dart';
import 'select_users_form.dart';

class TeamWidget extends StatefulWidget {
  final bool _start;
  final String _assetImage;
  final String _team;

  TeamWidget(this._team, this._assetImage, this._start);

  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  List<User> _players;
  String _teamName;
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

    _assetImageStil = widget._assetImage + widget._team + ".png";
    _assetImageAnim = widget._assetImage + widget._team + "Score.png";
    _assetImage = _assetImageStil;

    _teamName = "Team " + widget._team;

    _players = new List();

  }

  @override
  Widget build(BuildContext context) {

    List<Widget> upper = [
      Text(_teamName, style: TextStyle(fontSize: 25.0)),
      Column (
        children: _players.map((player) {
            return PlayerWidget(player);
          }
        ).toList()
      ),
    ];

    List<Widget> body = [
      Column(
        children: upper
      )
    ];
    
    if (!widget._start) {
      upper.add(IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SelectUsersForm(_players)
          )).then((players) {
            if (players != null) {
              setState(() {
                _players = players; 
              });
            }
          });
        },
      ));
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