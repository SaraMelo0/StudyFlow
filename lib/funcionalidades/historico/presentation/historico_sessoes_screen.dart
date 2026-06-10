import 'package:flutter/material.dart';

import '../model/sessao.dart';
import '../model/sessao_repository.dart';

const Color _laranja = Color(0xFFF97316);
const Color _laranjaClaro = Color(0xFFFFEDE3);
const Color _roxo = Color(0xFF7C5CFC);
const Color _roxoClaro = Color(0xFFEFEAFB);
const Color _vermelho = Color(0xFFEF4444);
const Color _textoEscuro = Color(0xFF1F2937);
const Color _textoCinza = Color(0xFF9CA3AF);
const Color _avisoFundo = Color(0xFFFFF4E5);
const Color _avisoBorda = Color(0xFFFCD9A8);
const Color _avisoTexto = Color(0xFFB45309);

const List<String> _diasSemana = [
  '', 'segunda-feira', 'terca-feira', 'quarta-feira',
  'quinta-feira', 'sexta-feira', 'sabado', 'domingo',
];

const List<String> _meses = [
  '', 'janeiro', 'fevereiro', 'marco', 'abril', 'maio', 'junho',
  'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro',
];

String _formatarDataCompleta(DateTime d) =>
    '${_diasSemana[d.weekday]}, ${d.day} de ${_meses[d.month]} de ${d.year}';

String _formatarHora(DateTime d) =>
    '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

String _calcularTempoTotal(List<Sessao> sessoes) {
  final minutos = sessoes.fold<int>(0, (soma, s) => soma + s.duracaoMinutos);
  final horas = (minutos / 60).round();
  return '${horas}h';
}

Map<DateTime, List<Sessao>> _agruparPorDia(List<Sessao> sessoes) {
  final mapa = <String, List<Sessao>>{};
  final datas = <String, DateTime>{};
  for (final s in sessoes) {
    final dia = DateTime(s.dataHora.year, s.dataHora.month, s.dataHora.day);
    final chave = dia.toIso8601String();
    mapa.putIfAbsent(chave, () => <Sessao>[]).add(s);
    datas[chave] = dia;
  }
  final chaves = mapa.keys.toList()
    ..sort((a, b) => datas[b]!.compareTo(datas[a]!));
  return {for (final k in chaves) datas[k]!: mapa[k]!};
}

class HistoricoSessoesScreen extends StatefulWidget {
  const HistoricoSessoesScreen({super.key});

  @override
  State<HistoricoSessoesScreen> createState() => _HistoricoSessoesScreenState();
}

class _HistoricoSessoesScreenState extends State<HistoricoSessoesScreen> {
  final SessaoRepository _repo = SessaoRepository();
  int _indiceNav = 2;

