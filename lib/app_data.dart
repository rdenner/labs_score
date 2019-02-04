import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AppData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignInAccount _googleUser;

  static AppData appData = new AppData._();
  factory AppData() => appData;

  AppData._() {
    //
  }

  Future signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    _googleUser = await _googleSignIn.signIn();
    print('Current google user: ' + _googleUser.displayName);
  }

  Future<User> authenticateWithGoogle() async {
    await signInWithGoogle();
    final GoogleSignInAuthentication googleAuth =
        await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user =
        await _firebaseAuth.signInWithCredential(credential);
    print(
        user.displayName + ' logged in. GoogleUser: ' + _googleUser.toString());

    return User(user.displayName, user.email, user.photoUrl, user.uid);
  }

  String getGoogleUserName() {
    return _googleUser.displayName;
  }

  String getGoogleUserUrl() {
    return _googleUser.photoUrl;
  }

  Stream<QuerySnapshot> getUserFromDb(String uid) {
    print("Getting user " + uid);

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
      }
      else if (users.isEmpty) {
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

class User {
  String name;
  String email;
  String photoUrl;
  String uid;

  User(this.name, this.email, this.photoUrl, this.uid);

  User.map(dynamic obj) {
    this.name = obj['name'];
    this.email = obj['email'];
    this.photoUrl = obj['photoUrl'];
    this.uid = obj['uid'];
  }

  User.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.email = map['email'];
    this.photoUrl = map['photoUrl'];
    this.uid = map['uid'];
  }
}
