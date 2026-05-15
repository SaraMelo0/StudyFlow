import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class SecaoLoginSocial extends StatelessWidget {
  const SecaoLoginSocial({
    super.key,
    required this.temaTexto,
    required this.aoAutenticacaoSocial,
  });

  final TextTheme temaTexto;
  final VoidCallback aoAutenticacaoSocial;

  static const double _tamanhoBotao = 52;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: CoresAplicacao.divisorSuave, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                TextosAplicacao.loginOuContinueCom.texto,
                style: temaTexto.bodySmall?.copyWith(
                  color: CoresAplicacao.divisorSuave,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: CoresAplicacao.divisorSuave, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _BotaoSocial(
              aoPressionar: aoAutenticacaoSocial,
              filho: const Text(
                'G',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 20),
            _BotaoSocial(
              aoPressionar: aoAutenticacaoSocial,
              filho: Icon(Icons.apple, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            _BotaoSocial(
              aoPressionar: aoAutenticacaoSocial,
              filho: const Text(
                'f',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BotaoSocial extends StatelessWidget {
  const _BotaoSocial({required this.filho, required this.aoPressionar});

  final Widget filho;
  final VoidCallback aoPressionar;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CoresAplicacao.laranja,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      child: InkWell(
        onTap: aoPressionar,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: SecaoLoginSocial._tamanhoBotao,
          height: SecaoLoginSocial._tamanhoBotao,
          child: Center(child: filho),
        ),
      ),
    );
  }
}
