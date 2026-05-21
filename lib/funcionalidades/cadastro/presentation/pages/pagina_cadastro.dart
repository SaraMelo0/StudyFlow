import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';
import 'package:study_flow/core/widgets/cabecalho_logo.dart';
import 'package:study_flow/funcionalidades/cadastro/presentation/widgets/cartao_dados_cadastro.dart';
import 'package:study_flow/funcionalidades/cadastro/presentation/widgets/rodape_login.dart';
import 'package:study_flow/funcionalidades/cadastro/presentation/widgets/secao_aceite_termos.dart';

const double _larguraMaximaConteudo = 420;

class PaginaCadastro extends StatefulWidget {
  const PaginaCadastro({super.key});

  @override
  State<PaginaCadastro> createState() => _PaginaCadastroEstado();
}

class _PaginaCadastroEstado extends State<PaginaCadastro> {
  final _controladorNome = TextEditingController();
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();
  final _controladorConfirmarSenha = TextEditingController();
  bool _aceitouTermos = false;

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    _controladorConfirmarSenha.dispose();
    super.dispose();
  }

  void _mostrarEmBreve() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(TextosAplicacao.funcionalidadeEmBreve.texto)),
    );
  }

  void _aoCadastrar() {
    if (!_aceitouTermos) return;
    EscopoCoordenadorNavegacao.de(context).mostrarDashboard(context);
  }

  void _aoEntrar() {
    EscopoCoordenadorNavegacao.de(context).substituirPorLogin(context);
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
                          TextosAplicacao.cadastroTitulo.texto,
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
                          TextosAplicacao.cadastroSubtitulo.texto,
                          textAlign: TextAlign.center,
                          style: temaTexto.titleMedium?.copyWith(
                            color: CoresAplicacao.marromEscuro,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CartaoDadosCadastro(
                          controladorNome: _controladorNome,
                          controladorEmail: _controladorEmail,
                          controladorSenha: _controladorSenha,
                          controladorConfirmarSenha: _controladorConfirmarSenha,
                          temaTexto: temaTexto,
                        ),
                        const SizedBox(height: 20),
                        SecaoAceiteTermos(
                          temaTexto: temaTexto,
                          aceito: _aceitouTermos,
                          aoAlterarAceite: (valor) {
                            setState(() => _aceitouTermos = valor ?? false);
                          },
                          aoTermosUso: _mostrarEmBreve,
                          aoPoliticaPrivacidade: _mostrarEmBreve,
                        ),
                        const SizedBox(height: 20),
                        Opacity(
                          opacity: _aceitouTermos ? 1 : 0.55,
                          child: BotaoPrincipal(
                            rotulo: TextosAplicacao.cadastroBotaoConfirmar.texto,
                            temaTexto: temaTexto,
                            aoPressionar: _aceitouTermos ? _aoCadastrar : () {},
                          ),
                        ),
                        SizedBox(height: 28 + margemInferior),
                        RodapeLogin(
                          temaTexto: temaTexto,
                          aoEntrar: _aoEntrar,
                          aoTermosUso: _mostrarEmBreve,
                          aoPoliticaPrivacidade: _mostrarEmBreve,
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
