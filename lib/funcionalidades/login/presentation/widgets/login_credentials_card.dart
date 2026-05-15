import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';

class LoginCredentialsCard extends StatefulWidget {
  const LoginCredentialsCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.textTheme,
    this.onForgotPassword,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextTheme textTheme;
  final VoidCallback? onForgotPassword;

  @override
  State<LoginCredentialsCard> createState() => _LoginCredentialsCardState();
}

class _LoginCredentialsCardState extends State<LoginCredentialsCard> {
  bool _obscurePassword = true;

  static const double _radius = 14;

  InputDecoration _decoration({
    required String hint,
    required Widget prefix,
    Widget? suffix,
  }) {
    final textTheme = widget.textTheme;
    return InputDecoration(
      hintText: hint,
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: StudyFlowColors.labelGray.withValues(alpha: 0.45),
        fontSize: 15,
      ),
      prefixIcon: prefix,
      suffixIcon: suffix,
      filled: true,
      fillColor: StudyFlowColors.inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: StudyFlowColors.orange, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = widget.textTheme.labelLarge?.copyWith(
      color: StudyFlowColors.labelGray,
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
              Text(StudyFlow.loginLabelEmail.texto, style: labelStyle),
              const SizedBox(height: 8),
              TextField(
                controller: widget.emailController,
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
                style: widget.textTheme.bodyLarge?.copyWith(
                  color: StudyFlowColors.preto,
                  fontSize: 15,
                ),
                decoration: _decoration(
                  hint: StudyFlow.loginHintEmail.texto,
                  prefix: Icon(
                    Icons.mail_outline_rounded,
                    color: StudyFlowColors.labelGray.withValues(alpha: 0.7),
                    size: 22,
                  ),
                ),
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 18),
              Text(StudyFlow.loginLabelSenha.texto, style: labelStyle),
              const SizedBox(height: 8),
              TextField(
                controller: widget.passwordController,
                enabled: true,
                readOnly: false,
                obscureText: _obscurePassword,
                obscuringCharacter: '•',
                keyboardType: _obscurePassword
                    ? TextInputType.visiblePassword
                    : TextInputType.text,
                textInputAction: TextInputAction.done,
                enableSuggestions: false,
                autocorrect: false,
                autofillHints: const [AutofillHints.password],
                style: widget.textTheme.bodyLarge?.copyWith(
                  color: StudyFlowColors.preto,
                  fontSize: 15,
                ),
                decoration: _decoration(
                  hint: StudyFlow.loginHintSenha.texto,
                  prefix: Icon(
                    Icons.lock_outline_rounded,
                    color: StudyFlowColors.labelGray.withValues(alpha: 0.7),
                    size: 22,
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: StudyFlowColors.labelGray.withValues(alpha: 0.75),
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
                  onPressed: widget.onForgotPassword,
                  style: TextButton.styleFrom(
                    foregroundColor: StudyFlowColors.labelGray,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    textStyle: widget.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  child: Text(StudyFlow.loginEsqueceuSenha.texto),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
