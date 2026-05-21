import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/cabecalho_dashboard.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_progresso_semanal.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_proxima_meta.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_sequencia.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/linha_estatisticas.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/secao_hoje.dart';

class ConteudoDashboard extends StatelessWidget {
  const ConteudoDashboard({
    super.key,
    required this.aoMostrarEmBreve,
    required this.aoVerMeta,
  });

  final VoidCallback aoMostrarEmBreve;
  final VoidCallback aoVerMeta;

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CabecalhoDashboard(temaTexto: temaTexto),
            const SizedBox(height: 16),
            SecaoHoje(temaTexto: temaTexto),
            const SizedBox(height: 16),
            CardSequencia(temaTexto: temaTexto),
            const SizedBox(height: 16),
            CardProgressoSemanal(temaTexto: temaTexto),
            const SizedBox(height: 20),
            BotaoPrincipal(
              rotulo: TextosAplicacao.dashboardIniciarSessao.texto,
              temaTexto: temaTexto,
              aoPressionar: aoMostrarEmBreve,
              iconePrefixo: const Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 20),
            LinhaEstatisticas(temaTexto: temaTexto),
            const SizedBox(height: 16),
            CardProximaMeta(temaTexto: temaTexto, aoVer: aoVerMeta),
          ],
        ),
      ),
    );
  }
}
