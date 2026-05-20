import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CardResumoHistorico extends StatelessWidget {
  const CardResumoHistorico({
    super.key,
    required this.icone,
    required this.corTema,
    required this.corFundo,
    required this.valor,
    required this.rotulo,
    required this.temaTexto,
  });

  final IconData icone;
  final Color corTema;
  final Color corFundo;
  final String valor;
  final String rotulo;
  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corTema.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Column(
          children: [
            Icon(icone, color: corTema, size: 26),
            const SizedBox(height: 10),
            Text(
              valor,
              style: temaTexto.titleLarge?.copyWith(
                color: CoresAplicacao.preto,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              rotulo,
              style: temaTexto.labelSmall?.copyWith(
                color: CoresAplicacao.cinza7A,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
