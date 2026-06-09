import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';

int contarNotificacoesNaoLidas(List<Notificacao> notificacoes) =>
    notificacoes.where((n) => !n.lida).length;

bool temNotificacoesNaoLidas(List<Notificacao> notificacoes) =>
    contarNotificacoesNaoLidas(notificacoes) > 0;
