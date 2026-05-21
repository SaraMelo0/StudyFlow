class EtapaMeta {
  const EtapaMeta({
    required this.id,
    required this.texto,
    this.concluida = false,
  });

  final String id;
  final String texto;
  final bool concluida;

  EtapaMeta copyWith({String? texto, bool? concluida}) {
    return EtapaMeta(
      id: id,
      texto: texto ?? this.texto,
      concluida: concluida ?? this.concluida,
    );
  }
}

class MetaEstudo {
  const MetaEstudo({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.prazo,
    required this.etapas,
    this.concluida = false,
  });

  final String id;
  final String titulo;
  final String descricao;
  final DateTime prazo;
  final List<EtapaMeta> etapas;
  final bool concluida;

  int get etapasConcluidas => etapas.where((e) => e.concluida).length;

  double get valorProgresso =>
      etapas.isEmpty ? 0 : etapasConcluidas / etapas.length;

  String get rotuloProgressoEtapas =>
      '$etapasConcluidas/${etapas.length} etapas';

  MetaEstudo copyWith({
    String? titulo,
    String? descricao,
    DateTime? prazo,
    List<EtapaMeta>? etapas,
    bool? concluida,
  }) {
    return MetaEstudo(
      id: id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      prazo: prazo ?? this.prazo,
      etapas: etapas ?? this.etapas,
      concluida: concluida ?? this.concluida,
    );
  }
}
