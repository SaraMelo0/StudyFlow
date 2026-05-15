import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_painel.dart';

class CardProximaMeta extends StatelessWidget {
  const CardProximaMeta({
    super.key,
    required this.temaTexto,
    required this.aoVer,
  });

  final TextTheme temaTexto;
  final VoidCallback aoVer;

  @override
  Widget build(BuildContext context) {
    return CardPainel(
      raioBorda: 28,
      preenchimento: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StudyFlow.painelProximaMeta.texto,
                style: temaTexto.bodyMedium?.copyWith(
                  color: StudyFlowColors.cinza7A,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                ),
              ),
              GestureDetector(
                onTap: aoVer,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  StudyFlow.painelVer.texto,
                  style: temaTexto.labelLarge?.copyWith(
                    color: StudyFlowColors.orange,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: StudyFlowColors.orange,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StudyFlow.painelMetaTitulo.texto,
                      style: temaTexto.titleLarge?.copyWith(
                        color: StudyFlowColors.preto,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      StudyFlow.painelMetaPrazo.texto,
                      style: temaTexto.titleMedium?.copyWith(
                        color: StudyFlowColors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
