import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CartaoCredenciais extends StatefulWidget {
  const CartaoCredenciais({
    super.key,
    required this.controladorEmail,
    required this.controladorSenha,
    required this.temaTexto,
    this.aoEsqueceuSenha,
  });

  final TextEditingController controladorEmail;
  final TextEditingController controladorSenha;
  final TextTheme temaTexto;
  final VoidCallback? aoEsqueceuSenha;

  @override
  State<CartaoCredenciais> createState() => _CartaoCredenciaisState();
}

class _CartaoCredenciaisState extends State<CartaoCredenciais> {
  bool _ocultarSenha = true;

  static const double _raio = 14;

  InputDecoration _decoracao({
    required String dica,
    required Widget prefixo,
    Widget? sufixo,
  }) {
    final temaTexto = widget.temaTexto;
    return InputDecoration(
      hintText: dica,
      hintStyle: temaTexto.bodyMedium?.copyWith(
        color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.45),
        fontSize: 15,
      ),
      prefixIcon: prefixo,
      suffixIcon: sufixo,
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

  @override
  Widget build(BuildContext context) {
    final estiloRotulo = widget.temaTexto.labelLarge?.copyWith(
      color: CoresAplicacao.cinzaRotulo,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AutofillGroup(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(TextosAplicacao.loginRotuloEmail.texto, style: estiloRotulo),
              const SizedBox(height: 8),
              TextField(
                controller: widget.controladorEmail,
                enabled: true,
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                enableSuggestions: true,
                autofillHints: const [AutofillHints.email],
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                style: widget.temaTexto.bodyLarge?.copyWith(
                  color: CoresAplicacao.preto,
                  fontSize: 15,
                ),
                decoration: _decoracao(
                  dica: TextosAplicacao.loginDicaEmail.texto,
                  prefixo: Icon(
                    Icons.mail_outline_rounded,
                    color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.7),
                    size: 22,
                  ),
                ),
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 18),
              Text(TextosAplicacao.loginRotuloSenha.texto, style: estiloRotulo),
              const SizedBox(height: 8),
              TextField(
                controller: widget.controladorSenha,
                enabled: true,
                readOnly: false,
                obscureText: _ocultarSenha,
                obscuringCharacter: '•',
                keyboardType: _ocultarSenha
                    ? TextInputType.visiblePassword
                    : TextInputType.text,
                textInputAction: TextInputAction.done,
                enableSuggestions: false,
                autocorrect: false,
                autofillHints: const [AutofillHints.password],
                style: widget.temaTexto.bodyLarge?.copyWith(
                  color: CoresAplicacao.preto,
                  fontSize: 15,
                ),
                decoration: _decoracao(
                  dica: TextosAplicacao.loginDicaSenha.texto,
                  prefixo: Icon(
                    Icons.lock_outline_rounded,
                    color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.7),
                    size: 22,
                  ),
                  sufixo: IconButton(
                    onPressed: () {
                      setState(() => _ocultarSenha = !_ocultarSenha);
                    },
                    icon: Icon(
                      _ocultarSenha
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.75),
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),
                  ),
                ),
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.aoEsqueceuSenha,
                  style: TextButton.styleFrom(
                    foregroundColor: CoresAplicacao.cinzaRotulo,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    textStyle: widget.temaTexto.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  child: Text(TextosAplicacao.loginEsqueceuSenha.texto),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
