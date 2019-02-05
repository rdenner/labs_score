import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'foosball_page.dart';
import 'table_tennis_page.dart';
import 'app_data.dart';
import 'user.dart';

void main() => runApp(LabsScore());

class LabsScore extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labs Score',
      theme: ThemeData(
        primaryColor: Colors.blue[900],// lightBlue[800],
        accentColor: Colors.redAccent,
        primaryColorDark: Colors.blue[900],
        primaryColorLight: Colors.lightBlue[500],
        backgroundColor: Colors.lightBlue[800]
      ),
      home: FutureBuilder<User>(
          future: AppData.appData.authenticateWithGoogle()
            ..then((user) {
              AppData.appData.addUserToDb(user);
            }),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return new HomePage();
            } else
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
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
      backgroundColor: Theme.of(context).backgroundColor,
      body:
      Stack(
        children: <Widget>[
          // StreamBuilder<QuerySnapshot>(
          //   stream: Firestore.instance.collection('matches').snapshots(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     return new ListView(
          //       children: snapshot.data.documents.map((DocumentSnapshot document) {
          //       return new ListTile(
          //         title: new Text(document['teams'].toString()),
          //         // subtitle: new Text(document['email']),
          //       );
          //     }).toList(),
          //   );
          //   }
          // ),
          
      
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: InkWell(
                borderRadius: BorderRadius.circular(45.0),
                splashColor: Theme.of(context).accentColor,
                onTap: openFoosball,
                child: Image.asset(
                  "images/foos.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: InkWell(
                borderRadius: BorderRadius.circular(45.0),
                splashColor: Theme.of(context).accentColor,
                onTap: openTableTennis,
                child: Image.asset(
                  "images/pong.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      
        ],
      ) 
    );
  }
}
