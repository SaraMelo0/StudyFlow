import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';

class SecaoMetaDiaria extends StatelessWidget {
  final int metaMinutos;
  final ValueChanged<int> onMetaChanged;

  const SecaoMetaDiaria({
    super.key,
    required this.metaMinutos,
    required this.onMetaChanged,
  });

  @override
  Widget build(BuildContext context) {
    final horas = metaMinutos / 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.track_changes,
              color: CoresAplicacao.laranja,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Meta Diária',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CoresAplicacao.preto,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Horas de estudos por dia',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: CoresAplicacao.preto,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: CoresAplicacao.fundo,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: CoresAplicacao.bordaCartao,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller:
                            TextEditingController(text: metaMinutos.toString()),
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        style: TextStyle(
                          fontSize: 16,
                          color: CoresAplicacao.preto,
                        ),
                        onChanged: (valor) {
                          final numero = int.tryParse(valor);
                          if (numero != null) onMetaChanged(numero);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'minutos',
                    style: TextStyle(
                      fontSize: 14,
                      color: CoresAplicacao.cinza7A,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Equivalente a ${horas.toStringAsFixed(1)} horas por dia',
          style: TextStyle(
            fontSize: 12,
            color: CoresAplicacao.cinza7A,
          ),
        ),
      ],
    );
  }
}