import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';

class CampoEntradaConfiguracao extends StatelessWidget {
  final String rotulo;
  final String valor;
  final ValueChanged<String> onChanged;

  const CampoEntradaConfiguracao({
    super.key,
    required this.rotulo,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rotulo,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: CoresAplicacao.preto,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: CoresAplicacao.fundo,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CoresAplicacao.bordaCartao,
              width: 1,
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: valor),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration.collapsed(hintText: ''),
            style: TextStyle(
              fontSize: 16,
              color: CoresAplicacao.preto,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}