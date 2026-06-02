import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

String mensagemErroAutenticacao(
  FirebaseAuthException erro, {
  bool cadastro = false,
}) {
  switch (erro.code) {
    case 'invalid-email':
      return 'E-mail inválido.';
    case 'user-disabled':
      return 'Esta conta foi desativada.';
    case 'user-not-found':
      return cadastro
          ? 'Não foi possível criar a conta.'
          : 'Conta não encontrada. Cadastre-se ou verifique o e-mail.';
    case 'wrong-password':
      return 'Senha incorreta.';
    case 'invalid-credential':
    case 'invalid-login-credential':
      return 'E-mail ou senha incorretos.';
    case 'email-already-in-use':
      return 'Este e-mail já está cadastrado.';
    case 'weak-password':
      return 'Senha muito fraca. Use pelo menos 6 caracteres.';
    case 'too-many-requests':
      return 'Muitas tentativas. Aguarde um momento e tente novamente.';
    case 'operation-not-allowed':
      return 'Login por e-mail não está habilitado no projeto.';
    case 'network-request-failed':
      return 'Sem conexão. Verifique sua internet.';
    case 'account-exists-with-different-credential':
      return 'Já existe uma conta com este e-mail usando outro método de login.';
    case 'credential-already-in-use':
      return 'Esta credencial já está em uso.';
    case 'requires-recent-login':
      return 'Por segurança, faça login novamente.';
    default:
      return cadastro
          ? 'Não foi possível criar a conta. Tente novamente.'
          : 'Não foi possível entrar. Tente novamente.';
  }
}

String mensagemErroGoogleSignIn(PlatformException erro) {
  final detalhe = '${erro.message ?? ''} ${erro.details ?? ''}'.toLowerCase();

  switch (erro.code) {
    case 'sign_in_canceled':
      return '';
    case 'network_error':
      return 'Sem conexão. Verifique sua internet.';
    case 'sign_in_failed':
      if (detalhe.contains('10') || detalhe.contains('developer')) {
        return 'Google Sign-In não configurado. Verifique SHA-1 no Firebase.';
      }
      return 'Falha ao entrar com Google. Tente novamente.';
    default:
      if (detalhe.contains('10') || detalhe.contains('developer')) {
        return 'Google Sign-In não configurado. Verifique SHA-1 no Firebase.';
      }
      return 'Não foi possível entrar com Google. Tente novamente.';
  }
}
