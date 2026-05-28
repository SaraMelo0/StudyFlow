import 'package:flutter/material.dart';

import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/coordinator/injetor_aplicacao.dart'
    show injecaoAplicacao;
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/tema_aplicacao.dart';
import 'package:study_flow/funcionalidades/boas_vindas/presentation/pages/pagina_boas_vindas.dart';

class AplicacaoEstudoFluxo extends StatefulWidget {
  const AplicacaoEstudoFluxo({super.key});

  @override
  State<AplicacaoEstudoFluxo> createState() => _AplicacaoEstudoFluxoState();
}

class _AplicacaoEstudoFluxoState extends State<AplicacaoEstudoFluxo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextosAplicacao.tituloApp.texto,
      debugShowCheckedModeBanner: false,
      theme: construirTemaAplicacao(),
      home: const PaginaBoasVindas(),
      builder: (contexto, filho) {
        return EscopoCoordenadorNavegacao(
          coordenador: injecaoAplicacao.coordenador,
          child: filho ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
