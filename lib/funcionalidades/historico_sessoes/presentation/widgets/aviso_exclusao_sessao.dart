import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class AvisoExclusaoSessao extends StatelessWidget {
  const AvisoExclusaoSessao({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoresAplicacao.fundoAvisoHistorico,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: CoresAplicacao.laranja.withValues(alpha: 0.35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            style: temaTexto.bodyMedium?.copyWith(
              color: CoresAplicacao.textoAvisoHistorico,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.45,
            ),
            children: [
              TextSpan(
                text: TextosAplicacao.historicoAvisoTitulo.texto,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              TextSpan(text: ' ${TextosAplicacao.historicoAvisoCorpo.texto}'),
            ],
          ),
        ),
      ),
    );
  }
}
