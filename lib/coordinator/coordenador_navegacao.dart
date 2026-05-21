import 'package:flutter/material.dart';

import 'package:study_flow/app/pagina_principal.dart';
import 'package:study_flow/coordinator/rotas_navegacao.dart';
import 'package:study_flow/funcionalidades/login/presentation/pages/pagina_login.dart';

final class CoordenadorNavegacao {
  NavigatorState _navegador(BuildContext contexto) =>
      Navigator.of(contexto, rootNavigator: true);

  MaterialPageRoute<void> _rota(RotasNavegacao rota, Widget pagina) {
    return MaterialPageRoute<void>(
      builder: (_) => pagina,
      settings: RouteSettings(name: rota.rota),
    );
  }

  Future<void> mostrarLogin(BuildContext contexto) => _navegador(
    contexto,
  ).push<void>(_rota(RotasNavegacao.login, const PaginaLogin()));

  Future<void> _substituir(
    BuildContext contexto,
    RotasNavegacao rota,
    Widget pagina,
  ) => _navegador(contexto).pushReplacement<void, void>(_rota(rota, pagina));

  Future<void> mostrarDashboard(BuildContext contexto) =>
      _substituir(contexto, RotasNavegacao.dashboard, const PaginaPrincipal());

  Future<void> sairConta(BuildContext contexto) =>
      _substituir(contexto, RotasNavegacao.login, const PaginaLogin());

  void voltar(BuildContext contexto) => _navegador(contexto).maybePop();
}

final class EscopoCoordenadorNavegacao extends InheritedWidget {
  const EscopoCoordenadorNavegacao({
    super.key,
    required this.coordenador,
    required super.child,
  });

  final CoordenadorNavegacao coordenador;

  @override
  bool updateShouldNotify(EscopoCoordenadorNavegacao antigo) =>
      coordenador != antigo.coordenador;
}

extension ContextoNavegacao on BuildContext {
  CoordenadorNavegacao get coordenador {
    final escopo =
        dependOnInheritedWidgetOfExactType<EscopoCoordenadorNavegacao>();
    assert(escopo != null, 'EscopoCoordenadorNavegacao não encontrado.');
    return escopo!.coordenador;
  }
}
