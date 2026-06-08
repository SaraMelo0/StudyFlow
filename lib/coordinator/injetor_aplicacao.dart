import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/funcionalidades/autenticacao/data/servico_autenticacao.dart';
import 'package:study_flow/funcionalidades/materias/data/repositorio_materias_firestore.dart';
import 'package:study_flow/funcionalidades/notificacoes/data/repositorio_notificacoes_firestore.dart';
import 'package:study_flow/funcionalidades/notificacoes/data/servico_notificacoes.dart';
import 'package:study_flow/funcionalidades/perfil/data/repositorio_metas_firestore.dart';

final injecaoAplicacao = InjecaoAplicacao();

final class InjecaoAplicacao {
  final CoordenadorNavegacao coordenador = CoordenadorNavegacao();
  final ServicoAutenticacao servicoAutenticacao = ServicoAutenticacao();
  final RepositorioMetasFirestore repositorioMetas =
      RepositorioMetasFirestore();
  final RepositorioMateriasFirestore repositorioMaterias =
      RepositorioMateriasFirestore();
  final RepositorioNotificacoesFirestore repositorioNotificacoes =
      RepositorioNotificacoesFirestore();
  late final ServicoNotificacoes servicoNotificacoes = ServicoNotificacoes(
    repositorioNotificacoes,
  );
}
