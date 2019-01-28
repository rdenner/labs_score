import 'package:flutter/material.dart';
import 'package:labs_score/player_widget.dart';
import 'app_data.dart';

class Game extends StatelessWidget {
  final AppData _appData = AppData();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlayerWidget(_appData.googleUserIdentity),
            // PlayerWidget(_appData.getGoogleUserCircleAvatar()),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
            ),
            PlayerWidget(null),
          ],
        ));
  }
}
