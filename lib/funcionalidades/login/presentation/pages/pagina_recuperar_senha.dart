import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/widgets/botao_principal.dart';
import 'package:study_flow/core/widgets/cabecalho_logo.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/layout_scroll_autenticacao.dart';

class PaginaRecuperarSenha extends StatefulWidget {
  const PaginaRecuperarSenha({super.key});

  @override
  State<PaginaRecuperarSenha> createState() => _PaginaRecuperarSenhaEstado();
}

class _PaginaRecuperarSenhaEstado extends State<PaginaRecuperarSenha> {
  static const _raioCartao = 20.0;
  static const _raioInput = 14.0;

  final _controladorEmail = TextEditingController();

  @override
  void dispose() {
    _controladorEmail.dispose();
    super.dispose();
  }

  void _aoContinuar() {
    final email = _controladorEmail.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, informe seu email.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link de recuperação enviado para seu email'),
      ),
    );
  }

  InputDecoration _decoracaoCampo({
    required TextTheme temaTexto,
    required String dica,
    required Widget prefixo,
  }) {
    return InputDecoration(
      hintText: dica,
      hintStyle: temaTexto.bodyMedium?.copyWith(
        color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.45),
        fontSize: 15,
      ),
      prefixIcon: prefixo,
      filled: true,
      fillColor: CoresAplicacao.preenchimentoCampo,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raioInput),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raioInput),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raioInput),
        borderSide: const BorderSide(color: CoresAplicacao.laranja, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    final estiloRotulo = temaTexto.labelLarge?.copyWith(
      color: CoresAplicacao.cinzaRotulo,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      body: SafeArea(
        child: LayoutScrollAutenticacao(
          filhos: [
            CabecalhoLogo(
              aoVoltar: () => Navigator.pop(context),
              iconeVoltar: Icons.arrow_back_ios_new_rounded,
            ),
            const SizedBox(height: 16),
            Text(
              'Recuperar Senha',
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
              'Digite seu email para redefinir sua senha',
              textAlign: TextAlign.center,
              style: temaTexto.titleMedium?.copyWith(
                color: CoresAplicacao.preto,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 24),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_raioCartao),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      TextosAplicacao.loginRotuloEmail.texto,
                      style: estiloRotulo,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _controladorEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      autocorrect: false,
                      enableSuggestions: true,
                      autofillHints: const [AutofillHints.email],
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      style: temaTexto.bodyLarge?.copyWith(
                        color: CoresAplicacao.preto,
                        fontSize: 15,
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                      decoration: _decoracaoCampo(
                        temaTexto: temaTexto,
                        dica: TextosAplicacao.loginDicaEmail.texto,
                        prefixo: Icon(
                          Icons.mail_outline,
                          color:
                              CoresAplicacao.cinzaRotulo.withValues(alpha: 0.7),
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BotaoPrincipal(
                      rotulo: 'Continuar',
                      temaTexto: temaTexto,
                      aoPressionar: _aoContinuar,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: CoresAplicacao.laranja.withValues(alpha: 0.25),
                ),
                color: CoresAplicacao.cartaoPessego.withValues(alpha: 0.35),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Segurança em primeiro lugar',
                    style: temaTexto.titleMedium?.copyWith(
                      color: CoresAplicacao.preto,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Suas informações estão protegidas. Nunca compartilhe sua senha com ninguém.',
                    style: temaTexto.bodyMedium?.copyWith(
                      color: CoresAplicacao.cinzaMedio,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

