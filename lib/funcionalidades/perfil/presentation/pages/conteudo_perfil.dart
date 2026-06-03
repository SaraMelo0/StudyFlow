import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/injetor_aplicacao.dart';
import 'package:study_flow/core/firebase/mensagem_erro_firestore.dart';
import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/cabecalho_perfil.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/cartao_perfil_usuario.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/dialogo_formulario_meta.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/secao_conquistas.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/secao_minhas_metas.dart';

class ConteudoPerfil extends StatefulWidget {
  const ConteudoPerfil({
    super.key,
    required this.aoMostrarEmBreve,
    required this.aoSairConta,
    required this.aoConfiguracoes,
  });

  final VoidCallback aoMostrarEmBreve;
  final VoidCallback aoSairConta;
  final VoidCallback aoConfiguracoes;

  @override
  State<ConteudoPerfil> createState() => ConteudoPerfilEstado();
}

class ConteudoPerfilEstado extends State<ConteudoPerfil> {
  final _controladorScroll = ScrollController();
  final _chaveSecaoMetas = GlobalKey();
  final _repositorioMetas = injecaoAplicacao.repositorioMetas;

  void irParaMetas() {
    final contextoMetas = _chaveSecaoMetas.currentContext;
    if (contextoMetas == null) return;
    Scrollable.ensureVisible(
      contextoMetas,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.08,
    );
  }

  @override
  void dispose() {
    _controladorScroll.dispose();
    super.dispose();
  }

  void _mostrarSnackBar(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void _mostrarErro(Object erro) {
    if (!mounted) return;
    _mostrarSnackBar(mensagemErroFirestore(erro));
  }

  Future<void> _aoNovaMeta() async {
    final nova = await mostrarDialogoNovaMeta(context);
    if (nova == null || !mounted) return;

    try {
      await _repositorioMetas.criar(nova);
      _mostrarSnackBar(TextosAplicacao.perfilMetaCriada.texto);
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _aoEditar(MetaEstudo meta) async {
    final atualizada = await mostrarDialogoEditarMeta(context, meta);
    if (atualizada == null || !mounted) return;

    try {
      await _repositorioMetas.atualizar(atualizada);
      _mostrarSnackBar(TextosAplicacao.perfilMetaSalva.texto);
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _aoMetaAtivaAlterada(MetaEstudo meta) async {
    try {
      await _repositorioMetas.atualizar(meta);
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _aoMarcarConcluida(MetaEstudo meta) async {
    try {
      await _repositorioMetas.atualizar(meta.copyWith(concluida: true));
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _aoExcluir(MetaEstudo meta) async {
    try {
      await _repositorioMetas.excluir(meta.id);
    } catch (e) {
      _mostrarErro(e);
    }
  }

  Future<void> _aoRemover(MetaEstudo meta) async {
    try {
      await _repositorioMetas.excluir(meta.id);
    } catch (e) {
      _mostrarErro(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return SafeArea(
      bottom: false,
      child: StreamBuilder<List<MetaEstudo>>(
        stream: _repositorioMetas.observarMetas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  TextosAplicacao.perfilErroCarregarMetas.texto,
                  textAlign: TextAlign.center,
                  style: temaTexto.bodyMedium,
                ),
              ),
            );
          }

          final carregando =
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData;

          final todas = snapshot.data ?? const <MetaEstudo>[];
          final metasAtivas = todas.where((m) => !m.concluida).toList();
          final metasConcluidas = todas.where((m) => m.concluida).toList();

          return SingleChildScrollView(
            controller: _controladorScroll,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CabecalhoPerfil(temaTexto: temaTexto),
                const SizedBox(height: 16),
                CartaoPerfilUsuario(
                  temaTexto: temaTexto,
                  aoConfiguracoes: widget.aoConfiguracoes,
                  aoSair: widget.aoSairConta,
                ),
                const SizedBox(height: 16),
                SecaoConquistas(temaTexto: temaTexto),
                const SizedBox(height: 20),
                if (carregando)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  SecaoMinhasMetas(
                    key: _chaveSecaoMetas,
                    temaTexto: temaTexto,
                    metasAtivas: metasAtivas,
                    metasConcluidas: metasConcluidas,
                    aoNovaMeta: _aoNovaMeta,
                    aoEditar: _aoEditar,
                    aoMetaAtivaAlterada: _aoMetaAtivaAlterada,
                    aoMarcarConcluida: _aoMarcarConcluida,
                    aoExcluir: _aoExcluir,
                    aoRemover: _aoRemover,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
