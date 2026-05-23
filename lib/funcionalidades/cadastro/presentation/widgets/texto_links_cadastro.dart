import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/cores_aplicacao.dart';

class TextoLinksCadastro extends StatelessWidget {
  const TextoLinksCadastro({
    super.key,
    required this.temaTexto,
    required this.partes,
    this.tamanhoFonte = 13,
    this.corTexto,
    this.alturaLinha = 1.4,
    this.alinhamento = TextAlign.start,
  });

  final TextTheme temaTexto;
  final List<ParteTextoCadastro> partes;
  final double tamanhoFonte;
  final Color? corTexto;
  final double alturaLinha;
  final TextAlign alinhamento;

  @override
  Widget build(BuildContext context) {
    final corBase = corTexto ?? CoresAplicacao.cinzaRotulo;
    final estiloBase = temaTexto.bodySmall?.copyWith(
      color: corBase,
      fontSize: tamanhoFonte,
      height: alturaLinha,
      fontWeight: FontWeight.w500,
    );
    final estiloLink = estiloBase?.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: corBase,
      fontWeight: FontWeight.w600,
    );

    return Wrap(
      alignment: _wrapAlignment(alinhamento),
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final parte in partes)
          parte.aoPressionar != null
              ? GestureDetector(
                  onTap: parte.aoPressionar,
                  child: Text(parte.texto, style: estiloLink),
                )
              : Text(parte.texto, style: estiloBase),
      ],
    );
  }

  WrapAlignment _wrapAlignment(TextAlign alinhamento) {
    return switch (alinhamento) {
      TextAlign.center => WrapAlignment.center,
      TextAlign.end || TextAlign.right => WrapAlignment.end,
      _ => WrapAlignment.start,
    };
  }
}

class ParteTextoCadastro {
  const ParteTextoCadastro(this.texto, {this.aoPressionar});

  final String texto;
  final VoidCallback? aoPressionar;
}
