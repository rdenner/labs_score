import 'package:flutter/material.dart';
import 'package:labs_score/player_widget.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//        width: 400.0,
        height: 200.0,
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlayerWidget(Colors.white),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
            ),
            PlayerWidget(Colors.blue),
          ],
        ));
  }
}
