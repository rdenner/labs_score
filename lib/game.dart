import 'package:flutter/material.dart';
import 'app_data.dart';
import 'team_widget.dart';
import 'user.dart';

class Game extends StatelessWidget {
  final AppData _appData = AppData();
  final List<User> teamA = List();
  final List<User> teamB = List();

  @override
  Widget build(BuildContext context) {
    teamA.add(_appData.getCurrentUser());

    return Container(
        height: 300.0,
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TeamWidget(teamA),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
            ),
            TeamWidget(teamB)
          ],
        ));
  }
}
