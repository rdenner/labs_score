import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final String _playerName;
  final String _url;
  // final GoogleUserCircleAvatar _googleUserCircleAvatar;

  PlayerWidget(this._playerName, this._url);
  // PlayerWidget(this._googleUserCircleAvatar);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Material(
              color: Colors.greenAccent,
              child: InkWell(
                borderRadius: BorderRadius.circular(90.0),
                child: (widget._url != null)
                    ? Image.network(widget._url)
                    : Image.asset("images/anonymous.svg", height: 100,),
                onTap: _increment,
                onLongPress: _decrement,
              ))),
        Text((widget._playerName == null) ? 'Anonymous' : widget._playerName),
        Text(
          _score.toString(),
          style: TextStyle(fontSize: 50.0),
        ),
      ],
    );
  }
}
