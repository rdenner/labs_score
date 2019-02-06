import 'package:flutter/material.dart';
import 'user.dart';
import 'dart:async';
import 'player_widget.dart';
import 'select_users_form.dart';

class TeamWidget extends StatefulWidget {
  final bool _start;
  final String _assetImage;
  final String _team;
  final Orientation _orientation;

  TeamWidget(this._team, this._assetImage, this._start, this._orientation);

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
    List<Widget> head = [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Text(_teamName, style: TextStyle(fontSize: 25.0)),
      )
    ];

    double heightMult = (widget._orientation == Orientation.portrait)? 2.5: 3.5;

    List<Widget> body = [
      (widget._orientation == Orientation.portrait)
        ? Column(children: head,)
        : Row(children: head,),
      SizedBox(
        height: MediaQuery.of(context).size.height/heightMult,
        width: MediaQuery.of(context).size.width/2.2,
        child: ListView (
          children: _players.map((player) {
              return ListTile(title: PlayerWidget(player));
            }
          ).toList()
        ),
      )
    ];
    
    if (!widget._start) {
      body.add(IconButton(
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
      head.add(Text(_score.toString(), style: TextStyle(fontSize: 50.0)));

      body.add(
        SizedBox(
          height: MediaQuery.of(context).size.height/4,
          child: GestureDetector(
            onTap: _increment,
            onLongPress: _decrement,
            child: Image.asset(_assetImage),
          ) 
        )
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: body
    );
  }
}