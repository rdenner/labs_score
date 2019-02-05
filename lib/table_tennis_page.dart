import 'package:flutter/material.dart';
import 'package:labs_score/game.dart';

class TableTennisPage extends StatefulWidget {
  @override
  _TableTennisPageSate createState() => _TableTennisPageSate();
}

class _TableTennisPageSate extends State<TableTennisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Table Tennis"),
        ),
        body: Center(
          child: Game("pong")
        ));
  }
}
