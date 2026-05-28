import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/dashboard/presentation/widgets/card_dashboard.dart';

class CartaoPerfilUsuario extends StatelessWidget {
  const CartaoPerfilUsuario({
    super.key,
    required this.temaTexto,
    required this.aoConfiguracoes,
    required this.aoSair,
  });

  final TextTheme temaTexto;
  final VoidCallback aoConfiguracoes;
  final VoidCallback aoSair;

  static const double _alturaBotaoConfiguracoes = 52;
  static const double _alturaBotaoSair = 39;

  @override
  Widget build(BuildContext context) {
    return CardDashboard(
      preenchimento: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      filho: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: CoresAplicacao.cartaoPessego,
                child: Text(
                  'J',
                  style: temaTexto.titleLarge?.copyWith(
                    color: CoresAplicacao.laranja,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextosAplicacao.perfilNome.texto,
                      style: temaTexto.titleMedium?.copyWith(
                        color: CoresAplicacao.preto,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      TextosAplicacao.perfilEmail.texto,
                      style: temaTexto.bodySmall?.copyWith(
                        color: CoresAplicacao.cinzaMedio,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BotaoPerfilContorno(
            corBorda: CoresAplicacao.cinzaPale,
            aoPressionar: aoConfiguracoes,
            altura: _alturaBotaoConfiguracoes,
            filho: Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 20,
                  color: CoresAplicacao.cinzaMedio,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextosAplicacao.perfilConfiguracoes.texto,
                        style: temaTexto.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: CoresAplicacao.cinzaEscuro,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        TextosAplicacao.perfilConfiguracoesSub.texto,
                        style: temaTexto.labelSmall?.copyWith(
                          fontSize: 10,
                          color: CoresAplicacao.cinzaMedio,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: CoresAplicacao.cinzaMedio,
                  size: 22,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          BotaoPerfilContorno(
            corBorda: CoresAplicacao.vermelho,
            aoPressionar: aoSair,
            altura: _alturaBotaoSair,
            filho: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_rounded,
                  size: 18,
                  color: CoresAplicacao.vermelho,
                ),
                const SizedBox(width: 8),
                Text(
                  TextosAplicacao.perfilSairConta.texto,
                  style: temaTexto.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: CoresAplicacao.vermelho,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Botão com borda e largura total, compartilhado entre ações do cartão de perfil.
class BotaoPerfilContorno extends StatelessWidget {
  const BotaoPerfilContorno({
    super.key,
    required this.corBorda,
    required this.aoPressionar,
    required this.altura,
    required this.filho,
  });

  final Color corBorda;
  final VoidCallback aoPressionar;
  final double altura;
  final Widget filho;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: corBorda, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: aoPressionar,
        child: SizedBox(
          width: double.infinity,
          height: altura,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: filho,
          ),
        ),
      ),
    );
  }
}
