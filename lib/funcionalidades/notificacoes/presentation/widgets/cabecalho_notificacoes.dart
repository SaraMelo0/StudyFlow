import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CabecalhoNotificacoes extends StatelessWidget {
  const CabecalhoNotificacoes({
    super.key,
    required this.temaTexto,
    required this.quantidadeNaoLidas,
  });

  final TextTheme temaTexto;
  final int quantidadeNaoLidas;

  String get _subtitulo {
    if (quantidadeNaoLidas == 0) return 'Nenhuma não lida';
    if (quantidadeNaoLidas == 1) return '1 não lida';
    return '$quantidadeNaoLidas não lidas';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notificações',
          style: temaTexto.headlineSmall?.copyWith(
            color: CoresAplicacao.preto,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _subtitulo,
          style: temaTexto.bodyMedium?.copyWith(
            color: CoresAplicacao.cinzaRotulo,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
