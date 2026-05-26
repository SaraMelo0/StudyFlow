import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

class CabecalhoMaterias extends StatelessWidget {
  const CabecalhoMaterias({
    super.key,
    required this.temaTexto,
    required this.quantidadeMaterias,
    required this.aoAdicionar,
  });

  final TextTheme temaTexto;
  final int quantidadeMaterias;
  final VoidCallback aoAdicionar;

  String _subtitulo() {
    if (quantidadeMaterias == 1) {
      return TextosAplicacao.materiasSubtituloSingular.texto;
    }
    return '$quantidadeMaterias ${TextosAplicacao.materiasSubtituloPlural.texto}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextosAplicacao.materiasTitulo.texto,
                style: temaTexto.headlineSmall?.copyWith(
                  color: CoresAplicacao.preto,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _subtitulo(),
                style: temaTexto.bodyMedium?.copyWith(
                  color: CoresAplicacao.cinza7A,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Material(
          color: CoresAplicacao.laranja,
          borderRadius: BorderRadius.circular(14),
          elevation: 0,
          child: InkWell(
            onTap: aoAdicionar,
            borderRadius: BorderRadius.circular(14),
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.add_rounded, color: Colors.white, size: 28),
            ),
          ),
        ),
      ],
    );
  }
}
