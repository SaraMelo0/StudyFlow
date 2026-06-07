import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/injetor_aplicacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/barra_navegacao.dart';
import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';
import 'package:study_flow/funcionalidades/notificacoes/presentation/widgets/cabecalho_notificacoes.dart';
import 'package:study_flow/funcionalidades/notificacoes/presentation/widgets/card_notificacao.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
    this.embutida = false,
    this.aoTocarBarra,
  });

  final bool embutida;
  final ValueChanged<int>? aoTocarBarra;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const double _espacoInferiorBarra = 88;

  final _repositorio = injecaoAplicacao.repositorioNotificacoes;

  @override
  void initState() {
    super.initState();
    _repositorio.semearSeVazio();
  }

  Future<void> _marcarComoLida(String id) async {
    await _repositorio.marcarComoLida(id);
  }

  Future<void> _remover(String id) async {
    await _repositorio.excluir(id);
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
  }

  Widget _buildConteudo(
    TextTheme temaTexto,
    AsyncSnapshot<List<Notificacao>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            TextosAplicacao.notificacoesErroCarregar.texto,
            textAlign: TextAlign.center,
            style: temaTexto.bodyMedium,
          ),
        ),
      );
    }

    final carregando =
        snapshot.connectionState == ConnectionState.waiting &&
        !snapshot.hasData;

    if (carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    final notificacoes = snapshot.data ?? const <Notificacao>[];
    final quantidadeNaoLidas =
        notificacoes.where((n) => !n.lida).length;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: CabecalhoNotificacoes(
              temaTexto: temaTexto,
              quantidadeNaoLidas: quantidadeNaoLidas,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: notificacoes.isEmpty
                ? Center(
                    child: Text(
                      TextosAplicacao.notificacoesNenhuma.texto,
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
                    itemCount: notificacoes.length,
                    itemBuilder: (contexto, indice) {
                      final notificacao = notificacoes[indice];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: indice < notificacoes.length - 1 ? 16 : 0,
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

    return StreamBuilder<List<Notificacao>>(
      stream: _repositorio.observarNotificacoes(),
      builder: (context, snapshot) {
        final conteudo = _buildConteudo(temaTexto, snapshot);

        if (widget.embutida) {
          return ColoredBox(color: CoresAplicacao.fundo, child: conteudo);
        }

        final temNaoLidas = (snapshot.data ?? []).any((n) => !n.lida);

        return Scaffold(
          backgroundColor: CoresAplicacao.fundo,
          body: conteudo,
          bottomNavigationBar: BarraNavegacao(
            indiceAtual: 3,
            aoTocar: _aoTocarBarra,
            temNotificacoesNaoLidas: temNaoLidas,
          ),
        );
      },
    );
  }
}
