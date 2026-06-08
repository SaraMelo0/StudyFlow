import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/injetor_aplicacao.dart';
import 'package:study_flow/core/firebase/mensagem_erro_firestore.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/funcionalidades/materias/domain/materia.dart';
import 'package:study_flow/funcionalidades/materias/presentation/widgets/cabecalho_materias.dart';
import 'package:study_flow/funcionalidades/materias/presentation/widgets/card_materia.dart';
import 'package:study_flow/funcionalidades/materias/presentation/widgets/dialogo_formulario_materia.dart';

/// Conteúdo da aba de matérias, exibido dentro de [PaginaPrincipal].
class ConteudoMaterias extends StatefulWidget {
  const ConteudoMaterias({super.key});

  @override
  State<ConteudoMaterias> createState() => _ConteudoMateriasEstado();
}

class _ConteudoMateriasEstado extends State<ConteudoMaterias> {
  static const double _espacoInferiorBarra = 88;

  final _repositorioMaterias = injecaoAplicacao.repositorioMaterias;

  void _mostrarErro(Object erro) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagemErroFirestore(erro))),
    );
  }

  Future<void> _abrirNovaMateria() async {
    final resultado = await mostrarDialogoFormularioMateria(
      context,
      modo: ModoDialogoMateria.nova,
    );
    if (resultado == null || !mounted) return;

    try {
      await _repositorioMaterias.criar(
        Materia(
          id: '',
          nome: resultado.nome,
          horasEstudadas: 0,
          progressoPercentual: resultado.progressoPercentual,
        ),
      );
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _abrirEditarMateria(Materia materia) async {
    final resultado = await mostrarDialogoFormularioMateria(
      context,
      modo: ModoDialogoMateria.editar,
      materia: materia,
    );
    if (resultado == null || !mounted) return;

    try {
      await _repositorioMaterias.atualizar(
        materia.copyWith(
          nome: resultado.nome,
          progressoPercentual: resultado.progressoPercentual,
        ),
      );
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _excluirMateria(Materia materia) async {
    try {
      await _repositorioMaterias.excluir(materia.id);
    } catch (e) {
      _mostrarErro(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return SafeArea(
      child: StreamBuilder<List<Materia>>(
        stream: _repositorioMaterias.observarMaterias(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  TextosAplicacao.materiasErroCarregar.texto,
                  textAlign: TextAlign.center,
                  style: temaTexto.bodyMedium,
                ),
              ),
            );
          }

          final carregando =
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData;
          final materias = snapshot.data ?? const <Materia>[];

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, _espacoInferiorBarra),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CabecalhoMaterias(
                  temaTexto: temaTexto,
                  quantidadeMaterias: materias.length,
                  aoAdicionar: _abrirNovaMateria,
                ),
                const SizedBox(height: 20),
                if (carregando)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  for (var i = 0; i < materias.length; i++) ...[
                    if (i > 0) const SizedBox(height: 14),
                    CardMateria(
                      materia: materias[i],
                      temaTexto: temaTexto,
                      aoEditar: () => _abrirEditarMateria(materias[i]),
                      aoExcluir: () => _excluirMateria(materias[i]),
                    ),
                  ],
              ],
            ),
          );
        },
      ),
    );
  }
}
