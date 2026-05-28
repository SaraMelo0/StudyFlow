enum RotasNavegacao {
  boasVindas('/'),
  login('/login'),
  cadastro('/cadastro'),
  dashboard('/dashboard'),
  configuracoes('/configuracoes');

  const RotasNavegacao(this.rota);

  final String rota;
}
