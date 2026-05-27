import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';
import 'item_navegacao_configuracao.dart';

class SecaoConta extends StatelessWidget {
  final String nomeUsuario;
  final String emailUsuario;
  final String? avatarUrl;
  final VoidCallback onEditarPerfil;
  final VoidCallback onAlterarSenha;

  const SecaoConta({
    super.key,
    required this.nomeUsuario,
    required this.emailUsuario,
    this.avatarUrl,
    required this.onEditarPerfil,
    required this.onAlterarSenha,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person_outline,
              color: CoresAplicacao.laranja,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Conta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CoresAplicacao.preto,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: CoresAplicacao.cinzaClaro,
                  backgroundImage:
                      avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                  child: avatarUrl == null
                      ? Text(
                          nomeUsuario.isNotEmpty
                              ? nomeUsuario[0].toUpperCase()
                              : 'U',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CoresAplicacao.preto,
                          ),
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: CoresAplicacao.laranja,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nomeUsuario,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CoresAplicacao.preto,
                  ),
                ),
                Text(
                  emailUsuario,
                  style: TextStyle(
                    fontSize: 13,
                    color: CoresAplicacao.cinza7A,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        ItemNavegacaoConfiguracao(
          icone: Icons.edit_square,
          corIcone: CoresAplicacao.marromEscuro,
          titulo: 'Editar perfil',
          subtitulo: 'Alterar nome e email',
          onTap: onEditarPerfil,
        ),

        const SizedBox(height: 8),

        ItemNavegacaoConfiguracao(
          icone: Icons.lock_outline,
          corIcone: CoresAplicacao.iconeRoxo,
          titulo: 'Alterar senha',
          subtitulo: 'Atualize sua senha de acesso',
          onTap: onAlterarSenha,
        ),
      ],
    );
  }
}