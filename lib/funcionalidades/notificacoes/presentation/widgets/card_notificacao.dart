import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';

class CardNotificacao extends StatelessWidget {
  const CardNotificacao({
    super.key,
    required this.notificacao,
    required this.temaTexto,
    required this.aoMarcarComoLida,
    required this.aoExcluir,
  });

  final Notificacao notificacao;
  final TextTheme temaTexto;
  final VoidCallback aoMarcarComoLida;
  final VoidCallback aoExcluir;

  @override
  Widget build(BuildContext context) {
    final lida = notificacao.lida;

    final corBorda = lida
        ? CoresAplicacao.bordaCartao
        : CoresAplicacao.laranja.withValues(alpha: 0.35);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: lida ? Colors.white : CoresAplicacao.cartaoPessego,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corBorda),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: lida ? 0.04 : 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: notificacao.corFundoIcone,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                notificacao.emojiIcone,
                style: const TextStyle(fontSize: 22, height: 1),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        notificacao.emojiTitulo,
                        style: const TextStyle(fontSize: 16, height: 1.2),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          notificacao.titulo,
                          style: temaTexto.titleMedium?.copyWith(
                            color: CoresAplicacao.preto,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notificacao.descricao,
                    style: temaTexto.bodySmall?.copyWith(
                      color: CoresAplicacao.cinzaRotulo,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        notificacao.tempoRelativo,
                        style: temaTexto.bodySmall?.copyWith(
                          color: CoresAplicacao.cinza7A,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      if (!lida) ...[
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: aoMarcarComoLida,
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            '✓ Marcar como lida',
                            style: temaTexto.labelLarge?.copyWith(
                              color: CoresAplicacao.laranja,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                if (!lida)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(
                      color: CoresAplicacao.laranja,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const SizedBox(height: 10),
                const SizedBox(height: 8),
                InkWell(
                  onTap: aoExcluir,
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: CoresAplicacao.cinza7A,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
