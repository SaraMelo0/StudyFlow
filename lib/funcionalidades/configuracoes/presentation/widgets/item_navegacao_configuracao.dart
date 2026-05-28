import 'package:flutter/material.dart';
import '../../../../core/theme/cores_aplicacao.dart';

class ItemNavegacaoConfiguracao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;
  final Color? corIcone;

  const ItemNavegacaoConfiguracao({
    super.key,
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
    this.corIcone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent, 
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CoresAplicacao.bordaCartao,
            width: 1,
          )
        ),
        child: Row(
          children: [
            Icon(
              icone,
              color: corIcone ?? CoresAplicacao.cinzaEscuro,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
            Icon(
              Icons.chevron_right,
              color: CoresAplicacao.cinzaClaro,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}