import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_network_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_network_app/features/home/presentation/pages/home_page.dart';

class FirebaseAuthService {
  /// Variables
  final _auth = FirebaseAuth.instance;

  /// Get Authenticared User Data
  User? get authUser => _auth.currentUser!;

  /// Delete User
  Future<void> deleteUser() async {
    await _auth.currentUser!.delete();
  }

  /// Function to show Relevant Screen
  screenRedirect(context) async {
    var isLoggedIn = FirebaseAuthService().isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, AuthPage.routeName);
    }
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
