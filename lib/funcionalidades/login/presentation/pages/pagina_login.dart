import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/cabecalho_logo.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/cartao_credenciais.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/rodape_cadastro.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/secao_login_social.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';

const double _larguraMaximaConteudo = 420;

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginEstado();
}

class _PaginaLoginEstado extends State<PaginaLogin> {
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }

  void _mostrarEmBreve() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(TextosAplicacao.funcionalidadeEmBreve.texto)),
    );
  }

  void _aoEntrar() {
    EscopoCoordenadorNavegacao.de(context).mostrarDashboard(context);
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final margemInferior = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (contextoLayout, restricoes) {
            final tecladoInferior = MediaQuery.viewInsetsOf(context).bottom;
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + tecladoInferior),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: restricoes.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _larguraMaximaConteudo,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 4),
                        CabecalhoLogo(
                          aoVoltar: () {
                            EscopoCoordenadorNavegacao.de(
                              context,
                            ).voltar(context);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          TextosAplicacao.loginTitulo.texto,
                          textAlign: TextAlign.center,
                          style: temaTexto.headlineSmall?.copyWith(
                            color: CoresAplicacao.laranja,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          TextosAplicacao.loginSubtitulo.texto,
                          textAlign: TextAlign.center,
                          style: temaTexto.titleMedium?.copyWith(
                            color: CoresAplicacao.preto,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CartaoCredenciais(
                          controladorEmail: _controladorEmail,
                          controladorSenha: _controladorSenha,
                          temaTexto: temaTexto,
                          aoEsqueceuSenha: _mostrarEmBreve,
                        ),
                        const SizedBox(height: 20),
                        BotaoPrincipal(
                          rotulo: TextosAplicacao.loginBotaoConfirmar.texto,
                          temaTexto: temaTexto,
                          aoPressionar: _aoEntrar,
                        ),
                        const SizedBox(height: 28),
                        SecaoLoginSocial(
                          temaTexto: temaTexto,
                          aoAutenticacaoSocial: _mostrarEmBreve,
                        ),
                        SizedBox(height: 32 + margemInferior),
                        RodapeCadastro(
                          temaTexto: temaTexto,
                          aoCadastrese: _mostrarEmBreve,
                        ),
                        const SizedBox(height: 16),
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
