import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/core/utils/formatador_data.dart';

class CabecalhoPainel extends StatelessWidget {
  const CabecalhoPainel({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    final dataAtual = formatarDataPorExtenso(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StudyFlow.painelSaudacao.texto,
          style: temaTexto.headlineSmall?.copyWith(
            color: StudyFlowColors.preto,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dataAtual,
          style: temaTexto.bodyMedium?.copyWith(
            color: StudyFlowColors.labelGray,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
