import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/barra_navegacao.dart';
import 'package:study_flow/funcionalidades/notificacoes/data/notificacoes_iniciais.dart';
import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';
import 'package:study_flow/funcionalidades/notificacoes/presentation/widgets/cabecalho_notificacoes.dart';
import 'package:study_flow/funcionalidades/notificacoes/presentation/widgets/card_notificacao.dart';

/// Tela de notificações.
///
/// Com [notificacoes], [aoMarcarComoLida] e [aoRemover], o estado é controlado
/// pelo ancestral (ex.: [PaginaPrincipal]) e a barra inferior atualiza junto.
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
    this.embutida = false,
    this.aoTocarBarra,
    this.notificacoes,
    this.aoMarcarComoLida,
    this.aoRemover,
  });

  final bool embutida;
  final ValueChanged<int>? aoTocarBarra;
  final List<Notificacao>? notificacoes;
  final ValueChanged<String>? aoMarcarComoLida;
  final ValueChanged<String>? aoRemover;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const double _espacoInferiorBarra = 88;

  late final List<Notificacao> _notificacoesLocais = criarNotificacoesIniciais();

  bool get _controladaPeloAncestral =>
      widget.notificacoes != null &&
      widget.aoMarcarComoLida != null &&
      widget.aoRemover != null;

  List<Notificacao> get _notificacoes =>
      _controladaPeloAncestral ? widget.notificacoes! : _notificacoesLocais;

  int get _quantidadeNaoLidas => contarNotificacoesNaoLidas(_notificacoes);

  bool get _temNotificacoesNaoLidas => temNotificacoesNaoLidas(_notificacoes);

  void _marcarComoLida(String id) {
    if (_controladaPeloAncestral) {
      widget.aoMarcarComoLida!(id);
      return;
    }
    final indice = _notificacoesLocais.indexWhere((n) => n.id == id);
    if (indice == -1 || _notificacoesLocais[indice].lida) return;
    setState(() {
      _notificacoesLocais[indice] =
          _notificacoesLocais[indice].copiarCom(lida: true);
    });
  }

  void _remover(String id) {
    if (_controladaPeloAncestral) {
      widget.aoRemover!(id);
      return;
    }
    setState(() {
      _notificacoesLocais.removeWhere((n) => n.id == id);
    });
  }

  void _mostrarEmBreve() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(TextosAplicacao.funcionalidadeEmBreve.texto)),
    );
  }

  void _aoTocarBarra(int indice) {
    if (widget.aoTocarBarra != null) {
      widget.aoTocarBarra!(indice);
      return;
    }
    if (indice == 3) return;
    if (indice == 0) {
      Navigator.of(context).maybePop();
      return;
    }
    _mostrarEmBreve();
  }

  Widget _buildConteudo(TextTheme temaTexto) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: CabecalhoNotificacoes(
              temaTexto: temaTexto,
              quantidadeNaoLidas: _quantidadeNaoLidas,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _notificacoes.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma notificação',
                      style: temaTexto.bodyMedium?.copyWith(
                        color: CoresAplicacao.cinza7A,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      widget.embutida ? _espacoInferiorBarra : 24,
                    ),
                    itemCount: _notificacoes.length,
                    itemBuilder: (contexto, indice) {
                      final notificacao = _notificacoes[indice];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: indice < _notificacoes.length - 1 ? 16 : 0,
                        ),
                        child: CardNotificacao(
                          notificacao: notificacao,
                          temaTexto: temaTexto,
                          aoMarcarComoLida: () =>
                              _marcarComoLida(notificacao.id),
                          aoExcluir: () => _remover(notificacao.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final conteudo = _buildConteudo(temaTexto);

    if (widget.embutida) {
      return ColoredBox(color: CoresAplicacao.fundo, child: conteudo);
    }

    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      body: conteudo,
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: 3,
        aoTocar: _aoTocarBarra,
        temNotificacoesNaoLidas: _temNotificacoesNaoLidas,
      ),
    );
  }
}
