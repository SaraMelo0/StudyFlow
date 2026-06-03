String nomeExibicaoDoUsuario(String? displayName, String? email) {
  final nome = displayName?.trim();
  if (nome != null && nome.isNotEmpty) return nome;

  final mail = email?.trim();
  if (mail == null || mail.isEmpty) return 'Usuário';

  final parteLocal = mail.split('@').first;
  return parteLocal.isEmpty ? mail : parteLocal;
}

String emailExibicaoDoUsuario(String? email) {
  return email?.trim().isNotEmpty == true ? email!.trim() : '—';
}

String inicialDoUsuario(String nomeExibicao) {
  final limpo = nomeExibicao.trim();
  if (limpo.isEmpty) return '?';
  return limpo[0].toUpperCase();
}
