import 'package:flutter/material.dart';

import 'package:study_flow/core/firebase/email_usuario_logado.dart';
import 'package:study_flow/funcionalidades/notificacoes/data/repositorio_notificacoes_firestore.dart';
import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';

const String _dominioInstitucional = '@souunit.com.br';

const Color _corLaranja = Color(0xFFFFE4D6);
const Color _corRoxo = Color(0xFFF3E8FF);
const Color _corBege = Color(0xFFF5EDE4);

class ServicoNotificacoes {
  ServicoNotificacoes(this._repositorio);

  final RepositorioNotificacoesFirestore _repositorio;

  Future<void> notificarMateriaCriada(String nomeMateria) => _criar(
    tipo: 'materia_criada',
    titulo: 'Matéria cadastrada',
    descricao: 'Matéria cadastrada com sucesso: $nomeMateria',
    emojiIcone: '📚',
    corFundoIcone: _corLaranja,
    emojiTitulo: '✅',
  );

  Future<void> notificarMateriaAtualizada(String nomeMateria) => _criar(
    tipo: 'materia_atualizada',
    titulo: 'Matéria atualizada',
    descricao: 'Matéria atualizada: $nomeMateria',
    emojiIcone: '✏️',
    corFundoIcone: _corRoxo,
    emojiTitulo: '📝',
  );

  Future<void> notificarMateriaRemovida(String nomeMateria) => _criar(
    tipo: 'materia_removida',
    titulo: 'Matéria removida',
    descricao: 'Matéria removida: $nomeMateria',
    emojiIcone: '🗑️',
    corFundoIcone: _corBege,
    emojiTitulo: '🔔',
  );

  Future<void> notificarMetaCriada(String tituloMeta) => _criar(
    tipo: 'meta_criada',
    titulo: 'Meta cadastrada',
    descricao: 'Meta cadastrada com sucesso: $tituloMeta',
    emojiIcone: '🎯',
    corFundoIcone: _corLaranja,
    emojiTitulo: '✅',
  );

  Future<void> notificarMetaAtualizada(String tituloMeta) => _criar(
    tipo: 'meta_atualizada',
    titulo: 'Meta atualizada',
    descricao: 'Meta atualizada: $tituloMeta',
    emojiIcone: '✏️',
    corFundoIcone: _corRoxo,
    emojiTitulo: '📝',
  );

  Future<void> notificarMetaRemovida(String tituloMeta) => _criar(
    tipo: 'meta_removida',
    titulo: 'Meta removida',
    descricao: 'Meta removida: $tituloMeta',
    emojiIcone: '🗑️',
    corFundoIcone: _corBege,
    emojiTitulo: '🔔',
  );

  Future<void> notificarMetaConcluida(String tituloMeta) => _criar(
    tipo: 'meta_concluida',
    titulo: 'Meta concluída',
    descricao: 'Parabéns! Você concluiu a meta: $tituloMeta',
    emojiIcone: '🏆',
    corFundoIcone: _corLaranja,
    emojiTitulo: '🎉',
  );

  Future<void> notificarFoco() {
    const mensagens = [
      'Hora de revisar suas matérias.',
      'Mantenha o foco nos estudos.',
      'Não esqueça de atualizar suas metas.',
      'Continue estudando para alcançar suas metas.',
    ];
    final mensagem = mensagens[DateTime.now().minute % mensagens.length];
    return _criar(
      tipo: 'lembrete_foco',
      titulo: 'Lembrete de foco',
      descricao: mensagem,
      emojiIcone: '⏰',
      corFundoIcone: _corLaranja,
      emojiTitulo: '📚',
    );
  }

  Future<void> _criar({
    required String tipo,
    required String titulo,
    required String descricao,
    required String emojiIcone,
    required Color corFundoIcone,
    required String emojiTitulo,
  }) async {
    final email = exigirEmailUsuarioLogado();
    if (!email.endsWith(_dominioInstitucional)) {
      throw StateError(
        'Operação bloqueada: e-mail não pertence ao domínio $_dominioInstitucional.',
      );
    }

    final notificacao = Notificacao(
      id: '',
      tipo: tipo,
      titulo: titulo,
      descricao: descricao,
      emojiIcone: emojiIcone,
      corFundoIcone: corFundoIcone,
      emojiTitulo: emojiTitulo,
      criadoEm: DateTime.now(),
    );

    await _repositorio.criar(notificacao);
  }
}
