import 'package:flutter/material.dart';

import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/barra_navegacao.dart';
import 'package:study_flow/core/widgets/dialogo_confirmar_sair_conta.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/pages/conteudo_dashboard.dart';
import 'package:study_flow/funcionalidades/materias/presentation/pages/conteudo_materias.dart';
import 'package:study_flow/funcionalidades/notificacoes/data/notificacoes_iniciais.dart';
import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';
import 'package:study_flow/funcionalidades/notificacoes/presentation/pages/notifications_page.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/pages/conteudo_perfil.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalEstado();
}

class _PaginaPrincipalEstado extends State<PaginaPrincipal> {
  static const int _indicePerfil = 4;
  static const int _indiceNotificacoes = 3;

  int _indiceNavegacao = 0;
  final _chavePerfil = GlobalKey<ConteudoPerfilEstado>();
  final List<Notificacao> _notificacoes = criarNotificacoesIniciais();

  bool get _temNotificacoesNaoLidas => temNotificacoesNaoLidas(_notificacoes);

  void _marcarNotificacaoComoLida(String id) {
    final indice = _notificacoes.indexWhere((n) => n.id == id);

    if (indice == -1 || _notificacoes[indice].lida) return;

    setState(() {
      _notificacoes[indice] = _notificacoes[indice].copiarCom(lida: true);
    });
  }

  void _removerNotificacao(String id) {
    setState(() {
      _notificacoes.removeWhere((n) => n.id == id);
    });
  }

  void _mostrarEmBreve() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(TextosAplicacao.funcionalidadeEmBreve.texto)),
    );
  }

  Future<void> _aoSairConta() async {
    final confirmou = await mostrarDialogoConfirmarSairConta(context);
    if (!confirmou || !mounted) return;
    await context.coordenador.sairConta(context);
  }

  void _aoTocarBarra(int indice) {
    if (indice == _indiceNavegacao) return;
    if (indice == 0 ||
        indice == 1 ||
        indice == _indiceNotificacoes ||
        indice == _indicePerfil) {
      setState(() => _indiceNavegacao = indice);
      return;
    }

    _mostrarEmBreve();
  }

  void _irParaMetasNoPerfil() {
    setState(() => _indiceNavegacao = _indicePerfil);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _chavePerfil.currentState?.irParaMetas();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      body: IndexedStack(
        index: _indiceNavegacao,
        children: [
          ConteudoDashboard(
            aoMostrarEmBreve: _mostrarEmBreve,
            aoVerMeta: _irParaMetasNoPerfil,
          ),
          const ConteudoMaterias(),
          const _AbaEmBreve(),
          NotificationsPage(
            embutida: true,
            notificacoes: _notificacoes,
            aoMarcarComoLida: _marcarNotificacaoComoLida,
            aoRemover: _removerNotificacao,
          ),
          ConteudoPerfil(
            key: _chavePerfil,
            aoMostrarEmBreve: _mostrarEmBreve,
            aoSairConta: _aoSairConta,
          ),
        ],
      ),
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: _indiceNavegacao,
        aoTocar: _aoTocarBarra,
        temNotificacoesNaoLidas: _temNotificacoesNaoLidas,
      ),
    );
  }
}

class _AbaEmBreve extends StatelessWidget {
  const _AbaEmBreve();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: CoresAplicacao.fundo,
      child: SafeArea(child: SizedBox.expand()),
    );
  }
}
