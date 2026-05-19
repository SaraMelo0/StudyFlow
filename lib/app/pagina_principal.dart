import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/barra_navegacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/pages/conteudo_dashboard.dart';

/// Shell com barra de navegação inferior compartilhada por todas as abas do app.
class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalEstado();
}

class _PaginaPrincipalEstado extends State<PaginaPrincipal> {
  int _indiceNavegacao = 0;

  void _mostrarEmBreve() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(TextosAplicacao.funcionalidadeEmBreve.texto)),
    );
  }

  void _aoTocarBarra(int indice) {
    if (indice == _indiceNavegacao) return;
    if (indice == 0) {
      setState(() => _indiceNavegacao = 0);
      return;
    }
    _mostrarEmBreve();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CoresAplicacao.fundo,
      body: IndexedStack(
        index: _indiceNavegacao,
        children: [
          ConteudoDashboard(aoMostrarEmBreve: _mostrarEmBreve),
          const _AbaEmBreve(),
          const _AbaEmBreve(),
          const _AbaEmBreve(),
          const _AbaEmBreve(),
        ],
      ),
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: _indiceNavegacao,
        aoTocar: _aoTocarBarra,
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
