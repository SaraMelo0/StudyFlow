import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';

class ItemToggleConfiguracao extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final bool valor;
  final ValueChanged<bool> onChanged;

  const ItemToggleConfiguracao({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: CoresAplicacao.preto,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitulo,
                  style: TextStyle(
                    fontSize: 13,
                    color: CoresAplicacao.cinza7A,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: valor,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: CoresAplicacao.laranja,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: CoresAplicacao.cinzaPale,
          ),
        ],
      ),
    );
  }
}