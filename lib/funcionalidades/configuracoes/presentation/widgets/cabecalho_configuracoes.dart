import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';

class CabecalhoConfiguracoes extends StatelessWidget {
  const CabecalhoConfiguracoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: CoresAplicacao.preto,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Configurações',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CoresAplicacao.preto,
            ),
          ),
        ],
      ),
    );
  }
}