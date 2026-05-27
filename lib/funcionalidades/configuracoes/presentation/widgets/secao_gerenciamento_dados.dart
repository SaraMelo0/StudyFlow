import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';
import 'item_navegacao_configuracao.dart';

class SecaoGerenciamentoDados extends StatelessWidget {
  final VoidCallback onGerenciarSessoes;
  final VoidCallback onRestaurarConfiguracoes;
  final VoidCallback onApagarDados;

  const SecaoGerenciamentoDados({
    super.key,
    required this.onGerenciarSessoes,
    required this.onRestaurarConfiguracoes,
    required this.onApagarDados,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.storage,
              color: CoresAplicacao.laranja,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Gerenciamento de Dados',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CoresAplicacao.preto,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        ItemNavegacaoConfiguracao(
          icone: Icons.access_time_outlined,
          corIcone: CoresAplicacao.iconeRoxo,
          titulo: 'Gerenciar sessões',
          subtitulo: 'Ver e excluir sessões de estudo',
          onTap: onGerenciarSessoes,
        ),

        const SizedBox(height: 8),

        ItemNavegacaoConfiguracao(
          icone: Icons.refresh,
          corIcone: CoresAplicacao.iconeAzul,
          titulo: 'Restaurar configurações',
          subtitulo: 'Volta para o padrão',
          onTap: onRestaurarConfiguracoes,
        ),

        const SizedBox(height: 8),

        ItemNavegacaoConfiguracao(
          icone: Icons.error_outline,
          corIcone: CoresAplicacao.vermelho,
          titulo: 'Apagar todos os dados',
          subtitulo: 'Remove matérias, sessões e metas',
          onTap: onApagarDados,
        ),
      ],
    );
  }
}