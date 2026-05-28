import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';
import 'item_toggle_configuracao.dart';

class SecaoNotificacoes extends StatelessWidget {
  final bool notificacoesAtivadas;
  final bool alertasSonoros;
  final bool lembretesMetas;
  final ValueChanged<bool> onNotificacoesChanged;
  final ValueChanged<bool> onAlertasSonorosChanged;
  final ValueChanged<bool> onLembretesMetasChanged;

  const SecaoNotificacoes({
    super.key,
    required this.notificacoesAtivadas,
    required this.alertasSonoros,
    required this.lembretesMetas,
    required this.onNotificacoesChanged,
    required this.onAlertasSonorosChanged,
    required this.onLembretesMetasChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.notifications_outlined,
              color: CoresAplicacao.laranja,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Notificações',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CoresAplicacao.preto,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ItemToggleConfiguracao(
                titulo: 'Ativar notificações',
                subtitulo: 'Receba lembretes de estudo',
                valor: notificacoesAtivadas,
                onChanged: onNotificacoesChanged,
              ),
              ItemToggleConfiguracao(
                titulo: 'Alertas sonoros',
                subtitulo: 'Sons ao finalizar sessões',
                valor: alertasSonoros,
                onChanged: onAlertasSonorosChanged,
              ),
              ItemToggleConfiguracao(
                titulo: 'Lembretes de metas',
                subtitulo: 'Avisos de prazos próximos',
                valor: lembretesMetas,
                onChanged: onLembretesMetasChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}