import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/utils/formatador_data.dart';

class CabecalhoDashboard extends StatelessWidget {
  const CabecalhoDashboard({super.key, required this.temaTexto});
  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    final dataAtual = formatarDataPorExtenso(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextosAplicacao.dashboardSaudacao.texto,
          style: temaTexto.headlineSmall?.copyWith(
            color: CoresAplicacao.preto,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          dataAtual,
          style: temaTexto.bodyMedium?.copyWith(
            color: CoresAplicacao.cinzaMedio,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
