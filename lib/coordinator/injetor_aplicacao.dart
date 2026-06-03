import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/funcionalidades/autenticacao/data/servico_autenticacao.dart';
import 'package:study_flow/funcionalidades/perfil/data/repositorio_metas_firestore.dart';
import 'package:study_flow/funcionalidades/sessoes/data/repositorio_sessoes_firestore.dart';

final injecaoAplicacao = InjecaoAplicacao();

final class InjecaoAplicacao {
  final CoordenadorNavegacao coordenador = CoordenadorNavegacao();
  final ServicoAutenticacao servicoAutenticacao = ServicoAutenticacao();
  final RepositorioMetasFirestore repositorioMetas =
      RepositorioMetasFirestore();
  final RepositorioSessoesFirestore repositorioSessoes =
      RepositorioSessoesFirestore();
}
