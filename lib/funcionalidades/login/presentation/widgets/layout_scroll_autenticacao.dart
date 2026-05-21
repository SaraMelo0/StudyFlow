import 'package:flutter/material.dart';

const double larguraMaximaConteudoAutenticacao = 420;

/// Scroll alinhado ao topo para telas de autenticação.
class LayoutScrollAutenticacao extends StatelessWidget {
  const LayoutScrollAutenticacao({super.key, required this.filhos});

  final List<Widget> filhos;

  @override
  Widget build(BuildContext context) {
    final tecladoInferior = MediaQuery.viewInsetsOf(context).bottom;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + tecladoInferior),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: larguraMaximaConteudoAutenticacao,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [const SizedBox(height: 4), ...filhos],
          ),
        ),
      ),
    );
  }
}
