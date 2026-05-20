final class SessaoEstudo {
  SessaoEstudo({
    required this.id,
    required this.materia,
    required this.duracaoMinutos,
    required this.dataHoraInicio,
  });

  final String id;
  final String materia;
  final int duracaoMinutos;
  final DateTime dataHoraInicio;

  DateTime get dataSomente =>
      DateTime(dataHoraInicio.year, dataHoraInicio.month, dataHoraInicio.day);

  String get horaInicioFormatada {
    final hora = dataHoraInicio.hour.toString().padLeft(2, '0');
    final minuto = dataHoraInicio.minute.toString().padLeft(2, '0');
    return '$hora:$minuto';
  }

  String get duracaoEHora => '$duracaoMinutos min $horaInicioFormatada';
}
