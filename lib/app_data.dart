import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<GoogleUserCircleAvatar> getGoogleUserCircleAvatar() async {
    if (_googleUser == null) {
      await signInWithGoogle();
    }

    return GoogleUserCircleAvatar(
      identity: _googleUser,
      // placeholderPhotoUrl: _googleUser.photoUrl,
    );
  }

  Future<Null> authenticateWithGoogle() async {
    await signInWithGoogle();
    final GoogleSignInAuthentication googleAuth =
        await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
    print(user.displayName + ' logged in. GoogleUser: '+_googleUser.toString());

    return null;
  }

  String getGoogleUserName() {
    return _googleUser.displayName;
  }

  GoogleSignInAccount get googleUserIdentity=>_googleUser;
}
