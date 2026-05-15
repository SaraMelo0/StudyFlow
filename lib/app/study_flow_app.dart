import 'package:flutter/material.dart';

import 'package:study_flow/coordinator/study_flow_coordinator.dart';
import 'package:study_flow/coordinator/study_flow_injector.dart';
import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/app_theme.dart';
import 'package:study_flow/funcionalidades/welcome/presentation/pages/welcome_page.dart';

class StudyFlowApp extends StatefulWidget {
  const StudyFlowApp({super.key});

  @override
  State<StudyFlowApp> createState() => _StudyFlowAppState();
}

class _StudyFlowAppState extends State<StudyFlowApp> {
  late final CoordinatorInjector _injector = CoordinatorInjector();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StudyFlow.tituloApp.texto,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const WelcomePage(),
      builder: (context, child) {
        return StudyFlowCoordinatorScope(
          coordenador: _injector.coordenador,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
