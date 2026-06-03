import 'package:study_flow/coordinator/injetor_aplicacao.dart';

/// E-mail do usuário autenticado, usado em [campoCriadoPor] e nas consultas Firestore.
String exigirEmailUsuarioLogado() {
  final email = injecaoAplicacao.servicoAutenticacao.usuarioAtual?.email;
  if (email == null || email.trim().isEmpty) {
    throw StateError('Usuário não autenticado.');
  }
  return email.trim();
}
