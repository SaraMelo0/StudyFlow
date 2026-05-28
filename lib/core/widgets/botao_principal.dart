import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class BotaoPrincipal extends StatelessWidget {
  const BotaoPrincipal({
    super.key,
    required this.rotulo,
    required this.temaTexto,
    required this.aoPressionar,
    this.iconePrefixo,
  });

  final String rotulo;
  final TextTheme temaTexto;
  final VoidCallback aoPressionar;
  final Widget? iconePrefixo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: CoresAplicacao.laranja.withValues(alpha: 0.28),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: CoresAplicacao.laranja,
            foregroundColor: Colors.white,
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
          onPressed: aoPressionar,
          child: iconePrefixo == null
              ? Text(rotulo)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconePrefixo!,
                    const SizedBox(width: 10),
                    Text(rotulo),
                  ],
                ),
        ),
      ),
    );
  }
}
