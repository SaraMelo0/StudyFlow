import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/study_flow_coordinator.dart';
import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/core/widgets/studyflow_logo_header.dart';
import 'package:study_flow/funcionalidades/welcome/presentation/widgets/studyflow_feature_card.dart';
import 'package:study_flow/core/widgets/studyflow_button.dart';

const double _kMaxContentWidth = 420;

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final welcomeContext = context;
    final textTheme = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: StudyFlowColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (layoutContext, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _kMaxContentWidth,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        const StudyflowLogoHeader(),
                        const SizedBox(height: 20),
                        Text(
                          StudyFlow.textoBemVindo.texto,
                          textAlign: TextAlign.center,
                          style: textTheme.titleMedium?.copyWith(
                            color: StudyFlowColors.darkBrown,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 32),
                        StudyflowFeatureCard(
                          icon: Icons.trending_up_rounded,
                          title: StudyFlow.progressoTitulo.texto,
                          subtitle: StudyFlow.progressoSubtitulo.texto,
                          textTheme: textTheme,
                        ),
                        const SizedBox(height: 12),
                        StudyflowFeatureCard(
                          icon: Icons.bolt_rounded,
                          title: StudyFlow.pomodoroTitulo.texto,
                          subtitle: StudyFlow.pomodoroSubtitulo.texto,
                          textTheme: textTheme,
                        ),
                        const SizedBox(height: 12),
                        StudyflowFeatureCard(
                          icon: Icons.track_changes_rounded,
                          title: StudyFlow.definaMetasTitulo.texto,
                          subtitle: StudyFlow.definaMetasSubtitulo.texto,
                          textTheme: textTheme,
                        ),
                        const SizedBox(height: 36),
                        StudyflowPrimaryCta(
                          label: StudyFlow.comecarAgora.texto,
                          textTheme: textTheme,
                          // TODO: navegar para a tela de cadastro.
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 52,
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: StudyFlowColors.orange,
                              side: const BorderSide(
                                color: StudyFlowColors.orange,
                                width: 1.5,
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              StudyFlowCoordinatorScope.de(
                                welcomeContext,
                              ).mostrarLogin(welcomeContext);
                            },
                            child: Text(StudyFlow.jaTenhoConta.texto),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          StudyFlow.textoRodape.texto,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(
                            color: StudyFlowColors.mutedBrown,
                            fontWeight: FontWeight.w500,
                            height: 1.45,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
