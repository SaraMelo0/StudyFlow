import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';

class EtapaMeta {
  const EtapaMeta({
    required this.id,
    required this.texto,
    this.concluida = false,
  });

  final String id;
  final String texto;
  final bool concluida;

  factory EtapaMeta.fromMap(Map<String, dynamic> dados) {
    final id = dados['id'] as String?;
    final texto = dados['texto'] as String?;
    if (id == null || id.isEmpty || texto == null || texto.isEmpty) {
      throw FormatException('Etapa inválida');
    }
    return EtapaMeta(
      id: id,
      texto: texto,
      concluida: dados['concluida'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'texto': texto,
    'concluida': concluida,
  };

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

  factory MetaEstudo.fromFirestore(String id, Map<String, dynamic> dados) {
    final criadoPor = dados[campoCriadoPor] as String?;
    if (criadoPor == null || criadoPor.isEmpty) {
      throw FormatException('Documento sem $campoCriadoPor');
    }

    final titulo = dados['titulo'] as String?;
    if (titulo == null || titulo.isEmpty) {
      throw FormatException('Documento sem titulo');
    }

    final prazoRaw = dados['prazo'];
    if (prazoRaw is! Timestamp) {
      throw FormatException('Documento sem prazo válido');
    }

    final etapas = <EtapaMeta>[];
    final rawEtapas = dados['etapas'];
    if (rawEtapas is List) {
      for (final item in rawEtapas) {
        if (item is Map) {
          etapas.add(
            EtapaMeta.fromMap(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return MetaEstudo(
      id: id,
      titulo: titulo,
      descricao: dados['descricao'] as String? ?? '',
      prazo: prazoRaw.toDate(),
      etapas: etapas,
      concluida: dados['concluida'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'titulo': titulo,
    'descricao': descricao,
    'prazo': Timestamp.fromDate(prazo),
    'concluida': concluida,
    'etapas': etapas.map((e) => e.toMap()).toList(),
  };

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
