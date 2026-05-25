import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';

Future<bool> mostrarDialogoConfirmarSairConta(BuildContext contexto) async {
  final confirmou = await showDialog<bool>(
    context: contexto,
    barrierDismissible: true,
    builder: (contextoDialogo) {
      final temaTexto = Theme.of(contextoDialogo).textTheme;
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          TextosAplicacao.perfilSairContaTitulo.texto,
          style: temaTexto.titleLarge?.copyWith(
            color: CoresAplicacao.preto,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        content: Text(
          TextosAplicacao.perfilSairContaMensagem.texto,
          style: temaTexto.bodyMedium?.copyWith(
            color: CoresAplicacao.cinzaEscuro,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contextoDialogo).pop(false),
            child: Text(
              TextosAplicacao.perfilSairContaCancelar.texto,
              style: temaTexto.labelLarge?.copyWith(
                color: CoresAplicacao.cinzaMedio,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(contextoDialogo).pop(true),
            child: Text(
              TextosAplicacao.perfilSairContaConfirmar.texto,
              style: temaTexto.labelLarge?.copyWith(
                color: CoresAplicacao.vermelho,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
    },
  );
  return confirmou ?? false;
}
