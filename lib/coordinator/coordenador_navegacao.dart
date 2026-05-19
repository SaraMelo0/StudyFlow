import 'package:flutter/material.dart';

import 'package:study_flow/coordinator/rotas_navegacao.dart';
import 'package:study_flow/funcionalidades/cadastro/presentation/pages/pagina_cadastro.dart';
import 'package:study_flow/funcionalidades/login/presentation/pages/pagina_login.dart';
import 'package:study_flow/app/pagina_principal.dart';

final class CoordenadorNavegacao {
  CoordenadorNavegacao();
  MaterialPageRoute<void> _rotaLogin() {
    return MaterialPageRoute<void>(
      builder: (_) => const PaginaLogin(),
      settings: RouteSettings(name: RotasNavegacao.login.rota),
    );
  }

  MaterialPageRoute<void> _rotaCadastro() {
    return MaterialPageRoute<void>(
      builder: (_) => const PaginaCadastro(),
      settings: RouteSettings(name: RotasNavegacao.cadastro.rota),
    );
  }

  MaterialPageRoute<void> _rotaDashboard() {
    return MaterialPageRoute<void>(
      builder: (_) => const PaginaPrincipal(),
      settings: RouteSettings(name: RotasNavegacao.dashboard.rota),
    );
  }

  Future<void> mostrarLogin(BuildContext contexto) {
    return Navigator.of(contexto, rootNavigator: true).push<void>(_rotaLogin());
  }

  Future<void> mostrarCadastro(BuildContext contexto) {
    return Navigator.of(
      contexto,
      rootNavigator: true,
    ).push<void>(_rotaCadastro());
  }

  Future<void> mostrarDashboard(BuildContext contexto) {
    return Navigator.of(
      contexto,
      rootNavigator: true,
    ).pushReplacement<void, void>(_rotaDashboard());
  }

  void voltar(BuildContext contexto) {
    Navigator.of(contexto, rootNavigator: true).maybePop();
  }
}

final class EscopoCoordenadorNavegacao extends InheritedWidget {
  const EscopoCoordenadorNavegacao({
    super.key,
    required this.coordenador,
    required super.child,
  });

  final CoordenadorNavegacao coordenador;
  static CoordenadorNavegacao de(BuildContext contexto) {
    final escopo = contexto
        .dependOnInheritedWidgetOfExactType<EscopoCoordenadorNavegacao>();
    if (escopo == null) {
      throw FlutterError(
        'EscopoCoordenadorNavegacao não encontrado acima deste contexto.',
      );
    }
    return escopo.coordenador;
  }

  @override
  bool updateShouldNotify(EscopoCoordenadorNavegacao antigo) =>
      coordenador != antigo.coordenador;
}
