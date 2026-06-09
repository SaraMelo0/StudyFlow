import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';

class Notificacao {
  const Notificacao({
    required this.id,
    required this.tipo,
    required this.emojiIcone,
    required this.corFundoIcone,
    required this.emojiTitulo,
    required this.titulo,
    required this.descricao,
    required this.criadoEm,
    this.lida = false,
  });

  final String id;
  final String tipo;
  final String emojiIcone;
  final Color corFundoIcone;
  final String emojiTitulo;
  final String titulo;
  final String descricao;
  final DateTime criadoEm;
  final bool lida;

  String get tempoRelativo {
    final diferenca = DateTime.now().difference(criadoEm);
    if (diferenca.inMinutes < 60) return '${diferenca.inMinutes}m atrás';
    if (diferenca.inHours < 24) return '${diferenca.inHours}h atrás';
    if (diferenca.inDays == 1) return 'ontem';
    return '${diferenca.inDays} dias atrás';
  }

  factory Notificacao.fromFirestore(String id, Map<String, dynamic> dados) {
    final titulo = dados['titulo'] as String?;
    if (titulo == null || titulo.isEmpty) {
      throw const FormatException('Documento sem titulo');
    }

    final criadoEmRaw = dados[campoCriadoEm];
    if (criadoEmRaw is! Timestamp) {
      throw const FormatException('Documento sem criadoEm válido');
    }

    return Notificacao(
      id: id,
      tipo: dados['tipo'] as String? ?? '',
      emojiIcone: dados['emoji_icone'] as String? ?? '🔔',
      corFundoIcone: Color(dados['cor_fundo_icone'] as int? ?? 0xFFFFE4D6),
      emojiTitulo: dados['emoji_titulo'] as String? ?? '',
      titulo: titulo,
      descricao: dados['descricao'] as String? ?? '',
      criadoEm: criadoEmRaw.toDate(),
      lida: dados['lida'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'tipo': tipo,
    'emoji_icone': emojiIcone,
    'cor_fundo_icone': corFundoIcone.toARGB32(),
    'emoji_titulo': emojiTitulo,
    'titulo': titulo,
    'descricao': descricao,
    'lida': lida,
  };

  Notificacao copyWith({bool? lida}) {
    return Notificacao(
      id: id,
      tipo: tipo,
      emojiIcone: emojiIcone,
      corFundoIcone: corFundoIcone,
      emojiTitulo: emojiTitulo,
      titulo: titulo,
      descricao: descricao,
      criadoEm: criadoEm,
      lida: lida ?? this.lida,
    );
  }
}
