import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  late List<MetaEstudo> _metasAtivas;
  late List<MetaEstudo> _metasConcluidas;

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

  @override
  void initState() {
    super.initState();
    final prazo = DateTime.now().add(const Duration(days: 15));
    _metasAtivas = [
      MetaEstudo(
        id: 'meta-ativa-1',
        titulo: TextosAplicacao.perfilMetaAtivaTitulo.texto,
        descricao: TextosAplicacao.perfilMetaAtivaDescricao.texto,
        prazo: prazo,
        etapas: [
          const EtapaMeta(
            id: 'e1',
            texto: 'Conceitos básicos de UX e UI',
            concluida: true,
          ),
          const EtapaMeta(id: 'e2', texto: 'Princípios de UX', concluida: true),
          const EtapaMeta(id: 'e3', texto: 'Design de Interface (UI)'),
          const EtapaMeta(id: 'e4', texto: 'Wireframes, protótipos e mockups'),
        ],
      ),
    ];
    _metasConcluidas = [
      MetaEstudo(
        id: 'meta-concluida-1',
        titulo: TextosAplicacao.perfilMetaConcluidaTitulo.texto,
        descricao: '',
        prazo: DateTime.now().subtract(const Duration(days: 1)),
        etapas: const [],
        concluida: true,
      ),
    ];
  }

  void _mostrarSnackBar(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  Future<void> _aoNovaMeta() async {
    final nova = await mostrarDialogoNovaMeta(context);
    if (nova == null || !mounted) return;
    setState(() => _metasAtivas.add(nova));
    _mostrarSnackBar(TextosAplicacao.perfilMetaCriada.texto);
  }

  Future<void> _aoEditar(MetaEstudo meta) async {
    final atualizada = await mostrarDialogoEditarMeta(context, meta);
    if (atualizada == null || !mounted) return;
    setState(() {
      final indiceAtiva = _metasAtivas.indexWhere((m) => m.id == meta.id);
      if (indiceAtiva >= 0) {
        _metasAtivas[indiceAtiva] = atualizada;
        return;
      }
      final indiceConcluida = _metasConcluidas.indexWhere(
        (m) => m.id == meta.id,
      );
      if (indiceConcluida >= 0) {
        _metasConcluidas[indiceConcluida] = atualizada;
      }
    });
    _mostrarSnackBar(TextosAplicacao.perfilMetaSalva.texto);
  }

  void _aoMetaAtivaAlterada(MetaEstudo meta) {
    setState(() {
      final indice = _metasAtivas.indexWhere((m) => m.id == meta.id);
      if (indice >= 0) _metasAtivas[indice] = meta;
    });
  }

  void _aoMarcarConcluida(MetaEstudo meta) {
    setState(() {
      _metasAtivas.removeWhere((m) => m.id == meta.id);
      _metasConcluidas.add(meta.copyWith(concluida: true));
    });
  }

  void _aoExcluir(MetaEstudo meta) {
    setState(() => _metasAtivas.removeWhere((m) => m.id == meta.id));
  }

  void _aoRemover(MetaEstudo meta) {
    setState(() => _metasConcluidas.removeWhere((m) => m.id == meta.id));
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
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
            SecaoMinhasMetas(
              key: _chaveSecaoMetas,
              temaTexto: temaTexto,
              metasAtivas: _metasAtivas,
              metasConcluidas: _metasConcluidas,
              aoNovaMeta: _aoNovaMeta,
              aoEditar: _aoEditar,
              aoMetaAtivaAlterada: _aoMetaAtivaAlterada,
              aoMarcarConcluida: _aoMarcarConcluida,
              aoExcluir: _aoExcluir,
              aoRemover: _aoRemover,
            ),
          ],
        ),
      ),
    );
  }
}
