import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_painel.dart';

class CardProgressoSemanal extends StatelessWidget {
  const CardProgressoSemanal({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  static const _rotulosDias = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    return CardPainel(
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  StudyFlow.painelProgressoSemanal.texto,
                  style: temaTexto.titleMedium?.copyWith(
                    color: StudyFlowColors.preto,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(
                Icons.trending_up_rounded,
                color: StudyFlowColors.orange,
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  StudyFlow.painelProgressoHoras.texto,
                  style: temaTexto.bodyMedium?.copyWith(
                    color: StudyFlowColors.labelGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                StudyFlow.painelProgressoPercentual.texto,
                style: temaTexto.titleMedium?.copyWith(
                  color: StudyFlowColors.labelGray,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const LinearProgressIndicator(
              value: 0.83,
              minHeight: 10,
              backgroundColor: StudyFlowColors.progressTrack,
              color: StudyFlowColors.orange,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _rotulosDias
                .map(
                  (rotulo) => Text(
                    rotulo,
                    style: temaTexto.labelSmall?.copyWith(
                      color: StudyFlowColors.labelGray,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
