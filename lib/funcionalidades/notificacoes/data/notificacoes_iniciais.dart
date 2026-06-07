import 'package:flutter/material.dart';

import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';

const Color _fundoIconeLaranja = Color(0xFFFFE4D6);
const Color _fundoIconeRoxo = Color(0xFFF3E8FF);
const Color _fundoIconeBege = Color(0xFFF5EDE4);

/// Notificações usadas como semente inicial no Firestore quando o usuário
/// não possui nenhuma notificação cadastrada.
List<Notificacao> criarNotificacoesParaSemente() {
  final agora = DateTime.now();
  return [
    Notificacao(
      id: '',
      emojiIcone: '🔥',
      corFundoIcone: _fundoIconeLaranja,
      emojiTitulo: '🥳',
      titulo: 'Parabéns',
      descricao: 'Você completou 3 dias seguidos de estudo. Continue assim!',
      criadoEm: agora.subtract(const Duration(minutes: 37)),
    ),
    Notificacao(
      id: '',
      emojiIcone: '⏰',
      corFundoIcone: _fundoIconeLaranja,
      emojiTitulo: '📚',
      titulo: 'Hora de estudar!',
      descricao: 'Que tal uma sessão de estudos agora? Você está indo muito bem!',
      criadoEm: agora.subtract(const Duration(hours: 2)),
    ),
    Notificacao(
      id: '',
      emojiIcone: '💡',
      corFundoIcone: _fundoIconeRoxo,
      emojiTitulo: '💪',
      titulo: 'Continue firme!',
      descricao: 'Você já estudou 12h essa semana. Está no caminho certo!',
      criadoEm: agora.subtract(const Duration(days: 1, hours: 3)),
      lida: true,
    ),
    Notificacao(
      id: '',
      emojiIcone: '🎓',
      corFundoIcone: _fundoIconeBege,
      emojiTitulo: '🏆',
      titulo: 'Nova conquista!',
      descricao: 'Você completou sua primeira meta! Parabéns pelo esforço.',
      criadoEm: agora.subtract(const Duration(hours: 2, minutes: 10)),
      lida: true,
    ),
  ];
}

int contarNotificacoesNaoLidas(List<Notificacao> notificacoes) =>
    notificacoes.where((n) => !n.lida).length;

bool temNotificacoesNaoLidas(List<Notificacao> notificacoes) =>
    contarNotificacoesNaoLidas(notificacoes) > 0;
