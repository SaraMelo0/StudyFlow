import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';

class LoginSignUpFooter extends StatelessWidget {
  const LoginSignUpFooter({
    super.key,
    required this.textTheme,
    this.onCadastrese,
  });

  final TextTheme textTheme;
  final VoidCallback? onCadastrese;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StudyFlow.loginNaoTemContaPrefixo.texto,
          style: textTheme.bodyMedium?.copyWith(
            color: StudyFlowColors.preto,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: onCadastrese,
          child: Text(
            StudyFlow.loginCadastrese.texto,
            style: textTheme.bodyMedium?.copyWith(
              color: StudyFlowColors.orange,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
