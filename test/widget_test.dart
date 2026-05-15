import 'package:flutter_test/flutter_test.dart';

import 'package:study_flow/app/study_flow_app.dart';

void main() {
  testWidgets('Tela de boas-vindas exibe ações principais', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudyFlowApp());

    expect(find.text('Começar Agora'), findsOneWidget);
    expect(find.text('Já tenho conta'), findsOneWidget);
    expect(find.text('Timer Pomodoro'), findsOneWidget);
  });

  testWidgets('Já tenho conta abre a tela de login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudyFlowApp());
    await tester.tap(find.text('Já tenho conta'));
    await tester.pumpAndSettle();

    expect(find.text('Bem-vindo de volta!'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('ou continue com'), findsOneWidget);
  });
}