  Future<void> _confirmarExclusao(Sessao s) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Excluir sessao?'),
        content: Text('Deseja remover "${s.materia}"? Esta acao nao pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Excluir', style: TextStyle(color: _vermelho))),
        ],
      ),
    );
    if (confirmar == true && s.id != null) {
      try {
        await _repo.deletar(s.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sessao "${s.materia}" excluida'), behavior: SnackBarBehavior.floating),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao excluir: $e')));
        }
      }
    }
  }

  void _abrirFormularioNova() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _NovaSessaoForm(repository: _repo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Historico de Sessoes', style: TextStyle(color: _textoEscuro, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _laranja,
        onPressed: _abrirFormularioNova,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder<List<Sessao>>(
        stream: _repo.observarSessoes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Padding(padding: const EdgeInsets.all(24), child: Text('Erro ao carregar:\n${snapshot.error}', textAlign: TextAlign.center, style: const TextStyle(color: _textoCinza))));
          }
          final sessoes = snapshot.data ?? <Sessao>[];
          final grupos = _agruparPorDia(sessoes);
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: _StatCard(icone: Icons.local_fire_department, cor: _laranja, corFundo: _laranjaClaro, valor: '${sessoes.length}', rotulo: 'Sessoes')),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(icone: Icons.schedule, cor: _roxo, corFundo: _roxoClaro, valor: _calcularTempoTotal(sessoes), rotulo: 'Tempo Total')),
                ]),
                const SizedBox(height: 20),
                if (sessoes.isEmpty) _buildVazio() else ...grupos.entries.map((e) => _buildGrupo(e.key, e.value)),
                const SizedBox(height: 8),
                _buildAviso(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildVazio() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(child: Column(children: [
        Icon(Icons.inbox_outlined, size: 56, color: _textoCinza),
        SizedBox(height: 12),
        Text('Nenhuma sessao ainda', style: TextStyle(color: _textoCinza, fontSize: 15)),
        SizedBox(height: 4),
        Text('Toque no + para registrar a primeira.', style: TextStyle(color: _textoCinza, fontSize: 13)),
      ])),
    );
  }

  Widget _buildGrupo(DateTime data, List<Sessao> sessoes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(children: [
            const Icon(Icons.calendar_today_outlined, size: 15, color: _textoCinza),
            const SizedBox(width: 8),
            Text(_formatarDataCompleta(data), style: const TextStyle(fontSize: 13, color: _textoCinza, fontWeight: FontWeight.w500)),
          ]),
        ),
        ...sessoes.map(_buildSessaoCard),
      ],
    );
  }

  Widget _buildSessaoCard(Sessao s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.materia, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _textoEscuro)),
          const SizedBox(height: 4),
          Text('${s.duracaoMinutos} min - ${_formatarHora(s.dataHora)}', style: const TextStyle(fontSize: 12.5, color: _textoCinza)),
        ])),
        InkWell(
          onTap: () => _confirmarExclusao(s),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: _vermelho.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.delete_outline, color: _vermelho, size: 20),
          ),
        ),
      ]),
    );
  }

  Widget _buildAviso() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: _avisoFundo, borderRadius: BorderRadius.circular(12), border: Border.all(color: _avisoBorda)),
      child: const Text.rich(
        TextSpan(children: [
          TextSpan(text: 'Atencao: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Excluir uma sessao ira diminuir o tempo total estudado da materia e atualizar suas estatisticas diarias. Esta acao nao pode ser desfeita.'),
        ]),
        style: TextStyle(color: _avisoTexto, fontSize: 13, height: 1.4),
      ),
    );
  }

  Widget _buildBottomNav() {
    const itens = [Icons.home_rounded, Icons.add_circle_outline, Icons.access_time_rounded, Icons.notifications_none_rounded, Icons.person_rounded];
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, -2))]),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(itens.length, (i) {
              final ativo = i == _indiceNav;
              return IconButton(onPressed: () => setState(() => _indiceNav = i), icon: Icon(itens[i], size: 26, color: ativo ? _laranja : _textoCinza));
            }),
          ),
        ),
      ),
    );
  }
}

class _NovaSessaoForm extends StatefulWidget {
  final SessaoRepository repository;
  const _NovaSessaoForm({required this.repository});

  @override
  State<_NovaSessaoForm> createState() => _NovaSessaoFormState();
}

class _NovaSessaoFormState extends State<_NovaSessaoForm> {
  final TextEditingController _materiaCtrl = TextEditingController();
  final TextEditingController _duracaoCtrl = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() {
    _materiaCtrl.dispose();
    _duracaoCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    final materia = _materiaCtrl.text.trim();
    final duracao = int.tryParse(_duracaoCtrl.text.trim()) ?? 0;
    if (materia.isEmpty || duracao <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha a materia e uma duracao valida.')));
      return;
    }
    setState(() => _salvando = true);
    try {
      await widget.repository.criar(materia: materia, duracaoMinutos: duracao, dataHora: DateTime.now());
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _salvando = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nova sessao', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textoEscuro)),
          const SizedBox(height: 16),
          TextField(controller: _materiaCtrl, decoration: const InputDecoration(labelText: 'Materia', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _duracaoCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Duracao (minutos)', border: OutlineInputBorder())),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _salvando ? null : _salvar,
              style: ElevatedButton.styleFrom(backgroundColor: _laranja, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: _salvando
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Salvar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icone;
  final Color cor;
  final Color corFundo;
  final String valor;
  final String rotulo;

  const _StatCard({required this.icone, required this.cor, required this.corFundo, required this.valor, required this.rotulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(color: corFundo, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: cor, shape: BoxShape.circle), child: Icon(icone, color: Colors.white, size: 22)),
        const SizedBox(height: 10),
        Text(valor, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _textoEscuro)),
        const SizedBox(height: 2),
        Text(rotulo, style: const TextStyle(fontSize: 13, color: _textoCinza, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
