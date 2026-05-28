import 'package:flutter/material.dart';

import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';

const Color _fundoIconeLaranja = Color(0xFFFFE4D6);
const Color _fundoIconeRoxo = Color(0xFFF3E8FF);
const Color _fundoIconeBege = Color(0xFFF5EDE4);

/// Retorna cópia mutável (necessário no Flutter Web para marcar/excluir).
List<Notificacao> criarNotificacoesIniciais() {
  return List<Notificacao>.of(const [
    Notificacao(
      id: '1',
      emojiIcone: '🔥',
      corFundoIcone: _fundoIconeLaranja,
      emojiTitulo: '🥳',
      titulo: 'Parabéns',
      descricao: 'Você completou 3 dias seguidos de estudo. Continue assim!',
      tempoRelativo: '37m atrás',
    ),
    Notificacao(
      id: '2',
      emojiIcone: '⏰',
      corFundoIcone: _fundoIconeLaranja,
      emojiTitulo: '📚',
      titulo: 'Hora de estudar!',
      descricao:
          'Que tal uma sessão de estudos agora? Você está indo muito bem!',
      tempoRelativo: '2h atrás',
    ),
    Notificacao(
      id: '3',
      emojiIcone: '💡',
      corFundoIcone: _fundoIconeRoxo,
      emojiTitulo: '💪',
      titulo: 'Continue firme!',
      descricao: 'Você já estudou 12h essa semana. Está no caminho certo!',
      tempoRelativo: 'ontem',
      lida: true,
    ),
    Notificacao(
      id: '4',
      emojiIcone: '🎓',
      corFundoIcone: _fundoIconeBege,
      emojiTitulo: '🏆',
      titulo: 'Nova conquista!',
      descricao: 'Você completou sua primeira meta! Parabéns pelo esforço.',
      tempoRelativo: '2h atrás',
      lida: true,
    ),
  ]);
}

int contarNotificacoesNaoLidas(List<Notificacao> notificacoes) {
  return notificacoes.where((notificacao) => !notificacao.lida).length;
}

bool temNotificacoesNaoLidas(List<Notificacao> notificacoes) {
  return contarNotificacoesNaoLidas(notificacoes) > 0;
}
