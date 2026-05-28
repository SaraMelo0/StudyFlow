import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cores_aplicacao.dart';

ThemeData construirTemaAplicacao() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CoresAplicacao.laranja,
      brightness: Brightness.light,
    ),
  );
  return base.copyWith(textTheme: GoogleFonts.nunitoTextTheme(base.textTheme));
}
