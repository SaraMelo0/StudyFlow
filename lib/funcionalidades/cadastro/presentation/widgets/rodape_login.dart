import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/cadastro/presentation/widgets/texto_links_cadastro.dart';

class RodapeLogin extends StatelessWidget {
  const RodapeLogin({
    super.key,
    required this.temaTexto,
    this.aoEntrar,
    this.aoTermosUso,
    this.aoPoliticaPrivacidade,
  });

  final TextTheme temaTexto;
  final VoidCallback? aoEntrar;
  final VoidCallback? aoTermosUso;
  final VoidCallback? aoPoliticaPrivacidade;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextosAplicacao.cadastroJaTemContaPrefixo.texto,
              style: temaTexto.bodyMedium?.copyWith(
                color: CoresAplicacao.marromEscuro,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: aoEntrar,
              child: Text(
                TextosAplicacao.cadastroFazerLogin.texto,
                style: temaTexto.bodyMedium?.copyWith(
                  color: CoresAplicacao.laranja,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        TextoLinksCadastro(
          temaTexto: temaTexto,
          tamanhoFonte: 11.5,
          corTexto: CoresAplicacao.cinza7A,
          alturaLinha: 1.45,
          alinhamento: TextAlign.center,
          partes: [
            ParteTextoCadastro(TextosAplicacao.cadastroAvisoLegalPrefixo.texto),
            ParteTextoCadastro(
              TextosAplicacao.cadastroTermosUso.texto,
              aoPressionar: aoTermosUso,
            ),
            ParteTextoCadastro(TextosAplicacao.cadastroAvisoLegalMeio.texto),
            ParteTextoCadastro(
              TextosAplicacao.cadastroPoliticaPrivacidade.texto,
              aoPressionar: aoPoliticaPrivacidade,
            ),
          ],
        ),
      ],
    );
  }
}
