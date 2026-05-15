import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_hoje.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_painel.dart';

class SecaoHoje extends StatelessWidget {
  const SecaoHoje({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return CardPainel(
      raioBorda: 28,
      preenchimento: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StudyFlow.painelHoje.texto,
            style: temaTexto.titleLarge?.copyWith(
              color: StudyFlowColors.preto,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: CardHoje(
                  valor: StudyFlow.painelTempoEstudado.texto,
                  rotulo: StudyFlow.painelTempoEstudadoRotulo.texto,
                  temaTexto: temaTexto,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardHoje(
                  valor: StudyFlow.painelSessoesConcluidas.texto,
                  rotulo: StudyFlow.painelSessoesConcluidasRotulo.texto,
                  temaTexto: temaTexto,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
