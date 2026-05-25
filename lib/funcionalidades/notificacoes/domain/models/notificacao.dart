import 'package:flutter/material.dart';

class Notificacao {
  const Notificacao({
    required this.id,
    required this.emojiIcone,
    required this.corFundoIcone,
    required this.emojiTitulo,
    required this.titulo,
    required this.descricao,
    required this.tempoRelativo,
    this.lida = false,
  });

  final String id;
  final String emojiIcone;
  final Color corFundoIcone;
  final String emojiTitulo;
  final String titulo;
  final String descricao;
  final String tempoRelativo;
  final bool lida;

  Notificacao copiarCom({bool? lida}) {
    return Notificacao(
      id: id,
      emojiIcone: emojiIcone,
      corFundoIcone: corFundoIcone,
      emojiTitulo: emojiTitulo,
      titulo: titulo,
      descricao: descricao,
      tempoRelativo: tempoRelativo,
      lida: lida ?? this.lida,
    );
  }
}
