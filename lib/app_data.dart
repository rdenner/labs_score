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

  Stream<DocumentSnapshot> getUserFromDb(String uid) {
    print("Getting user " + uid + " from Db");

    return Firestore.instance
        .collection("users")
        .document(uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getUsersFromDb() {
    return Firestore.instance
        .collection("users")
        .snapshots();
  }

  Future<void> addUserToDb(User user) async {
    print("Add user " + user.name);
    
    final TransactionHandler createTransaction = (Transaction tx) async {

      final DocumentSnapshot ds =
          await tx.get(Firestore.instance.collection('users').document(user.uid));

      var map = User.getMap(user);

      await tx.set(ds.reference, map);

      return map;
    };

    Firestore.instance.runTransaction(createTransaction);
      
  }
}
