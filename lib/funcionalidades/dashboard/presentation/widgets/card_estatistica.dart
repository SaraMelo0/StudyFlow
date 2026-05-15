import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_painel.dart';

class CardEstatistica extends StatelessWidget {
  const CardEstatistica({
    super.key,
    required this.icone,
    required this.corIcone,
    required this.valor,
    required this.rotulo,
    required this.temaTexto,
  });

  final IconData icone;
  final Color corIcone;
  final String valor;
  final String rotulo;
  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return CardPainel(
      raioBorda: 21,
      preenchimento: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      filho: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icone, color: corIcone, size: 24),
            const SizedBox(height: 9),
            Text(
              valor,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: temaTexto.titleMedium?.copyWith(
                color: StudyFlowColors.preto,
                fontWeight: FontWeight.w800,
                fontSize: 17,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  rotulo,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: temaTexto.labelSmall?.copyWith(
                    color: StudyFlowColors.cinza7A,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
