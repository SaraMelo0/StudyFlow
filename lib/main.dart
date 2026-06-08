import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:study_flow/app/aplicacao_estudo_fluxo.dart';
import 'package:study_flow/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AplicacaoEstudoFluxo());
}
