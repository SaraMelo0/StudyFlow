import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'study_flow_colors.dart';

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: StudyFlowColors.orange,
      brightness: Brightness.light,
    ),
  );
  return base.copyWith(textTheme: GoogleFonts.nunitoTextTheme(base.textTheme));
}
