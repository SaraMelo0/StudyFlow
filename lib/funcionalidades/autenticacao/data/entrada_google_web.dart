import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> executarEntradaGoogle(FirebaseAuth auth) {
  return auth.signInWithPopup(GoogleAuthProvider());
}
