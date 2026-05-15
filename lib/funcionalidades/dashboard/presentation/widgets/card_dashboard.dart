import 'package:flutter/material.dart';

/// Cartão branco com sombra suave sobre o fundo cinza do dashboard.

class CardDashboard extends StatelessWidget {
  const CardDashboard({
    super.key,

    required this.filho,

    this.cor = Colors.white,

    this.preenchimento = const EdgeInsets.all(16),

    this.raioBorda = 20,
  });

  final Widget filho;

  final Color cor;

  final EdgeInsetsGeometry preenchimento;

  final double raioBorda;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cor,

        borderRadius: BorderRadius.circular(raioBorda),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),

            blurRadius: 14,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Padding(padding: preenchimento, child: filho),
    );
  }
}
