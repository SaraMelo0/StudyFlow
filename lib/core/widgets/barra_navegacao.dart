import 'package:flutter/material.dart';

import 'package:study_flow/core/widgets/item_navegacao.dart';

class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({
    super.key,
    required this.indiceAtual,
    required this.aoTocar,
  });

  final int indiceAtual;
  final ValueChanged<int> aoTocar;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withValues(alpha: 0.45),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ItemNavegacao(
                icone: Icons.home_rounded,
                selecionado: indiceAtual == 0,
                aoTocar: () => aoTocar(0),
              ),
              ItemNavegacao(
                icone: Icons.menu_book_outlined,
                selecionado: indiceAtual == 1,
                aoTocar: () => aoTocar(1),
              ),
              ItemNavegacao(
                icone: Icons.schedule_outlined,
                selecionado: indiceAtual == 2,
                aoTocar: () => aoTocar(2),
              ),
              ItemNavegacao(
                icone: Icons.notifications_outlined,
                selecionado: indiceAtual == 3,
                mostrarBadge: true,
                aoTocar: () => aoTocar(3),
              ),
              ItemNavegacao(
                icone: Icons.person_outline_rounded,
                selecionado: indiceAtual == 4,
                aoTocar: () => aoTocar(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
