import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_hoje.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_dashboard.dart';

class SecaoHoje extends StatelessWidget {
  const SecaoHoje({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return CardDashboard(
      raioBorda: 28,
      preenchimento: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextosAplicacao.dashboardHoje.texto,
            style: temaTexto.titleLarge?.copyWith(
              color: CoresAplicacao.preto,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: CardHoje(
                  valor: TextosAplicacao.dashboardTempoEstudado.texto,
                  rotulo: TextosAplicacao.dashboardTempoEstudadoRotulo.texto,
                  temaTexto: temaTexto,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardHoje(
                  valor: TextosAplicacao.dashboardSessoesConcluidas.texto,
                  rotulo:
                      TextosAplicacao.dashboardSessoesConcluidasRotulo.texto,
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
