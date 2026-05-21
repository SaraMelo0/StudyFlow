import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/utils/formatador_data.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_dashboard.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';

class CartaoMetaAtiva extends StatelessWidget {
  const CartaoMetaAtiva({
    super.key,
    required this.meta,
    required this.temaTexto,
    required this.aoEditar,
    required this.aoMetaAlterada,
    required this.aoMarcarConcluida,
    required this.aoExcluir,
  });

  final MetaEstudo meta;
  final TextTheme temaTexto;
  final VoidCallback aoEditar;
  final ValueChanged<MetaEstudo> aoMetaAlterada;
  final VoidCallback aoMarcarConcluida;
  final VoidCallback aoExcluir;

  static const double _alturaBotao = 39;

  @override
  Widget build(BuildContext context) {
    return CardDashboard(
      preenchimento: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  meta.titulo,
                  style: temaTexto.titleMedium?.copyWith(
                    color: CoresAplicacao.preto,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
              GestureDetector(
                onTap: aoEditar,
                child: Text(
                  TextosAplicacao.perfilEditar.texto,
                  style: temaTexto.labelLarge?.copyWith(
                    color: CoresAplicacao.laranjaSuave,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            meta.descricao,
            style: temaTexto.bodySmall?.copyWith(
              color: CoresAplicacao.cinzaMedio,
              fontSize: 13,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: CoresAplicacao.cinzaMedio,
              ),
              const SizedBox(width: 6),
              Text(
                rotuloDiasRestantes(meta.prazo),
                style: temaTexto.bodySmall?.copyWith(
                  color: CoresAplicacao.cinzaMedio,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextosAplicacao.perfilProgresso.texto,
                style: temaTexto.labelLarge?.copyWith(
                  color: CoresAplicacao.cinzaMedio,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                meta.rotuloProgressoEtapas,
                style: temaTexto.labelLarge?.copyWith(
                  color: CoresAplicacao.cinzaMedio,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: meta.valorProgresso,
              minHeight: 8,
              backgroundColor: CoresAplicacao.trilhoProgresso,
              color: CoresAplicacao.laranjaSuave,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(meta.etapas.length, (indice) {
            final etapa = meta.etapas[indice];
            return Padding(
              padding: EdgeInsets.only(
                bottom: indice < meta.etapas.length - 1 ? 10 : 0,
              ),
              child: InkWell(
                onTap: () {
                  final etapas = [...meta.etapas];
                  etapas[indice] = etapa.copyWith(concluida: !etapa.concluida);
                  aoMetaAlterada(meta.copyWith(etapas: etapas));
                },
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      etapa.concluida
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded,
                      color: etapa.concluida
                          ? CoresAplicacao.laranja
                          : CoresAplicacao.cinza7A,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        etapa.texto,
                        style: temaTexto.bodyMedium?.copyWith(
                          color: etapa.concluida
                              ? CoresAplicacao.cinza7A
                              : CoresAplicacao.preto,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          decoration: etapa.concluida
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 18),
          SizedBox(
            height: _alturaBotao,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FilledButton(
                    onPressed: aoMarcarConcluida,
                    style: FilledButton.styleFrom(
                      backgroundColor: CoresAplicacao.iconeVerde,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(0, _alturaBotao),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: temaTexto.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    child: Text(
                      TextosAplicacao.perfilMarcarConcluida.texto,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: aoExcluir,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CoresAplicacao.vermelho,
                      side: const BorderSide(color: CoresAplicacao.vermelho),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      minimumSize: const Size(0, _alturaBotao),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: temaTexto.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    child: Text(TextosAplicacao.perfilExcluir.texto),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
