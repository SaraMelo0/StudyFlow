import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/core/utils/formatador_data.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/data/dados_sessoes_exemplo.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/domain/sessao_estudo.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/presentation/widgets/aviso_exclusao_sessao.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/presentation/widgets/cabecalho_grupo_data.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/presentation/widgets/cabecalho_historico_sessoes.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/presentation/widgets/card_item_sessao.dart';
import 'package:study_flow/funcionalidades/historico_sessoes/presentation/widgets/linha_resumo_historico.dart';

class ConteudoHistoricoSessoes extends StatefulWidget {
  const ConteudoHistoricoSessoes({super.key, required this.aoVoltar});

  final VoidCallback aoVoltar;

  static const double _espacoInferiorBarra = 88;

  @override
  State<ConteudoHistoricoSessoes> createState() =>
      _ConteudoHistoricoSessoesEstado();
}

class _ConteudoHistoricoSessoesEstado extends State<ConteudoHistoricoSessoes> {
  late List<SessaoEstudo> _sessoes;
  late int _totalSessoes;
  late int _minutosTotais;

  @override
  void initState() {
    super.initState();
    _sessoes = carregarSessoesExemplo();
    _totalSessoes =
        int.tryParse(TextosAplicacao.dashboardSessoes.texto) ??
        _sessoes.length;
    _minutosTotais = minutosTotaisHistoricoExemplo;
  }

  String get _tempoTotalRotulo {
    if (_minutosTotais >= 60 && _minutosTotais % 60 == 0) {
      return '${_minutosTotais ~/ 60}h';
    }
    return formatarMinutosComoHoras(_minutosTotais);
  }

  Map<DateTime, List<SessaoEstudo>> _agruparPorData() {
    final mapa = <DateTime, List<SessaoEstudo>>{};
    final ordenadas = [..._sessoes]
      ..sort((a, b) => b.dataHoraInicio.compareTo(a.dataHoraInicio));

    for (final sessao in ordenadas) {
      mapa.putIfAbsent(sessao.dataSomente, () => []).add(sessao);
    }
    return mapa;
  }

  Future<void> _confirmarExclusao(SessaoEstudo sessao) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: Text(TextosAplicacao.historicoConfirmarExclusaoTitulo.texto),
        content: Text(TextosAplicacao.historicoConfirmarExclusaoCorpo.texto),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contexto).pop(false),
            child: Text(TextosAplicacao.historicoCancelar.texto),
          ),
          TextButton(
            onPressed: () => Navigator.of(contexto).pop(true),
            child: Text(
              TextosAplicacao.historicoConfirmarExclusaoBotao.texto,
              style: const TextStyle(color: CoresAplicacao.iconeExcluir),
            ),
          ),
        ],
      ),
    );

    if (confirmou != true || !mounted) return;

    setState(() {
      _sessoes.removeWhere((s) => s.id == sessao.id);
      if (_totalSessoes > 0) _totalSessoes--;
      _minutosTotais = (_minutosTotais - sessao.duracaoMinutos).clamp(0, 1 << 30);
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(TextosAplicacao.historicoSessaoExcluida.texto)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final grupos = _agruparPorData();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          ConteudoHistoricoSessoes._espacoInferiorBarra,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CabecalhoHistoricoSessoes(
              temaTexto: temaTexto,
              aoVoltar: widget.aoVoltar,
            ),
            const SizedBox(height: 20),
            LinhaResumoHistorico(
              temaTexto: temaTexto,
              totalSessoes: _totalSessoes,
              tempoTotalRotulo: _tempoTotalRotulo,
            ),
            const SizedBox(height: 24),
            ...grupos.entries.map((grupo) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CabecalhoGrupoData(data: grupo.key, temaTexto: temaTexto),
                  ...grupo.value.map(
                    (sessao) => CardItemSessao(
                      sessao: sessao,
                      temaTexto: temaTexto,
                      aoExcluir: () => _confirmarExclusao(sessao),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }),
            AvisoExclusaoSessao(temaTexto: temaTexto),
          ],
        ),
      ),
    );
  }
}
