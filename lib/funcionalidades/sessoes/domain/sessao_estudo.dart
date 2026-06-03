import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';

class SessaoEstudo {
  const SessaoEstudo({
    required this.id,
    required this.inicio,
    required this.duracaoMin,
    required this.concluida,
  });

  final String id;
  final DateTime inicio;
  final int duracaoMin;
  final bool concluida;

  factory SessaoEstudo.fromFirestore(String id, Map<String, dynamic> dados) {
    final criadoPor = dados[campoCriadoPor] as String?;
    if (criadoPor == null || criadoPor.isEmpty) {
      throw FormatException('Documento sem $campoCriadoPor');
    }

    final inicioRaw = dados['inicio'];
    if (inicioRaw is! Timestamp) {
      throw FormatException('Documento sem inicio válido');
    }

    return SessaoEstudo(
      id: id,
      inicio: inicioRaw.toDate(),
      duracaoMin: (dados['duracao_min'] as num?)?.toInt() ?? 0,
      concluida: dados['concluida'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'inicio': Timestamp.fromDate(inicio),
    'duracao_min': duracaoMin,
    'concluida': concluida,
  };
}
