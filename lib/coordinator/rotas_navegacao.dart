enum RotasNavegacao {
  boasVindas('/'),
  login('/login'),
  cadastro('/cadastro'),
  dashboard('/dashboard'),
  configuracoes('/configuracoes'),
  recuperarSenha('/recuperar-senha');

  const RotasNavegacao(this.rota);

  final String rota;
}
