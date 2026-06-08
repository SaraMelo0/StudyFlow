import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_dashboard.dart';

class CardProgressoSemanal extends StatelessWidget {
  const CardProgressoSemanal({
    super.key,
    required this.temaTexto,
    required this.horasTexto,
    required this.percentualTexto,
    required this.valorProgresso,
  });

  final TextTheme temaTexto;
  final String horasTexto;
  final String percentualTexto;
  final double valorProgresso;

  static const _rotulosDias = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    return CardDashboard(
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  TextosAplicacao.dashboardProgressoSemanal.texto,
                  style: temaTexto.titleMedium?.copyWith(
                    color: CoresAplicacao.preto,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),

              const Icon(
                Icons.trending_up_rounded,
                color: CoresAplicacao.laranja,
                size: 22,
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Text(
                  horasTexto,
                  style: temaTexto.bodyMedium?.copyWith(
                    color: CoresAplicacao.cinzaMedio,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),

              Text(
                percentualTexto,
                style: temaTexto.titleMedium?.copyWith(
                  color: CoresAplicacao.cinzaMedio,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(6),

            child: LinearProgressIndicator(
              value: valorProgresso.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: CoresAplicacao.trilhoProgresso,
              color: CoresAplicacao.laranjaSuave,
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
                      color: CoresAplicacao.cinzaMedio,
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
