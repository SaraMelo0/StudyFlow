import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/domain/sessao_estudo.dart';

class CardItemSessao extends StatelessWidget {
  const CardItemSessao({
    super.key,
    required this.sessao,
    required this.temaTexto,
    required this.aoExcluir,
  });

  final SessaoEstudo sessao;
  final TextTheme temaTexto;
  final VoidCallback aoExcluir;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: CoresAplicacao.bordaCartaoSessao),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sessao.materia,
                      style: temaTexto.titleSmall?.copyWith(
                        color: CoresAplicacao.preto,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sessao.duracaoEHora,
                      style: temaTexto.bodySmall?.copyWith(
                        color: CoresAplicacao.cinza7A,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: aoExcluir,
                icon: const Icon(Icons.delete_outline_rounded),
                color: CoresAplicacao.iconeExcluir,
                iconSize: 22,
                tooltip: 'Excluir sessão',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
