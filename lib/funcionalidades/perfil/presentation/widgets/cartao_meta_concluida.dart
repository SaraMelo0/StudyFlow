import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';

class CartaoMetaConcluida extends StatelessWidget {
  const CartaoMetaConcluida({
    super.key,
    required this.meta,
    required this.temaTexto,
    required this.aoRemover,
  });

  final MetaEstudo meta;
  final TextTheme temaTexto;
  final VoidCallback aoRemover;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: CoresAplicacao.fundoMetaConcluida,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: CoresAplicacao.iconeVerde,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meta.titulo,
                  style: temaTexto.titleSmall?.copyWith(
                    color: CoresAplicacao.cinzaEscuro,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Text(
                  TextosAplicacao.perfilMetaConcluidaStatus.texto,
                  style: temaTexto.bodySmall?.copyWith(
                    color: CoresAplicacao.cinzaClaro,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: aoRemover,
            child: Text(
              TextosAplicacao.perfilRemover.texto,
              style: temaTexto.labelLarge?.copyWith(
                color: CoresAplicacao.preto,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
