import 'package:study_flow/coordinator/injetor_aplicacao.dart';

/// E-mail do usuário autenticado, ou `null` se a sessão ainda não estiver pronta.
String? emailUsuarioLogadoOuNull() {
  final email = injecaoAplicacao.servicoAutenticacao.usuarioAtual?.email;
  if (email == null || email.trim().isEmpty) return null;
  return email.trim();
}

/// E-mail do usuário autenticado, usado em [campoCriadoPor] e nas consultas Firestore.
String exigirEmailUsuarioLogado() {
  final email = emailUsuarioLogadoOuNull();
  if (email == null) {
    throw StateError('Usuário não autenticado.');
  }
  return email;
}
