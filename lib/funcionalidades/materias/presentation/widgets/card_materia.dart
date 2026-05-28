import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_dashboard.dart';
import 'package:study_flow/funcionalidades/materias/domain/materia.dart';

class CardMateria extends StatelessWidget {
  const CardMateria({
    super.key,
    required this.materia,
    required this.temaTexto,
    required this.aoEditar,
    required this.aoExcluir,
  });

  final Materia materia;
  final TextTheme temaTexto;
  final VoidCallback aoEditar;
  final VoidCallback aoExcluir;

  static const Color _vermelhoExcluir = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    final progresso = (materia.progressoPercentual / 100).clamp(0.0, 1.0);

    return CardDashboard(
      raioBorda: 16,
      preenchimento: const EdgeInsets.fromLTRB(18, 16, 14, 16),
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  materia.nome,
                  style: temaTexto.titleMedium?.copyWith(
                    color: CoresAplicacao.preto,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    height: 1.25,
                  ),
                ),
              ),
              IconButton(
                onPressed: aoEditar,
                icon: const Icon(Icons.edit_outlined, size: 22),
                color: CoresAplicacao.preto,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: aoExcluir,
                icon: const Icon(Icons.delete_outline_rounded, size: 22),
                color: _vermelhoExcluir,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${_formatarHoras(materia.horasEstudadas)}${TextosAplicacao.materiasHorasEstudadas.texto}',
            style: temaTexto.bodySmall?.copyWith(
              color: CoresAplicacao.cinza7A,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                TextosAplicacao.materiasProgresso.texto,
                style: temaTexto.bodySmall?.copyWith(
                  color: CoresAplicacao.cinza7A,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                '${materia.progressoPercentual}%',
                style: temaTexto.bodySmall?.copyWith(
                  color: CoresAplicacao.cinza7A,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progresso,
              minHeight: 8,
              backgroundColor: CoresAplicacao.trilhoProgresso,
              color: CoresAplicacao.laranja,
            ),
          ),
        ],
      ),
    );
  }

  String _formatarHoras(double horas) {
    if (horas == horas.roundToDouble()) {
      return horas.toInt().toString();
    }
    return horas.toStringAsFixed(1);
  }
}
