import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/coordinator/study_flow_coordinator.dart';
import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';
import 'package:study_flow/core/widgets/studyflow_logo_header.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/login_credentials_card.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/login_sign_up_footer.dart';
import 'package:study_flow/funcionalidades/login/presentation/widgets/login_social_section.dart';
import 'package:study_flow/core/widgets/studyflow_button.dart';

const double _kMaxContentWidth = 420;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _mostrarEmBreve() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(StudyFlow.funcionalidadeEmBreve.texto)),
    );
  }

  void _entrar() {
    StudyFlowCoordinatorScope.de(context).mostrarPainel(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: StudyFlowColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (layoutContext, constraints) {
            final bottomKeyboard = MediaQuery.viewInsetsOf(context).bottom;
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + bottomKeyboard),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _kMaxContentWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 4),
                        StudyflowLogoHeader(
                          onBack: () {
                            StudyFlowCoordinatorScope.de(
                              context,
                            ).voltar(context);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          StudyFlow.loginTitulo.texto,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineSmall?.copyWith(
                            color: StudyFlowColors.orange,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          StudyFlow.loginSubtitulo.texto,
                          textAlign: TextAlign.center,
                          style: textTheme.titleMedium?.copyWith(
                            color: StudyFlowColors.darkBrown,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 24),
                        LoginCredentialsCard(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          textTheme: textTheme,
                          onForgotPassword: _mostrarEmBreve,
                        ),
                        const SizedBox(height: 20),
                        StudyflowPrimaryCta(
                          label: StudyFlow.loginEntrar.texto,
                          textTheme: textTheme,
                          onPressed: _entrar,
                        ),
                        const SizedBox(height: 28),
                        LoginSocialSection(
                          textTheme: textTheme,
                          onSocialAuth: _mostrarEmBreve,
                        ),
                        SizedBox(height: 32 + bottomInset),
                        LoginSignUpFooter(
                          textTheme: textTheme,
                          onCadastrese: _mostrarEmBreve,
                        ),
                        const SizedBox(height: 16),
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
