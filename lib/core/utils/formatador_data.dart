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
