import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseAuthService {
  /// Variables
  final _auth = FirebaseAuth.instance;

  /// Get Authenticared User Data
  User? get authUser => _auth.currentUser!;

  /// Delete User
  Future<void> deleteUser() async {
    await _auth.currentUser!.delete();
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the User
    return (await _auth.signInWithCredential(credential)).user!;
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
