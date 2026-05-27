class ConfiguracoesUsuario {
  final String nome;
  final String email;
  final String? avatarUrl;
  
  final int duracaoFocoMinutos;
  final int intervaloCurtoMinutos;
  final int intervaloLongoMinutos;
  final int sessoesAntesIntervaloLongo;
  
  final bool notificacoesAtivadas;
  final bool alertasSonoros;
  final bool lembretesMetas;
  
  final int metaDiariaMinutos;

  const ConfiguracoesUsuario({
    required this.nome,
    required this.email,
    this.avatarUrl,
    this.duracaoFocoMinutos = 25,
    this.intervaloCurtoMinutos = 5,
    this.intervaloLongoMinutos = 15,
    this.sessoesAntesIntervaloLongo = 4,
    this.notificacoesAtivadas = true,
    this.alertasSonoros = true,
    this.lembretesMetas = false,
    this.metaDiariaMinutos = 120,
  });

  double get metaDiariaHoras => metaDiariaMinutos / 60;

  ConfiguracoesUsuario copyWith({
    String? nome,
    String? email,
    String? avatarUrl,
    int? duracaoFocoMinutos,
    int? intervaloCurtoMinutos,
    int? intervaloLongoMinutos,
    int? sessoesAntesIntervaloLongo,
    bool? notificacoesAtivadas,
    bool? alertasSonoros,
    bool? lembretesMetas,
    int? metaDiariaMinutos,
  }) {
    return ConfiguracoesUsuario(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      duracaoFocoMinutos: duracaoFocoMinutos ?? this.duracaoFocoMinutos,
      intervaloCurtoMinutos: intervaloCurtoMinutos ?? this.intervaloCurtoMinutos,
      intervaloLongoMinutos: intervaloLongoMinutos ?? this.intervaloLongoMinutos,
      sessoesAntesIntervaloLongo: sessoesAntesIntervaloLongo ?? this.sessoesAntesIntervaloLongo,
      notificacoesAtivadas: notificacoesAtivadas ?? this.notificacoesAtivadas,
      alertasSonoros: alertasSonoros ?? this.alertasSonoros,
      lembretesMetas: lembretesMetas ?? this.lembretesMetas,
      metaDiariaMinutos: metaDiariaMinutos ?? this.metaDiariaMinutos,
    );
  }
}