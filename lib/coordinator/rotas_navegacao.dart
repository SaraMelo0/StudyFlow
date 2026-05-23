enum RotasNavegacao {
  boasVindas('/'),
  login('/login'),
  cadastro('/cadastro'),
  dashboard('/dashboard');

  const RotasNavegacao(this.rota);

  final String rota;
}
