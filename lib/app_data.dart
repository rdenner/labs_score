import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'user.dart';

class AppData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  GoogleSignInAccount _googleUser;
  User _currentUser;

  static AppData appData = new AppData._();
  factory AppData() => appData;

  AppData._() {
    //
  }

  Future signInWithGoogle() async {
    print("Signing in with Google");
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    _googleUser = await _googleSignIn.signIn();
    print('Current google user: ' + _googleUser.displayName);
  }

  Future<User> authenticateWithGoogle() async {
    await signInWithGoogle();

    print("Authenticating with Google");

    final GoogleSignInAuthentication googleAuth =
        await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    _firebaseUser =
        await _firebaseAuth.signInWithCredential(credential);
    print(_firebaseUser.displayName + ' logged in');

    return User(_firebaseUser.displayName, _firebaseUser.email, _firebaseUser.photoUrl, _firebaseUser.uid);
  }

  User getCurrentUser() {
    print(_firebaseUser);
    return _currentUser = User(_firebaseUser.displayName, _firebaseUser.email,
        _firebaseUser.photoUrl, _firebaseUser.uid);
  }

  Stream<QuerySnapshot> getUserFromDb(String uid) {
    print("Getting user " + uid + " from Db");

    return Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Future<void> addUserToDb(User user) async {
    print("Add user " + user.name);
    Stream<QuerySnapshot> snapshots = AppData.appData.getUserFromDb(user.uid);

    snapshots.listen((QuerySnapshot snapshot) {
      List<User> users = snapshot.documents
          .map((documentSnapshot) => User.fromMap(documentSnapshot.data))
          .toList();

      if (users.length > 1) {
        print("Too many users with same id");
        throw Exception();
      } else if (users.isEmpty) {
        print("Can add user, because user not found");
        final TransactionHandler createTransaction = (Transaction tx) async {
          final DocumentSnapshot ds =
              await tx.get(Firestore.instance.collection('users').document());
          var dataMap = new Map<String, dynamic>();
          dataMap['name'] = user.name;
          dataMap['email'] = user.email;
          dataMap['photoUrl'] = user.photoUrl;
          dataMap['uid'] = user.uid;

          await tx.set(ds.reference, dataMap);

          return dataMap;
        };

        Firestore.instance.runTransaction(createTransaction);
      }
    });
  }
}
