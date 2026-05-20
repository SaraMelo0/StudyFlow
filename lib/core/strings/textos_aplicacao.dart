enum TextosAplicacao {
  tituloApp('StudyFlow'),

  textoBemVindo('Organize seus estudos com foco e disciplina'),

  progressoTitulo('Acompanhe seu progresso'),
  progressoSubtitulo('Estatísticas e gráficos em tempo real'),

  pomodoroTitulo('Timer Pomodoro'),
  pomodoroSubtitulo('Técnica comprovada de foco'),

  definaMetasTitulo('Defina metas'),
  definaMetasSubtitulo('Organize seus objetivos de estudo'),

  comecarAgora('Começar Agora'),
  jaTenhoConta('Já tenho conta'),

  textoRodape(
    'Junte-se a milhares de estudantes que já transformaram sua rotina de estudos',
  ),

  loginTitulo('Bem-vindo de volta!'),
  loginSubtitulo('Entre para continuar seus estudos'),
  loginRotuloEmail('Email'),
  loginDicaEmail('seu@email.com'),
  loginRotuloSenha('Senha'),
  loginDicaSenha('Digite sua senha'),
  loginEsqueceuSenha('Esqueceu sua senha?'),
  loginBotaoConfirmar('Entrar'),
  loginOuContinueCom('ou continue com'),
  loginSemContaPrefixo('Não tem conta? '),
  loginCadastrese('Cadastre-se'),
  funcionalidadeEmBreve('Esta função ainda será implementada.'),

  dashboardSaudacao('Olá, Junior 📚'),
  dashboardHoje('Hoje'),
  dashboardTempoEstudado('01h 45m'),
  dashboardTempoEstudadoRotulo('Tempo estudado'),
  dashboardSessoesConcluidas('4'),
  dashboardSessoesConcluidasRotulo('Sessões concluídas'),
  dashboardSequenciaDias('15 dias'),
  dashboardSequenciaRotulo('Sequência atual'),
  dashboardProgressoSemanal('Progresso Semanal'),
  dashboardProgressoHoras('08h 15m de 10h'),
  dashboardProgressoPercentual('83%'),
  dashboardIniciarSessao('Iniciar Sessão de Estudo'),
  dashboardTotalEstudado('38h'),
  dashboardTotalEstudadoRotulo('Total estudado'),
  dashboardMetas('3'),
  dashboardMetasRotulo('Metas'),
  dashboardMaterias('4'),
  dashboardMateriasRotulo('Matérias'),
  dashboardSessoes('10'),
  dashboardSessoesRotulo('Sessões'),
  dashboardProximaMeta('Próxima meta'),
  dashboardVer('Ver'),
  dashboardMetaTitulo('Concluir UX/UI'),
  dashboardMetaPrazo('Prazo: 31/03/2026'),

  historicoTitulo('Histórico de Sessões'),
  historicoSessoesRotulo('Sessões'),
  historicoTempoTotalRotulo('Tempo Total'),
  historicoAvisoTitulo('Atenção:'),
  historicoAvisoCorpo(
    'Excluir uma sessão irá diminuir o tempo total estudado da matéria e atualizar suas estatísticas diárias. Esta ação não pode ser desfeita.',
  ),
  historicoConfirmarExclusaoTitulo('Excluir sessão?'),
  historicoConfirmarExclusaoCorpo(
    'Esta sessão será removida permanentemente do seu histórico.',
  ),
  historicoConfirmarExclusaoBotao('Excluir'),
  historicoCancelar('Cancelar'),
  historicoSessaoExcluida('Sessão excluída.');

  const TextosAplicacao(this.texto);
  final String texto;
}
