import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/injetor_aplicacao.dart';
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

  final _servicoNotificacoes = injecaoAplicacao.servicoNotificacoes;

  final List<Materia> _materias = [
    const Materia(
      id: '1',
      nome: 'Governança de TI',
      horasEstudadas: 12.5,
      progressoPercentual: 65,
    ),
    const Materia(
      id: '2',
      nome: 'Sistema de Gestão',
      horasEstudadas: 10.2,
      progressoPercentual: 55,
    ),
    const Materia(
      id: '3',
      nome: 'Machine Learning',
      horasEstudadas: 8.3,
      progressoPercentual: 45,
    ),
    const Materia(
      id: '4',
      nome: 'Programação Mobile',
      horasEstudadas: 6.7,
      progressoPercentual: 38,
    ),
  ];

  int _proximoId = 5;

  Future<void> _abrirNovaMateria() async {
    final resultado = await mostrarDialogoFormularioMateria(
      context,
      modo: ModoDialogoMateria.nova,
    );
    if (resultado == null || !mounted) return;

    final novaMateria = Materia(
      id: '${_proximoId++}',
      nome: resultado.nome,
      horasEstudadas: 0,
      progressoPercentual: resultado.progressoPercentual,
    );

    setState(() {
      _materias.add(novaMateria);
    });

    try {
      await _servicoNotificacoes.notificarMateriaCriada(novaMateria.nome);
    } catch (_) {
      // Notificação é efeito colateral; falha não interrompe o fluxo principal.
    }
  }

  Future<void> _abrirEditarMateria(Materia materia) async {
    final resultado = await mostrarDialogoFormularioMateria(
      context,
      modo: ModoDialogoMateria.editar,
      materia: materia,
    );
    if (resultado == null || !mounted) return;

    final indice = _materias.indexWhere((m) => m.id == materia.id);
    if (indice == -1) return;

    final atualizada = materia.copyWith(
      nome: resultado.nome,
      progressoPercentual: resultado.progressoPercentual,
    );

    setState(() {
      _materias[indice] = atualizada;
    });

    try {
      await _servicoNotificacoes.notificarMateriaAtualizada(atualizada.nome);
    } catch (_) {
      // Notificação é efeito colateral; falha não interrompe o fluxo principal.
    }
  }

  Future<void> _excluirMateria(Materia materia) async {
    final nome = materia.nome;

    setState(() {
      _materias.removeWhere((m) => m.id == materia.id);
    });

    try {
      await _servicoNotificacoes.notificarMateriaRemovida(nome);
    } catch (_) {
      // Notificação é efeito colateral; falha não interrompe o fluxo principal.
    }
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, _espacoInferiorBarra),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CabecalhoMaterias(
              temaTexto: temaTexto,
              quantidadeMaterias: _materias.length,
              aoAdicionar: _abrirNovaMateria,
            ),
            const SizedBox(height: 20),
            for (var i = 0; i < _materias.length; i++) ...[
              if (i > 0) const SizedBox(height: 14),
              CardMateria(
                materia: _materias[i],
                temaTexto: temaTexto,
                aoEditar: () => _abrirEditarMateria(_materias[i]),
                aoExcluir: () => _excluirMateria(_materias[i]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
