import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CartaoConquista extends StatelessWidget {
  const CartaoConquista({
    super.key,
    required this.temaTexto,
    required this.rotulo,
    required this.corFundo,
    required this.icone,
    required this.corIcone,
  });

  final TextTheme temaTexto;
  final String rotulo;
  final Color corFundo;
  final IconData icone;
  final Color corIcone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, color: corIcone, size: 26),
          const SizedBox(height: 8),
          Text(
            rotulo,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: temaTexto.labelSmall?.copyWith(
              color: CoresAplicacao.preto,
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
