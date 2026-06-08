import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:google_sign_in/google_sign_in.dart';

const dominioInstitucional = '@souunit.com.br';

const idClienteWebGoogle =
    '154826302240-9dsjjt370cnbvk2oie3uhtc40l222mjh.apps.googleusercontent.com';

bool emailPermitido(String? email) {
  if (email == null || email.isEmpty) return false;
  return email.trim().toLowerCase().endsWith(dominioInstitucional);
}

class DominioNaoPermitidoException implements Exception {}

class LoginCanceladoException implements Exception {}

class GoogleSignInIndisponivelException implements Exception {}

GoogleSignIn criarGoogleSignIn() {
  return GoogleSignIn(
    scopes: ['email'],
    clientId: kIsWeb ? idClienteWebGoogle : null,
    serverClientId: kIsWeb ? null : idClienteWebGoogle,
  );
}

bool get googleSignInDisponivel {
  if (kIsWeb) return true;
  return defaultTargetPlatform != TargetPlatform.windows &&
      defaultTargetPlatform != TargetPlatform.linux;
}

class ServicoAutenticacao {
  ServicoAutenticacao({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
    : _auth = auth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? criarGoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Stream<User?> get mudancasUsuario => _auth.authStateChanges();

  User? get usuarioAtual => _auth.currentUser;

  Future<User> _validarDominioOuDeslogar(User user) async {
    if (emailPermitido(user.email)) return user;

    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    throw DominioNaoPermitidoException();
  }

  Future<User> entrarComEmail(String email, String senha) async {
    final credencial = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
    return _validarDominioOuDeslogar(credencial.user!);
  }

  Future<User> cadastrarComEmail(String email, String senha) async {
    if (!emailPermitido(email)) {
      throw DominioNaoPermitidoException();
    }

    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
    return _validarDominioOuDeslogar(credencial.user!);
  }

  Future<User> entrarComGoogle() async {
    if (!googleSignInDisponivel) {
      throw GoogleSignInIndisponivelException();
    }

    final contaGoogle = await _googleSignIn.signIn();
    if (contaGoogle == null) {
      throw LoginCanceladoException();
    }

    final authGoogle = await contaGoogle.authentication;
    if (authGoogle.idToken == null) {
      await _googleSignIn.signOut();
      throw Exception('Não foi possível obter credencial do Google.');
    }

    final credencialFirebase = GoogleAuthProvider.credential(
      accessToken: authGoogle.accessToken,
      idToken: authGoogle.idToken,
    );

    final credencial = await _auth.signInWithCredential(credencialFirebase);
    return _validarDominioOuDeslogar(credencial.user!);
  }

  Future<void> sair() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }
}
