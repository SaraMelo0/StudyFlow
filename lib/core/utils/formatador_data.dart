import 'package:flutter/services.dart';

DateTime? interpretarDataCurta(String texto) {
  final partes = texto.split('/');
  if (partes.length != 3) return null;

  final dia = int.tryParse(partes[0]);
  final mes = int.tryParse(partes[1]);
  final ano = int.tryParse(partes[2]);
  if (dia == null || mes == null || ano == null) return null;

  try {
    return DateTime(ano, mes, dia);
  } on Object {
    return null;
  }
}

String rotuloDiasRestantes(DateTime prazo) {
  final dias = prazo.difference(DateTime.now()).inDays;
  if (dias < 0) return 'Prazo vencido';
  if (dias == 0) return 'Vence hoje';
  if (dias == 1) return '1 dia restante';
  return '$dias dias restantes';
}

String formatarDataCurta(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  return '$dia/$mes/${data.year}';
}

class MascaraDataCurta extends TextInputFormatter {
  static const int _maxDigitos = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue valorAntigo,
    TextEditingValue valorNovo,
  ) {
    final digitos = valorNovo.text.replaceAll(RegExp(r'\D'), '');
    if (digitos.length > _maxDigitos) {
      return valorAntigo;
    }

    final buffer = StringBuffer();
    for (var indice = 0; indice < digitos.length; indice++) {
      if (indice == 2 || indice == 4) {
        buffer.write('/');
      }
      buffer.write(digitos[indice]);
    }

    final texto = buffer.toString();
    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}

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
