import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/utils/formatador_data.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';

Future<MetaEstudo?> mostrarDialogoNovaMeta(BuildContext contexto) {
  return mostrarDialogoFormularioMeta(contexto);
}

Future<MetaEstudo?> mostrarDialogoEditarMeta(
  BuildContext contexto,
  MetaEstudo meta,
) {
  return mostrarDialogoFormularioMeta(contexto, metaInicial: meta);
}

Future<MetaEstudo?> mostrarDialogoFormularioMeta(
  BuildContext contexto, {
  MetaEstudo? metaInicial,
}) async {
  final resultado = await showDialog<MetaEstudo>(
    context: contexto,
    barrierDismissible: true,
    builder: (_) => _DialogoFormularioMeta(metaInicial: metaInicial),
  );
  return resultado;
}

class _DialogoFormularioMeta extends StatefulWidget {
  const _DialogoFormularioMeta({this.metaInicial});

  final MetaEstudo? metaInicial;

  bool get editando => metaInicial != null;

  @override
  State<_DialogoFormularioMeta> createState() => _DialogoFormularioMetaEstado();
}

class _DialogoFormularioMetaEstado extends State<_DialogoFormularioMeta> {
  static const double _raioCampo = 10;
  static const double _alturaBotao = 44;
  static const double _alturaBotaoAdicionar = 40;

  late final TextEditingController _controladorTitulo;
  late final TextEditingController _controladorDescricao;
  late final TextEditingController _controladorPrazo;
  final _controladorEtapa = TextEditingController();
  late final List<String> _etapas;
  late final List<EtapaMeta> _etapasOriginais;

  @override
  void initState() {
    super.initState();
    final meta = widget.metaInicial;
    _controladorTitulo = TextEditingController(text: meta?.titulo ?? '');
    _controladorDescricao = TextEditingController(text: meta?.descricao ?? '');
    _controladorPrazo = TextEditingController(
      text: meta != null ? formatarDataCurta(meta.prazo) : '',
    );
    _etapasOriginais = meta?.etapas ?? [];
    _etapas = _etapasOriginais.map((e) => e.texto).toList();
  }

  @override
  void dispose() {
    _controladorTitulo.dispose();
    _controladorDescricao.dispose();
    _controladorPrazo.dispose();
    _controladorEtapa.dispose();
    super.dispose();
  }

