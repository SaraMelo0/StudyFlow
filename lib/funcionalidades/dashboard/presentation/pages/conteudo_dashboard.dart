import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/injetor_aplicacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/utils/dados_usuario_auth.dart';
import 'package:study_flow/core/utils/formatador_data.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';
import 'package:study_flow/funcionalidades/dashboard/domain/calculo_dashboard.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/cabecalho_dashboard.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_progresso_semanal.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_proxima_meta.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_sequencia.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/linha_estatisticas.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/secao_hoje.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';

class ConteudoDashboard extends StatelessWidget {
  const ConteudoDashboard({
    super.key,
    required this.aoMostrarEmBreve,
    required this.aoVerMeta,
  });

  final VoidCallback aoMostrarEmBreve;
  final VoidCallback aoVerMeta;

  static const String _placeholder = '—';

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final usuario = injecaoAplicacao.servicoAutenticacao.usuarioAtual;
    final nomeUsuario = nomeExibicaoDoUsuario(
      usuario?.displayName,
      usuario?.email,
    );

    return SafeArea(
      bottom: false,
      child: StreamBuilder<List<MetaEstudo>>(
        stream: injecaoAplicacao.repositorioMetas.observarMetas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Erro ao carregar o dashboard. Verifique o Firestore.',
                  textAlign: TextAlign.center,
                  style: temaTexto.bodyMedium,
                ),
              ),
            );
          }

          final carregando =
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData;

          if (carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          final metas = snapshot.data ?? const <MetaEstudo>[];
          final proxima = proximaMetaAtiva(metas);
          final qtdMetas = contarMetasAtivas(metas);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CabecalhoDashboard(
                  temaTexto: temaTexto,
                  nomeUsuario: nomeUsuario,
                ),
                const SizedBox(height: 16),
                SecaoHoje(
                  temaTexto: temaTexto,
                  tempoEstudado: '0h',
                  sessoesConcluidas: '0',
                ),
                const SizedBox(height: 16),
                CardSequencia(
                  temaTexto: temaTexto,
                  sequenciaDias: '0 dias',
                ),
                const SizedBox(height: 16),
                CardProgressoSemanal(
                  temaTexto: temaTexto,
                  horasTexto: '0h de $_placeholder',
                  percentualTexto: '0%',
                  valorProgresso: 0,
                ),
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
                LinhaEstatisticas(
                  temaTexto: temaTexto,
                  valorTotalEstudado: _placeholder,
                  valorMetas: '$qtdMetas',
                  valorMaterias: _placeholder,
                  valorSessoes: _placeholder,
                ),
                const SizedBox(height: 16),
                CardProximaMeta(
                  temaTexto: temaTexto,
                  aoVer: aoVerMeta,
                  titulo: proxima?.titulo ?? 'Nenhuma meta ativa',
                  prazo: proxima != null
                      ? 'Prazo: ${formatarDataCurta(proxima.prazo)}'
                      : 'Crie uma meta no perfil',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
