import 'package:flutter/material.dart';
import 'user.dart';

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