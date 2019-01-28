import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:labs_score/app_data.dart';

class PlayerWidget extends StatefulWidget {
  final GoogleSignInAccount _googleUser;
  // final GoogleUserCircleAvatar _googleUserCircleAvatar;

  PlayerWidget(this._googleUser);
  // PlayerWidget(this._googleUserCircleAvatar);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {

  void _increment() {
    setState(() {
      _score++;
    });
  }

  void _decrement() {
    if (_score > 0) {
      setState(() {
        _score--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _score = 0;
  }

  int _score;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Material(
              color: Colors.greenAccent,
              child: InkWell(
                borderRadius: BorderRadius.circular(90.0),
                child: (widget._googleUser == null)?
                  Icon(Icons.person, size: 100.0, color: Colors.white):
                    GoogleUserCircleAvatar(identity: widget._googleUser,),
                onTap: _increment,
                onLongPress: _decrement,
              ),
            )),
          
        Text(
          (widget._googleUser == null)? 'Anonymous' : widget._googleUser.displayName
        ),
        Text(
          _score.toString(),
          style: TextStyle(fontSize: 50.0),
        ),
      ],
    );
  }
}
