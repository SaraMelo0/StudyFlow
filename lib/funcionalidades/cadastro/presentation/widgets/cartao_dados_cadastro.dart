import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CartaoDadosCadastro extends StatelessWidget {
  const CartaoDadosCadastro({
    super.key,
    required this.controladorNome,
    required this.controladorEmail,
    required this.controladorSenha,
    required this.controladorConfirmarSenha,
    required this.temaTexto,
  });

  final TextEditingController controladorNome;
  final TextEditingController controladorEmail;
  final TextEditingController controladorSenha;
  final TextEditingController controladorConfirmarSenha;
  final TextTheme temaTexto;

  static const double _raio = 12;

  InputDecoration _decoracao({
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
        borderRadius: BorderRadius.circular(_raio),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raio),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raio),
        borderSide: const BorderSide(color: CoresAplicacao.laranja, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      isDense: true,
    );
  }

  Widget _iconeCampo(IconData icone) {
    return Icon(
      icone,
      color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.7),
      size: 22,
    );
  }

  @override
  Widget build(BuildContext context) {
    final estiloRotulo = temaTexto.labelLarge?.copyWith(
      color: CoresAplicacao.preto,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );
    final estiloCampo = temaTexto.bodyLarge?.copyWith(
      color: CoresAplicacao.preto,
      fontSize: 15,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AutofillGroup(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(TextosAplicacao.cadastroRotuloNome.texto, style: estiloRotulo),
              const SizedBox(height: 8),
              TextField(
                controller: controladorNome,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                style: estiloCampo,
                decoration: _decoracao(
                  dica: TextosAplicacao.cadastroDicaNome.texto,
                  prefixo: _iconeCampo(Icons.person_outline_rounded),
                ),
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 18),
              Text(TextosAplicacao.cadastroRotuloEmail.texto, style: estiloRotulo),
              const SizedBox(height: 8),
              TextField(
                controller: controladorEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                enableSuggestions: true,
                autofillHints: const [AutofillHints.email],
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                style: estiloCampo,
                decoration: _decoracao(
                  dica: TextosAplicacao.cadastroDicaEmail.texto,
                  prefixo: _iconeCampo(Icons.mail_outline_rounded),
                ),
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 18),
              Text(TextosAplicacao.cadastroRotuloSenha.texto, style: estiloRotulo),
              const SizedBox(height: 8),
              TextField(
                controller: controladorSenha,
                obscureText: true,
                obscuringCharacter: '•',
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                enableSuggestions: false,
                autocorrect: false,
                autofillHints: const [AutofillHints.newPassword],
                style: estiloCampo,
                decoration: _decoracao(
                  dica: TextosAplicacao.cadastroDicaSenha.texto,
                  prefixo: _iconeCampo(Icons.lock_outline_rounded),
                ),
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 18),
              Text(
                TextosAplicacao.cadastroRotuloConfirmarSenha.texto,
                style: estiloRotulo,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controladorConfirmarSenha,
                obscureText: true,
                obscuringCharacter: '•',
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                enableSuggestions: false,
                autocorrect: false,
                autofillHints: const [AutofillHints.newPassword],
                style: estiloCampo,
                decoration: _decoracao(
                  dica: TextosAplicacao.cadastroDicaConfirmarSenha.texto,
                  prefixo: _iconeCampo(Icons.lock_outline_rounded),
                ),
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
