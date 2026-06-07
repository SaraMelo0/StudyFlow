import 'package:firebase_auth/firebase_auth.dart';
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

class ServicoAutenticacao {
  ServicoAutenticacao({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
    : _auth = auth ?? FirebaseAuth.instance,
      _googleSignIn =
          googleSignIn ??
          GoogleSignIn(serverClientId: idClienteWebGoogle, scopes: ['email']);

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

  Future<void> enviarEmailRedefinicaoSenha(String email) async {
    if (!emailPermitido(email)) throw DominioNaoPermitidoException();
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> sair() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }
}
