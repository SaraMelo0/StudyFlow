import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

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

              corIcone: CoresAplicacao.iconeRoxo,

              valor: TextosAplicacao.dashboardTotalEstudado.texto,

              rotulo: TextosAplicacao.dashboardTotalEstudadoRotulo.texto,

              temaTexto: temaTexto,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: CardEstatistica(
              icone: Icons.emoji_events_outlined,

              corIcone: CoresAplicacao.iconeAmarelo,

              valor: TextosAplicacao.dashboardMetas.texto,

              rotulo: TextosAplicacao.dashboardMetasRotulo.texto,

              temaTexto: temaTexto,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: CardEstatistica(
              icone: Icons.menu_book_outlined,

              corIcone: CoresAplicacao.iconeVerde,

              valor: TextosAplicacao.dashboardMaterias.texto,

              rotulo: TextosAplicacao.dashboardMateriasRotulo.texto,

              temaTexto: temaTexto,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: CardEstatistica(
              icone: Icons.track_changes_rounded,

              corIcone: CoresAplicacao.iconeAzul,

              valor: TextosAplicacao.dashboardSessoes.texto,

              rotulo: TextosAplicacao.dashboardSessoesRotulo.texto,

              temaTexto: temaTexto,
            ),
          ),
        ],
      ),
    );
  }
}
