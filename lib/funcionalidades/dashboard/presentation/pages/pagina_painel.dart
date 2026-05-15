import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/core/widgets/studyflow_button.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/barra_navegacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/cabecalho_painel.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_progresso_semanal.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_proxima_meta.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_sequencia.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/linha_estatisticas.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/secao_hoje.dart';

class PaginaPainel extends StatefulWidget {
  const PaginaPainel({super.key});

  @override
  State<PaginaPainel> createState() => _PaginaPainelState();
}

class _PaginaPainelState extends State<PaginaPainel> {
  int _indiceNavegacao = 0;

  void _mostrarEmBreve() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(StudyFlow.funcionalidadeEmBreve.texto)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: StudyFlowColors.background,
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: _indiceNavegacao,
        aoTocar: (indice) {
          if (indice == 0) {
            setState(() => _indiceNavegacao = 0);
            return;
          }
          _mostrarEmBreve();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CabecalhoPainel(temaTexto: temaTexto),
              const SizedBox(height: 16),
              SecaoHoje(temaTexto: temaTexto),
              const SizedBox(height: 16),
              CardSequencia(temaTexto: temaTexto),
              const SizedBox(height: 16),
              CardProgressoSemanal(temaTexto: temaTexto),
              const SizedBox(height: 20),
              StudyflowPrimaryCta(
                label: StudyFlow.painelIniciarSessao.texto,
                textTheme: temaTexto,
                onPressed: _mostrarEmBreve,
                leading: const Icon(
                  Icons.play_circle_outline_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 20),
              LinhaEstatisticas(temaTexto: temaTexto),
              const SizedBox(height: 16),
              CardProximaMeta(
                temaTexto: temaTexto,
                aoVer: _mostrarEmBreve,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
