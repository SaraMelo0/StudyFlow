import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/cartao_meta_ativa.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/cartao_meta_concluida.dart';

class SecaoMinhasMetas extends StatelessWidget {
  const SecaoMinhasMetas({
    super.key,
    required this.temaTexto,
    required this.metasAtivas,
    required this.metasConcluidas,
    required this.aoNovaMeta,
    required this.aoEditar,
    required this.aoMetaAtivaAlterada,
    required this.aoMarcarConcluida,
    required this.aoExcluir,
    required this.aoRemover,
  });

  final TextTheme temaTexto;
  final List<MetaEstudo> metasAtivas;
  final List<MetaEstudo> metasConcluidas;
  final VoidCallback aoNovaMeta;
  final ValueChanged<MetaEstudo> aoEditar;
  final ValueChanged<MetaEstudo> aoMetaAtivaAlterada;
  final ValueChanged<MetaEstudo> aoMarcarConcluida;
  final ValueChanged<MetaEstudo> aoExcluir;
  final ValueChanged<MetaEstudo> aoRemover;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.track_changes_rounded,
              color: CoresAplicacao.laranja,
              size: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                TextosAplicacao.perfilMinhasMetas.texto,
                style: temaTexto.titleMedium?.copyWith(
                  color: CoresAplicacao.preto,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: aoNovaMeta,
              style: TextButton.styleFrom(
                backgroundColor: CoresAplicacao.laranja,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                '+ ${TextosAplicacao.perfilNovaMeta.texto}',
                style: temaTexto.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          '${TextosAplicacao.perfilMetasAtivas.texto}(${metasAtivas.length})',
          style: temaTexto.bodySmall?.copyWith(
            color: CoresAplicacao.cinzaMedio,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        if (metasAtivas.isNotEmpty)
          ...metasAtivas.map(
            (meta) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CartaoMetaAtiva(
                meta: meta,
                temaTexto: temaTexto,
                aoEditar: () => aoEditar(meta),
                aoMetaAlterada: aoMetaAtivaAlterada,
                aoMarcarConcluida: () => aoMarcarConcluida(meta),
                aoExcluir: () => aoExcluir(meta),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text(
          '${TextosAplicacao.perfilMetasConcluidas.texto}(${metasConcluidas.length})',
          style: temaTexto.bodySmall?.copyWith(
            color: CoresAplicacao.cinzaMedio,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        if (metasConcluidas.isEmpty)
          const SizedBox.shrink()
        else
          ...metasConcluidas.map(
            (meta) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CartaoMetaConcluida(
                meta: meta,
                temaTexto: temaTexto,
                aoRemover: () => aoRemover(meta),
              ),
            ),
          ),
      ],
    );
  }
}
