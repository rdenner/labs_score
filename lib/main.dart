import 'package:flutter/material.dart';
import 'foosball_page.dart';
import 'table_tennis_page.dart';
import 'app_data.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(LabsScore());

class LabsScore extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labs Score',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<FirebaseUser>(
          future: AppData.appData.authenticateWithGoogle(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // print(snapshot.data.displayName + " logged in");
              return new HomePage();
            } else
              return Center(
                child: SizedBox(
                  width: 50.0, height: 50.0,
                   child: CircularProgressIndicator(),
                ),
              );
          }),
      routes: {
        '/FoosballPage': (context) => FoosballPage(),
        '/TableTennisPage': (context) => TableTennisPage()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final AppData appData = AppData();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openFoosball() {
    Navigator.pushNamed(context, '/FoosballPage');
  }

  void openTableTennis() {
    Navigator.pushNamed(context, '/TableTennisPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labs Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(side: BorderSide(width: 2.0)),
              child: Text("Foosball"),
              onPressed: openFoosball,
              color: Colors.blue,
              textColor: Colors.white,
            ),
            RaisedButton(
              shape: StadiumBorder(side: BorderSide(width: 2.0)),
              child: Text("Table Tennis"),
              onPressed: openTableTennis,
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
