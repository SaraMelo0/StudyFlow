import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/cadastro/presentation/widgets/texto_links_cadastro.dart';

class SecaoAceiteTermos extends StatelessWidget {
  const SecaoAceiteTermos({
    super.key,
    required this.temaTexto,
    required this.aceito,
    required this.aoAlterarAceite,
    this.aoTermosUso,
    this.aoPoliticaPrivacidade,
  });

  final TextTheme temaTexto;
  final bool aceito;
  final ValueChanged<bool?> aoAlterarAceite;
  final VoidCallback? aoTermosUso;
  final VoidCallback? aoPoliticaPrivacidade;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: aceito,
            onChanged: aoAlterarAceite,
            activeColor: CoresAplicacao.laranja,
            side: const BorderSide(color: CoresAplicacao.laranja, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: TextoLinksCadastro(
              temaTexto: temaTexto,
              tamanhoFonte: 13,
              corTexto: CoresAplicacao.cinzaRotulo,
              partes: [
                ParteTextoCadastro(TextosAplicacao.cadastroAceiteTermosPrefixo.texto),
                ParteTextoCadastro(
                  TextosAplicacao.cadastroTermosUso.texto,
                  aoPressionar: aoTermosUso,
                ),
                ParteTextoCadastro(TextosAplicacao.cadastroAceiteTermosMeio.texto),
                ParteTextoCadastro(
                  TextosAplicacao.cadastroPoliticaPrivacidade.texto,
                  aoPressionar: aoPoliticaPrivacidade,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
