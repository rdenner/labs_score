import 'package:flutter/material.dart';
import 'game.dart';

class FoosballPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Foosball"),
        ),
        body: Center(
            child: Game(),
        )
    );
  }
}