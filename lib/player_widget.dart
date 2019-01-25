import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final Color _color;

  PlayerWidget(this._color);

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
                child: Icon(Icons.person, size: 100.0, color: widget._color),
                onTap: _increment,
                onLongPress: _decrement,
              ),
            )),
        Text(
          _score.toString(),
          style: TextStyle(fontSize: 50.0),
        ),
      ],
    );
  }
}
