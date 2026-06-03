import 'package:study_flow/funcionalidades/sessoes/domain/sessao_estudo.dart';

/// Estado das três conquistas exibidas no perfil.
class EstadoConquistas {
  const EstadoConquistas({
    required this.primeiraSessao,
    required this.dezHoras,
    required this.seteDias,
  });

  final bool primeiraSessao;
  final bool dezHoras;
  final bool seteDias;

  static const vazio = EstadoConquistas(
    primeiraSessao: false,
    dezHoras: false,
    seteDias: false,
  );
}

/// Métricas derivadas das sessões para dashboard e conquistas.
class ResumoSessoesEstudo {
  const ResumoSessoesEstudo({
    required this.conquistas,
    required this.minutosHoje,
    required this.sessoesConcluidasHoje,
    required this.sequenciaDias,
    required this.minutosSemana,
    required this.totalMinutos,
    required this.totalSessoes,
  });

  final EstadoConquistas conquistas;
  final int minutosHoje;
  final int sessoesConcluidasHoje;
  final int sequenciaDias;
  final int minutosSemana;
  final int totalMinutos;
  final int totalSessoes;

  static const metaSemanalMinutos = 600;

  double get progressoSemanal =>
      (minutosSemana / metaSemanalMinutos).clamp(0.0, 1.0);

  int get percentualSemanal => (progressoSemanal * 100).round();
}

EstadoConquistas calcularConquistas(List<SessaoEstudo> sessoes) {
  return calcularResumoSessoes(sessoes).conquistas;
}

ResumoSessoesEstudo calcularResumoSessoes(List<SessaoEstudo> sessoes) {
  if (sessoes.isEmpty) {
    return const ResumoSessoesEstudo(
      conquistas: EstadoConquistas.vazio,
      minutosHoje: 0,
      sessoesConcluidasHoje: 0,
      sequenciaDias: 0,
      minutosSemana: 0,
      totalMinutos: 0,
      totalSessoes: 0,
    );
  }

  final agora = DateTime.now();
  final hoje = _dataSemHora(agora);
  final inicioSemana = _inicioDaSemana(agora);

  var minutosHoje = 0;
  var sessoesHoje = 0;
  var minutosSemana = 0;
  var totalMinutos = 0;
  var totalSessoes = 0;

  for (final sessao in sessoes) {
    if (!sessao.concluida) continue;

    totalSessoes++;
    totalMinutos += sessao.duracaoMin;

    final dia = _dataSemHora(sessao.inicio);
    if (dia == hoje) {
      minutosHoje += sessao.duracaoMin;
      sessoesHoje++;
    }
    if (!dia.isBefore(inicioSemana)) {
      minutosSemana += sessao.duracaoMin;
    }
  }

  final sequencia = _calcularSequenciaDias(sessoes);
  final conquistas = EstadoConquistas(
    primeiraSessao: totalSessoes >= 1,
    dezHoras: totalMinutos >= 600,
    seteDias: sequencia >= 7,
  );

  return ResumoSessoesEstudo(
    conquistas: conquistas,
    minutosHoje: minutosHoje,
    sessoesConcluidasHoje: sessoesHoje,
    sequenciaDias: sequencia,
    minutosSemana: minutosSemana,
    totalMinutos: totalMinutos,
    totalSessoes: totalSessoes,
  );
}

DateTime _dataSemHora(DateTime data) =>
    DateTime(data.year, data.month, data.day);

DateTime _inicioDaSemana(DateTime data) {
  final dia = _dataSemHora(data);
  final diasDesdeSegunda = dia.weekday - DateTime.monday;
  return dia.subtract(Duration(days: diasDesdeSegunda));
}

int _calcularSequenciaDias(List<SessaoEstudo> sessoes) {
  final diasComEstudo = <DateTime>{};
  for (final sessao in sessoes) {
    if (sessao.concluida) {
      diasComEstudo.add(_dataSemHora(sessao.inicio));
    }
  }
  if (diasComEstudo.isEmpty) return 0;

  var sequencia = 0;
  var dia = _dataSemHora(DateTime.now());
  while (diasComEstudo.contains(dia)) {
    sequencia++;
    dia = dia.subtract(const Duration(days: 1));
  }
  return sequencia;
}

String formatarMinutosComoHoras(int minutos) {
  if (minutos <= 0) return '0h';
  final horas = minutos ~/ 60;
  final resto = minutos % 60;
  if (horas == 0) return '${resto}m';
  if (resto == 0) return '${horas}h';
  return '${horas}h ${resto.toString().padLeft(2, '0')}m';
}

String rotuloSequenciaDias(int dias) {
  if (dias == 0) return '0 dias';
  if (dias == 1) return '1 dia';
  return '$dias dias';
}
