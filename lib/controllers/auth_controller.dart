import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/auth/roles.dart';
import 'package:frontend/core/utils.dart';
import 'package:frontend/roleloader.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        print('New User: ${userCredential.additionalUserInfo!.isNewUser}');
        userCredential.additionalUserInfo!.isNewUser
            ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RoleSelectionScreen();
              }))
            : Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RoleLoader();
              }));
      }
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  signOut() async {
    await auth.signOut();
  }
}
