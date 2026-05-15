import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/study_flow_colors.dart';

class ItemNavegacao extends StatelessWidget {
  const ItemNavegacao({
    super.key,
    required this.icone,
    required this.selecionado,
    required this.aoTocar,
    this.mostrarBadge = false,
  });

  final IconData icone;
  final bool selecionado;
  final VoidCallback aoTocar;
  final bool mostrarBadge;

  @override
  Widget build(BuildContext context) {
    final cor =
        selecionado ? StudyFlowColors.orange : StudyFlowColors.preto;

    return InkWell(
      onTap: aoTocar,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icone, color: cor, size: 26),
            if (mostrarBadge)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: StudyFlowColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
