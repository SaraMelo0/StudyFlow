import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_dashboard.dart';
import 'package:study_flow/funcionalidades/perfil/presentation/widgets/cartao_conquista.dart';

class SecaoConquistas extends StatelessWidget {
  const SecaoConquistas({super.key, required this.temaTexto});

  final TextTheme temaTexto;

  @override
  Widget build(BuildContext context) {
    return CardDashboard(
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                color: CoresAplicacao.iconeAmarelo,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                TextosAplicacao.perfilConquistas.texto,
                style: temaTexto.titleMedium?.copyWith(
                  color: CoresAplicacao.preto,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CartaoConquista(
                  temaTexto: temaTexto,
                  rotulo: TextosAplicacao.perfilConquistaPrimeiraSessao.texto,
                  corFundo: CoresAplicacao.cartaoPessego,
                  icone: Icons.emoji_events_outlined,
                  corIcone: CoresAplicacao.iconeAmarelo,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CartaoConquista(
                  temaTexto: temaTexto,
                  rotulo: TextosAplicacao.perfilConquistaDezHoras.texto,
                  corFundo: CoresAplicacao.conquistaRoxoClaro,
                  icone: Icons.menu_book_rounded,
                  corIcone: CoresAplicacao.iconeRoxo,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CartaoConquista(
                  temaTexto: temaTexto,
                  rotulo: TextosAplicacao.perfilConquistaSeteDias.texto,
                  corFundo: CoresAplicacao.conquistaAzulClaro,
                  icone: Icons.local_fire_department_outlined,
                  corIcone: CoresAplicacao.laranja,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
