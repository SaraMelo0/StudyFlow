import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:study_flow/funcionalidades/autenticacao/data/entrada_google_stub.dart'
    if (dart.library.html) 'package:study_flow/funcionalidades/autenticacao/data/entrada_google_web.dart';

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
    serverClientId: idClienteWebGoogle,
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

  Future<User> cadastrarComEmail(
    String email,
    String senha, {
    String? nome,
  }) async {
    if (!emailPermitido(email)) {
      throw DominioNaoPermitidoException();
    }

    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );

    final usuario = credencial.user!;
    final nomeLimpo = nome?.trim();
    if (nomeLimpo != null && nomeLimpo.isNotEmpty) {
      await usuario.updateDisplayName(nomeLimpo);
    }

    return _validarDominioOuDeslogar(usuario);
  }

  Future<User> entrarComGoogle() async {
    if (!googleSignInDisponivel) {
      throw GoogleSignInIndisponivelException();
    }

    final UserCredential credencial;
    if (kIsWeb) {
      try {
        credencial = await executarEntradaGoogle(_auth);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'popup-closed-by-user') {
          throw LoginCanceladoException();
        }
        rethrow;
      }
    } else {
      credencial = await _entrarComGoogleNativo();
    }

    final usuario = await _validarDominioOuDeslogar(credencial.user!);

    if (kIsWeb) {
      await _auth.authStateChanges().firstWhere((u) => u != null);
    }

    return usuario;
  }

  Future<UserCredential> _entrarComGoogleNativo() async {
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

    return _auth.signInWithCredential(credencialFirebase);
  }

  Future<void> sair() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }
}
