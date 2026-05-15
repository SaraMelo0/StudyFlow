import 'package:flutter/material.dart';

import 'package:study_flow/coordinator/study_flow_routes.dart';
import 'package:study_flow/funcionalidades/login/presentation/pages/login.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/pages/pagina_painel.dart';

final class StudyFlowCoordinator {
  StudyFlowCoordinator();

  MaterialPageRoute<void> _rotaLogin() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginPage(),
      settings: RouteSettings(name: StudyFlowRoutes.login.rota),
    );
  }

  MaterialPageRoute<void> _rotaPainel() {
    return MaterialPageRoute<void>(
      builder: (_) => const PaginaPainel(),
      settings: RouteSettings(name: StudyFlowRoutes.painel.rota),
    );
  }

  Future<void> mostrarLogin(BuildContext contexto) {
    return Navigator.of(contexto, rootNavigator: true).push<void>(_rotaLogin());
  }

  Future<void> mostrarPainel(BuildContext contexto) {
    return Navigator.of(contexto, rootNavigator: true)
        .pushReplacement<void, void>(_rotaPainel());
  }

  void voltar(BuildContext contexto) {
    Navigator.of(contexto, rootNavigator: true).maybePop();
  }
}

final class StudyFlowCoordinatorScope extends InheritedWidget {
  const StudyFlowCoordinatorScope({
    super.key,
    required this.coordenador,
    required super.child,
  });

  final StudyFlowCoordinator coordenador;

  static StudyFlowCoordinator de(BuildContext contexto) {
    final escopo = contexto
        .dependOnInheritedWidgetOfExactType<StudyFlowCoordinatorScope>();
    if (escopo == null) {
      throw FlutterError(
        'StudyFlowCoordinatorScope não encontrado acima deste contexto.',
      );
    }
    return escopo.coordenador;
  }

  @override
  bool updateShouldNotify(StudyFlowCoordinatorScope antigo) =>
      coordenador != antigo.coordenador;
}
