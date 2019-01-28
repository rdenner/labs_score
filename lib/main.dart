import 'package:flutter/material.dart';
import 'foosball_page.dart';
import 'table_tennis_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(LabsScore());

class LabsScore extends StatelessWidget {
  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.displayName);
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void _authenticateWithGoogle() async {
    final GoogleSignInAccount googleUser = await widget._googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user =
        await widget._firebaseAuth.signInWithCredential(credential);

    print(user.displayName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: RaisedButton(
              child: Text("Sign in with Google"),
              onPressed: _authenticateWithGoogle),
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage();

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
