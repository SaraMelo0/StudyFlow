class Sessao {
  final String? id;
  final String materia;
  final int duracaoMinutos;
  final DateTime dataHora;
  final String? criadoPor;

  const Sessao({
    this.id,
    required this.materia,
    required this.duracaoMinutos,
    required this.dataHora,
    this.criadoPor,
  });

  Sessao copyWith({
    String? id,
    String? materia,
    int? duracaoMinutos,
    DateTime? dataHora,
    String? criadoPor,
  }) {
    return Sessao(
      id: id ?? this.id,
      materia: materia ?? this.materia,
      duracaoMinutos: duracaoMinutos ?? this.duracaoMinutos,
      dataHora: dataHora ?? this.dataHora,
      criadoPor: criadoPor ?? this.criadoPor,
    );
  }

  Map<String, dynamic> toMap() => {
        'materia': materia,
        'duracao_minutos': duracaoMinutos,
        'data_hora': dataHora.toIso8601String(),
        'criado_por': criadoPor,
      };

  factory Sessao.fromMap(Map<String, dynamic> map, {String? id}) {
    return Sessao(
      id: id,
      materia: (map['materia'] ?? '') as String,
      duracaoMinutos: (map['duracao_minutos'] ?? 0) as int,
      dataHora:
          DateTime.tryParse(map['data_hora']?.toString() ?? '') ?? DateTime.now(),
      criadoPor: map['criado_por'] as String?,
    );
  }
}
