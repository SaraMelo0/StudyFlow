import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_painel.dart';

class CardSequencia extends StatelessWidget {
  const CardSequencia({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return CardPainel(
      filho: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: StudyFlowColors.cardPeach,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department_outlined,
              color: StudyFlowColors.orange,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StudyFlow.painelSequenciaDias.texto,
                  style: temaTexto.titleMedium?.copyWith(
                    color: StudyFlowColors.preto,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  StudyFlow.painelSequenciaRotulo.texto,
                  style: temaTexto.bodySmall?.copyWith(
                    color: StudyFlowColors.labelGray,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Text('🔥', style: TextStyle(fontSize: 32)),
        ],
      ),
    );
  }
}
