import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/utils/formatador_data.dart';

class CabecalhoGrupoData extends StatelessWidget {
  const CabecalhoGrupoData({
    super.key,
    required this.data,
    required this.temaTexto,
  });

  final DateTime data;
  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: CoresAplicacao.cinza7A.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              formatarDataHistoricoSessoes(data),
              style: temaTexto.bodySmall?.copyWith(
                color: CoresAplicacao.cinza7A,
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
