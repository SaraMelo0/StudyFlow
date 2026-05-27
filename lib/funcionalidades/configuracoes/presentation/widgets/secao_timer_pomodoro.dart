import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';
import 'campo_entrada_configuracao.dart';

class SecaoTimerPomodoro extends StatelessWidget {
  final int duracaoFoco;
  final int intervaloCurto;
  final int intervaloLongo;
  final int sessoesAntesIntervaloLongo;
  final ValueChanged<int> onDuracaoFocoChanged;
  final ValueChanged<int> onIntervaloCurtoChanged;
  final ValueChanged<int> onIntervaloLongoChanged;
  final ValueChanged<int> onSessoesChanged;

  const SecaoTimerPomodoro({
    super.key,
    required this.duracaoFoco,
    required this.intervaloCurto,
    required this.intervaloLongo,
    required this.sessoesAntesIntervaloLongo,
    required this.onDuracaoFocoChanged,
    required this.onIntervaloCurtoChanged,
    required this.onIntervaloLongoChanged,
    required this.onSessoesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.timer_outlined,
              color: CoresAplicacao.laranja,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Timer Pomodoro',
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
            children: [
              CampoEntradaConfiguracao(
                rotulo: 'Duração do foco (minutos)',
                valor: duracaoFoco.toString(),
                onChanged: (valor) {
                  final numero = int.tryParse(valor);
                  if (numero != null) onDuracaoFocoChanged(numero);
                },
              ),

              const SizedBox(height: 12),

              CampoEntradaConfiguracao(
                rotulo: 'Intervalo curto (minutos)',
                valor: intervaloCurto.toString(),
                onChanged: (valor) {
                  final numero = int.tryParse(valor);
                  if (numero != null) onIntervaloCurtoChanged(numero);
                },
              ),

              const SizedBox(height: 12),

              CampoEntradaConfiguracao(
                rotulo: 'Intervalo longo (minutos)',
                valor: intervaloLongo.toString(),
                onChanged: (valor) {
                  final numero = int.tryParse(valor);
                  if (numero != null) onIntervaloLongoChanged(numero);
                },
              ),

              const SizedBox(height: 12),

              CampoEntradaConfiguracao(
                rotulo: 'Sessão antes do intervalo longo',
                valor: sessoesAntesIntervaloLongo.toString(),
                onChanged: (valor) {
                  final numero = int.tryParse(valor);
                  if (numero != null) onSessoesChanged(numero);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}