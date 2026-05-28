import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CardHoje extends StatelessWidget {
  const CardHoje({
    super.key,
    required this.valor,
    required this.rotulo,
    required this.temaTexto,
  });

  final String valor;
  final String rotulo;
  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: CoresAplicacao.cartaoPessego,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            valor,
            textAlign: TextAlign.center,
            style: temaTexto.headlineSmall?.copyWith(
              color: CoresAplicacao.laranja,
              fontWeight: FontWeight.w800,
              fontSize: 22,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            rotulo,
            textAlign: TextAlign.center,
            style: temaTexto.bodySmall?.copyWith(
              color: CoresAplicacao.cinza7A,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
