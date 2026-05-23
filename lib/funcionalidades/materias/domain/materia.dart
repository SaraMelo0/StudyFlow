class Materia {
  const Materia({
    required this.id,
    required this.nome,
    required this.horasEstudadas,
    required this.progressoPercentual,
  });

  final String id;
  final String nome;
  final double horasEstudadas;
  final int progressoPercentual;

  Materia copyWith({
    String? nome,
    double? horasEstudadas,
    int? progressoPercentual,
  }) {
    return Materia(
      id: id,
      nome: nome ?? this.nome,
      horasEstudadas: horasEstudadas ?? this.horasEstudadas,
      progressoPercentual: progressoPercentual ?? this.progressoPercentual,
    );
  }
}
