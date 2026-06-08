import 'package:study_flow/core/firebase/campos_firestore.dart';

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

  factory Materia.fromFirestore(String id, Map<String, dynamic> dados) {
    final criadoPor = dados[campoCriadoPor] as String?;
    if (criadoPor == null || criadoPor.isEmpty) {
      throw FormatException('Documento sem $campoCriadoPor');
    }

    final nome = dados[campoNome] as String?;
    if (nome == null || nome.isEmpty) {
      throw FormatException('Documento sem $campoNome');
    }

    final horasRaw = dados[campoHorasEstudadas];
    final horasEstudadas = horasRaw is num ? horasRaw.toDouble() : 0.0;

    return Materia(
      id: id,
      nome: nome,
      horasEstudadas: horasEstudadas,
      progressoPercentual:
          (dados[campoProgressoPercentual] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    campoNome: nome,
    campoHorasEstudadas: horasEstudadas,
    campoProgressoPercentual: progressoPercentual,
  };

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
