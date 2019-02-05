import 'package:flutter/material.dart';
import 'user.dart';
import 'app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'player_widget.dart';

class SelectUsersForm extends StatefulWidget {
  final List<User> _selectedUsers;

  SelectUsersForm(this._selectedUsers);

  @override
  State<StatefulWidget> createState() => _SelectUsersFormState();
}

class _SelectUsersFormState extends State<SelectUsersForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> _checkedValues = Map();

  @override
  void initState() {
    super.initState();

    for (User user in widget._selectedUsers) {
      _checkedValues[user.uid] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Select Users'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
        key: _formKey,
        child: StreamBuilder<QuerySnapshot>(
          stream: AppData.appData.getUsersFromDb(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            return ListView(
              children: (snapshot.data == null)
              ? <Widget>[ Text("Loading...")]
              : snapshot.data.documents.map((DocumentSnapshot document) {

                User user = User.fromMap(document.data);
                if (!_checkedValues.containsKey(user.uid)) {
                  _checkedValues[user.uid] = false;
                }

                return CheckboxListTile(
                  onChanged: (bool newValue) {
                    if (_checkedValues[user.uid]) {
                      bool found = false;

                      for (int i = 0; i < widget._selectedUsers.length && !found; i++) {
                        if (widget._selectedUsers[i].uid == user.uid) {
                          found = true;
                          widget._selectedUsers.removeAt(i);
                        }
                      }
                    }
                    else {
                      widget._selectedUsers.add(user);
                    }

                    setState(() {
                      _checkedValues[user.uid] = newValue;
                    });
                  },
                  value: _checkedValues[user.uid],
                  title: PlayerWidget(user)
                );
              }).toList(),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, widget._selectedUsers);
        },
      ),
    );
  }
}