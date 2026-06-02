import 'package:study_flow/coordinator/coordenador_navegacao.dart';
import 'package:study_flow/funcionalidades/autenticacao/data/servico_autenticacao.dart';

final injecaoAplicacao = InjecaoAplicacao();

final class InjecaoAplicacao {
  final CoordenadorNavegacao coordenador = CoordenadorNavegacao();
  final ServicoAutenticacao servicoAutenticacao = ServicoAutenticacao();
}
