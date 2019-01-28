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

  void signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    _googleUser = await _googleSignIn.signIn();
  }

  GoogleUserCircleAvatar getGoogleUserCircleAvatar() {
    if (_googleUser == null) {
      signInWithGoogle();
    }

    return GoogleUserCircleAvatar(
      identity: _googleUser,
      placeholderPhotoUrl: _googleUser.photoUrl,
    );
  }

  void authenticateWithGoogle() async {
    signInWithGoogle();
    final GoogleSignInAuthentication googleAuth =
        await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user =
        await _firebaseAuth.signInWithCredential(credential);
    print(user.displayName + ' logged in');
  }
}
