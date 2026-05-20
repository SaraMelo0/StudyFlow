import 'package:study_flow/funcionalidades/historico_sessoes/domain/sessao_estudo.dart';

List<SessaoEstudo> carregarSessoesExemplo() {
  return [
    SessaoEstudo(
      id: '1',
      materia: 'Governança de TI',
      duracaoMinutos: 50,
      dataHoraInicio: DateTime(2026, 3, 25, 18, 11),
    ),
    SessaoEstudo(
      id: '2',
      materia: 'Machine Learning',
      duracaoMinutos: 25,
      dataHoraInicio: DateTime(2026, 3, 24, 18, 11),
    ),
    SessaoEstudo(
      id: '3',
      materia: 'Programação Mobile',
      duracaoMinutos: 50,
      dataHoraInicio: DateTime(2026, 3, 23, 18, 11),
    ),
    SessaoEstudo(
      id: '4',
      materia: 'Machine Learning',
      duracaoMinutos: 50,
      dataHoraInicio: DateTime(2026, 3, 23, 18, 11),
    ),
    SessaoEstudo(
      id: '5',
      materia: 'Sistema de Gestão',
      duracaoMinutos: 30,
      dataHoraInicio: DateTime(2026, 3, 20, 18, 11),
    ),
    SessaoEstudo(
      id: '6',
      materia: 'Programação Mobile',
      duracaoMinutos: 25,
      dataHoraInicio: DateTime(2026, 3, 19, 18, 11),
    ),
  ];
}

const int minutosTotaisHistoricoExemplo = 38 * 60;
