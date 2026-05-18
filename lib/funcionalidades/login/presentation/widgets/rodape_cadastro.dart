import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class RodapeCadastro extends StatelessWidget {
  const RodapeCadastro({super.key, required this.temaTexto, this.aoCadastrese});

  final TextTheme temaTexto;
  final VoidCallback? aoCadastrese;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TextosAplicacao.loginSemContaPrefixo.texto,
          style: temaTexto.bodyMedium?.copyWith(
            color: CoresAplicacao.marromEscuro,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: aoCadastrese,
          child: Text(
            TextosAplicacao.loginCadastrese.texto,
            style: temaTexto.bodyMedium?.copyWith(
              color: CoresAplicacao.laranja,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
