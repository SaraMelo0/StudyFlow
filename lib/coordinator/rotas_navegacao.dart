enum RotasNavegacao {
  boasVindas('/'),
  login('/login'),
  cadastro('/cadastro'),
  dashboard('/dashboard'),
  configuracoes('/configuracoes'),
  recuperarSenha('/recuperar-senha'),
  historico('/historico');

  const RotasNavegacao(this.rota);

  final String rota;
}
