import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/presentation/widgets/card_resumo_historico.dart';

class LinhaResumoHistorico extends StatelessWidget {
  const LinhaResumoHistorico({
    super.key,
    required this.temaTexto,
    required this.totalSessoes,
    required this.tempoTotalRotulo,
  });

  final TextTheme temaTexto;
  final int totalSessoes;
  final String tempoTotalRotulo;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CardResumoHistorico(
              icone: Icons.track_changes_rounded,
              corTema: CoresAplicacao.laranja,
              corFundo: CoresAplicacao.fundoResumoLaranja,
              valor: '$totalSessoes',
              rotulo: TextosAplicacao.historicoSessoesRotulo.texto,
              temaTexto: temaTexto,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CardResumoHistorico(
              icone: Icons.track_changes_rounded,
              corTema: CoresAplicacao.iconeRoxo,
              corFundo: CoresAplicacao.fundoResumoRoxo,
              valor: tempoTotalRotulo,
              rotulo: TextosAplicacao.historicoTempoTotalRotulo.texto,
              temaTexto: temaTexto,
            ),
          ),
        ],
      ),
    );
  }
}
