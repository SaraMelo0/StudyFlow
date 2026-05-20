/// Formata [data] no padrão "Terça-feira, 24 de março".
String formatarDataPorExtenso(DateTime data) {
  const diasSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado',
    'Domingo',
  ];

  const meses = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  final diaSemana = diasSemana[data.weekday - 1];
  final mes = meses[data.month - 1];

  return '$diaSemana, ${data.day} de $mes';
}

/// Formata [data] como no histórico: "quarta-feira, 25 de março de 2026".
String formatarDataHistoricoSessoes(DateTime data) {
  return '${formatarDataPorExtenso(data).toLowerCase()} de ${data.year}';
}

/// Converte minutos totais em rótulo compacto (ex.: "38h", "1h 30m").
String formatarMinutosComoHoras(int minutosTotais) {
  if (minutosTotais <= 0) return '0h';
  final horas = minutosTotais ~/ 60;
  final minutos = minutosTotais % 60;
  if (horas == 0) return '${minutos}m';
  if (minutos == 0) return '${horas}h';
  return '${horas}h ${minutos}m';
}
