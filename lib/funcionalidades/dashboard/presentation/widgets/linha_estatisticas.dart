import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_estatistica.dart';

class LinhaEstatisticas extends StatelessWidget {
  const LinhaEstatisticas({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CardEstatistica(
              icone: Icons.schedule_rounded,
              corIcone: StudyFlowColors.statPurple,
              valor: StudyFlow.painelTotalEstudado.texto,
              rotulo: StudyFlow.painelTotalEstudadoRotulo.texto,
              temaTexto: temaTexto,
            ),
          ),
        const SizedBox(width: 8),
        Expanded(
          child: CardEstatistica(
            icone: Icons.emoji_events_outlined,
            corIcone: StudyFlowColors.statYellow,
            valor: StudyFlow.painelMetas.texto,
            rotulo: StudyFlow.painelMetasRotulo.texto,
            temaTexto: temaTexto,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CardEstatistica(
            icone: Icons.menu_book_outlined,
            corIcone: StudyFlowColors.statGreen,
            valor: StudyFlow.painelMaterias.texto,
            rotulo: StudyFlow.painelMateriasRotulo.texto,
            temaTexto: temaTexto,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CardEstatistica(
            icone: Icons.track_changes_rounded,
            corIcone: StudyFlowColors.statBlue,
            valor: StudyFlow.painelSessoes.texto,
            rotulo: StudyFlow.painelSessoesRotulo.texto,
            temaTexto: temaTexto,
          ),
        ),
        ],
      ),
    );
  }
}
