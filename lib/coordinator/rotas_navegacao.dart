enum RotasNavegacao {
  boasVindas('/'),
  login('/login'),
  dashboard('/dashboard');

  const RotasNavegacao(this.rota);

  final String rota;
}
