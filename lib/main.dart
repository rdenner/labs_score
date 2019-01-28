import 'package:flutter/material.dart';
import 'foosball_page.dart';
import 'table_tennis_page.dart';
import 'app_data.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(LabsScore());

class LabsScore extends StatelessWidget {
  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.displayName + " logged in");
            return new HomePage();
          }
          return new LoginPage();
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labs Score',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _handleCurrentScreen(),
      routes: {
        '/FoosballPage': (context) => FoosballPage(),
        '/TableTennisPage': (context) => TableTennisPage()
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  final AppData _appData = AppData();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: RaisedButton(
              child: Text("Sign in with Google"),
              onPressed: widget._appData.authenticateWithGoogle),
        ));
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
