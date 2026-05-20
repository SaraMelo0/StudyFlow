import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CabecalhoHistoricoSessoes extends StatelessWidget {
  const CabecalhoHistoricoSessoes({
    super.key,
    required this.temaTexto,
    required this.aoVoltar,
  });

  final TextTheme temaTexto;
  final VoidCallback aoVoltar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: aoVoltar,
          icon: const Icon(Icons.arrow_back_rounded),
          color: CoresAplicacao.preto,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            TextosAplicacao.historicoTitulo.texto,
            style: temaTexto.headlineSmall?.copyWith(
              color: CoresAplicacao.preto,
              fontWeight: FontWeight.w800,
              fontSize: 22,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
