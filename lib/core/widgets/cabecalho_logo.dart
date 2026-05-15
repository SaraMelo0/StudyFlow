import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CabecalhoLogo extends StatelessWidget {
  const CabecalhoLogo({
    super.key,
    this.aoVoltar,
    this.alturaLogo = 40,
    this.caminhoLogo = 'assets/logo/logo-studyflow.png',
  });

  final VoidCallback? aoVoltar;
  final double alturaLogo;
  final String caminhoLogo;

  static const double _larguraLateral = 48;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _larguraLateral,
          height: _larguraLateral,
          child: aoVoltar != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: CoresAplicacao.preto,
                  onPressed: aoVoltar,
                  padding: EdgeInsets.zero,
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: Center(
            child: Image.asset(
              caminhoLogo,
              height: alturaLogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: _larguraLateral),
      ],
    );
  }
}
