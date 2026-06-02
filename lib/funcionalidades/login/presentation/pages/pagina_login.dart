import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/coordinator/injetor_aplicacao.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';
import 'package:study_flow/core/widgets/cabecalho_logo.dart';
import 'package:study_flow/funcionalidades/autenticacao/data/mensagens_erro_autenticacao.dart';
import 'package:study_flow/funcionalidades/autenticacao/data/servico_autenticacao.dart';
import 'package:study_flow/funcionalidades/login/presentation/pages/pagina_recuperar_senha.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/cartao_credenciais.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/layout_scroll_autenticacao.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/rodape_cadastro.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/secao_login_social.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginEstado();
}

class _PaginaLoginEstado extends State<PaginaLogin> {
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();
  bool _carregando = false;

  void _mostrarErro(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void _aoEsqueceuSenha() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const PaginaRecuperarSenha(),
      ),
    );
  }

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

  Future<void> _autenticar(Future<dynamic> Function() acao) async {
    if (_carregando) return;

    setState(() => _carregando = true);
    try {
      await acao();
      if (!mounted) return;
      context.coordenador.mostrarDashboard(context);
    } on DominioNaoPermitidoException {
      _mostrarErro('Apenas contas @souunit.com.br são permitidas.');
    } on LoginCanceladoException {
      return;
    } on FirebaseAuthException catch (e) {
      _mostrarErro(mensagemErroAutenticacao(e));
    } on PlatformException catch (e) {
      final mensagem = mensagemErroGoogleSignIn(e);
      if (mensagem.isNotEmpty) _mostrarErro(mensagem);
    } catch (e) {
      final texto = e.toString();
      if (texto.contains('Login cancelado') ||
          texto.contains('credencial do Google')) {
        if (texto.contains('credencial do Google')) {
          _mostrarErro('Não foi possível entrar com Google. Tente novamente.');
        }
        return;
      }
      _mostrarErro('Erro inesperado. Tente novamente.');
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  Future<void> _aoEntrar() async {
    final email = _controladorEmail.text.trim();
    final senha = _controladorSenha.text;

    if (email.isEmpty || senha.isEmpty) {
      _mostrarErro('Preencha e-mail e senha.');
      return;
    }

    await _autenticar(
      () => injecaoAplicacao.servicoAutenticacao.entrarComEmail(email, senha),
    );
  }

  Future<void> _aoGoogle() async {
    await _autenticar(
      () => injecaoAplicacao.servicoAutenticacao.entrarComGoogle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final margemInferior = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutScrollAutenticacao(
              filhos: [
                CabecalhoLogo(
                  aoVoltar: _carregando
                      ? null
                      : () => context.coordenador.voltar(context),
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
                  aoEsqueceuSenha: _aoEsqueceuSenha,
                ),
                const SizedBox(height: 20),
                BotaoPrincipal(
                  rotulo: TextosAplicacao.loginBotaoConfirmar.texto,
                  temaTexto: temaTexto,
                  aoPressionar: _carregando ? () {} : _aoEntrar,
                ),
                const SizedBox(height: 28),
                SecaoLoginSocial(
                  temaTexto: temaTexto,
                  aoGoogle: _carregando ? null : _aoGoogle,
                  aoAutenticacaoSocial:
                      _carregando ? null : _mostrarEmBreve,
                ),
                SizedBox(height: 32 + margemInferior),
                RodapeCadastro(
                  temaTexto: temaTexto,
                  aoCadastrese: _carregando
                      ? () {}
                      : () => context.coordenador.mostrarCadastro(context),
                ),
                const SizedBox(height: 16),
              ],
            ),
            if (_carregando)
              const ColoredBox(
                color: Color(0x33FFFFFF),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