  InputDecoration _decoracaoCampo(TextTheme temaTexto, String dica) {
    return InputDecoration(
      hintText: dica,
      hintStyle: temaTexto.bodyMedium?.copyWith(
        color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.45),
        fontSize: 15,
      ),
      filled: true,
      fillColor: CoresAplicacao.preenchimentoCampo,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raioCampo),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raioCampo),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_raioCampo),
        borderSide: const BorderSide(color: CoresAplicacao.laranja, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  TextStyle _estiloRotulo(TextTheme temaTexto) {
    return temaTexto.labelLarge!.copyWith(
      color: CoresAplicacao.preto,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );
  }

  void _adicionarEtapa() {
    final texto = _controladorEtapa.text.trim();
    if (texto.isEmpty) return;
    setState(() {
      _etapas.add(texto);
      _controladorEtapa.clear();
    });
  }

  Future<void> _selecionarPrazo() async {
    final hoje = DateTime.now();
    var dataInicial = interpretarDataCurta(_controladorPrazo.text) ?? hoje;

    if (dataInicial.isBefore(hoje)) {
      dataInicial = hoje;
    }

    final selecionada = await showDatePicker(
      context: context,
      initialDate: dataInicial,
      firstDate: hoje,
      lastDate: DateTime(hoje.year + 10),
    );
    if (selecionada == null || !mounted) return;

    setState(() {
      _controladorPrazo.text = formatarDataCurta(selecionada);
    });
  }

  List<EtapaMeta> _montarEtapas() {
    return _etapas.asMap().entries.map((entrada) {
      final indice = entrada.key;
      final texto = entrada.value;
      if (indice < _etapasOriginais.length) {
        return _etapasOriginais[indice].copyWith(texto: texto);
      }
      return EtapaMeta(
        id: 'etapa-${DateTime.now().microsecondsSinceEpoch}-$indice',
        texto: texto,
      );
    }).toList();
  }

  void _salvar() {
    final titulo = _controladorTitulo.text.trim();
    final descricao = _controladorDescricao.text.trim();
    final prazo = interpretarDataCurta(_controladorPrazo.text);

    if (titulo.isEmpty || prazo == null) return;

    final meta =
        widget.metaInicial?.copyWith(
          titulo: titulo,
          descricao: descricao,
          prazo: prazo,
          etapas: _montarEtapas(),
        ) ??
        MetaEstudo(
          id: 'meta-${DateTime.now().millisecondsSinceEpoch}',
          titulo: titulo,
          descricao: descricao,
          prazo: prazo,
          etapas: _montarEtapas(),
        );

    Navigator.of(context).pop(meta);
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    final estiloRotulo = _estiloRotulo(temaTexto);
    final estiloCampo = temaTexto.bodyLarge?.copyWith(
      color: CoresAplicacao.preto,
      fontSize: 15,
    );
    final tituloModal = widget.editando
        ? TextosAplicacao.perfilEditarMetaTituloModal.texto
        : TextosAplicacao.perfilNovaMetaTituloModal.texto;
    final rotuloSalvar = widget.editando
        ? TextosAplicacao.perfilMetaSalvar.texto
        : TextosAplicacao.perfilNovaMetaCriar.texto;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tituloModal,
                textAlign: TextAlign.center,
                style: temaTexto.titleLarge?.copyWith(
                  color: CoresAplicacao.preto,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                TextosAplicacao.perfilMetaTituloRotulo.texto,
                style: estiloRotulo,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controladorTitulo,
                style: estiloCampo,
                textInputAction: TextInputAction.next,
                decoration: _decoracaoCampo(
                  temaTexto,
                  TextosAplicacao.perfilMetaTituloDica.texto,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                TextosAplicacao.perfilMetaDescricaoRotulo.texto,
                style: estiloRotulo,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controladorDescricao,
                style: estiloCampo,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
                decoration: _decoracaoCampo(
                  temaTexto,
                  TextosAplicacao.perfilMetaDescricaoDica.texto,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                TextosAplicacao.perfilMetaPrazoRotulo.texto,
                style: estiloRotulo,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controladorPrazo,
                style: estiloCampo,
                keyboardType: TextInputType.number,
                inputFormatters: [MascaraDataCurta()],
                decoration:
                    _decoracaoCampo(
                      temaTexto,
                      TextosAplicacao.perfilMetaPrazoDica.texto,
                    ).copyWith(
                      suffixIcon: IconButton(
                        onPressed: _selecionarPrazo,
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: CoresAplicacao.cinzaRotulo.withValues(
                            alpha: 0.7,
                          ),
                          size: 22,
                        ),
                      ),
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                TextosAplicacao.perfilMetaEtapasRotulo.texto,
                style: estiloRotulo,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controladorEtapa,
                      style: estiloCampo,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _adicionarEtapa(),
                      decoration: _decoracaoCampo(
                        temaTexto,
                        TextosAplicacao.perfilMetaEtapasDica.texto,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: CoresAplicacao.preto,
                    borderRadius: BorderRadius.circular(_raioCampo),
                    child: InkWell(
                      onTap: _adicionarEtapa,
                      borderRadius: BorderRadius.circular(_raioCampo),
                      child: const SizedBox(
                        width: _alturaBotaoAdicionar,
                        height: _alturaBotaoAdicionar,
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_etapas.isNotEmpty) ...[
                const SizedBox(height: 8),
                Column(
                  children: [
                    for (var indice = 0; indice < _etapas.length; indice++) ...[
                      if (indice > 0) const SizedBox(height: 6),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: CoresAplicacao.preenchimentoCampo,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 6, 2, 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _etapas[indice],
                                  style: temaTexto.bodySmall?.copyWith(
                                    color: CoresAplicacao.preto,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() => _etapas.removeAt(indice));
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: const SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: CoresAplicacao.preto,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: CoresAplicacao.preto,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: CoresAplicacao.bordaCartao,
                        ),
                        minimumSize: const Size(0, _alturaBotao),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_raioCampo),
                        ),
                        textStyle: temaTexto.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      child: Text(
                        TextosAplicacao.perfilSairContaCancelar.texto,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _salvar,
                      style: FilledButton.styleFrom(
                        backgroundColor: CoresAplicacao.laranja,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, _alturaBotao),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_raioCampo),
                        ),
                        textStyle: temaTexto.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      child: Text(rotuloSalvar),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
