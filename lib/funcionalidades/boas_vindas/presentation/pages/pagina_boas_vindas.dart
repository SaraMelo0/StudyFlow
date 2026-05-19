import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/cabecalho_logo.dart';
import 'package:study_flow/funcionalidades/boas_vindas/presentation/widgets/cartao_funcionalidade.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';

const double _larguraMaximaConteudo = 420;

class PaginaBoasVindas extends StatelessWidget {
  const PaginaBoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    final contextoBoasVindas = context;
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (contextoLayout, restricoes) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: restricoes.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _larguraMaximaConteudo,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        const CabecalhoLogo(),
                        const SizedBox(height: 20),
                        Text(
                          TextosAplicacao.textoBemVindo.texto,
                          textAlign: TextAlign.center,
                          style: temaTexto.titleMedium?.copyWith(
                            color: CoresAplicacao.marromEscuro,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CartaoFuncionalidade(
                          icone: Icons.trending_up_rounded,
                          titulo: TextosAplicacao.progressoTitulo.texto,
                          subtitulo: TextosAplicacao.progressoSubtitulo.texto,
                          temaTexto: temaTexto,
                        ),
                        const SizedBox(height: 12),
                        CartaoFuncionalidade(
                          icone: Icons.bolt_rounded,
                          titulo: TextosAplicacao.pomodoroTitulo.texto,
                          subtitulo: TextosAplicacao.pomodoroSubtitulo.texto,
                          temaTexto: temaTexto,
                        ),
                        const SizedBox(height: 12),
                        CartaoFuncionalidade(
                          icone: Icons.track_changes_rounded,
                          titulo: TextosAplicacao.definaMetasTitulo.texto,
                          subtitulo: TextosAplicacao.definaMetasSubtitulo.texto,
                          temaTexto: temaTexto,
                        ),
                        const SizedBox(height: 36),
                        BotaoPrincipal(
                          rotulo: TextosAplicacao.comecarAgora.texto,
                          temaTexto: temaTexto,
                          aoPressionar: () {
                            EscopoCoordenadorNavegacao.de(
                              contextoBoasVindas,
                            ).mostrarCadastro(contextoBoasVindas);
                          },
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 52,
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: CoresAplicacao.laranja,
                              side: const BorderSide(
                                color: CoresAplicacao.laranja,
                                width: 1.5,
                              ),
                              backgroundColor: CoresAplicacao.fundo,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: temaTexto.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              EscopoCoordenadorNavegacao.de(
                                contextoBoasVindas,
                              ).mostrarLogin(contextoBoasVindas);
                            },
                            child: Text(TextosAplicacao.jaTenhoConta.texto),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          TextosAplicacao.textoRodape.texto,
                          textAlign: TextAlign.center,
                          style: temaTexto.bodyMedium?.copyWith(
                            color: CoresAplicacao.marromEscuro,
                            fontWeight: FontWeight.w500,
                            height: 1.45,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
