enum StudyFlow {
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
  loginLabelEmail('Email'),
  loginHintEmail('seu@email.com'),
  loginLabelSenha('Senha'),
  loginHintSenha('Digite sua senha'),
  loginEsqueceuSenha('Esqueceu sua senha?'),
  loginEntrar('Entrar'),
  loginOuContinueCom('ou continue com'),
  loginNaoTemContaPrefixo('Não tem conta? '),
  loginCadastrese('Cadastre-se'),
  funcionalidadeEmBreve('Esta função ainda será implementada.'),

  painelSaudacao('Olá, Junior 📚'),
  painelHoje('Hoje'),
  painelTempoEstudado('01h 45m'),
  painelTempoEstudadoRotulo('Tempo estudado'),
  painelSessoesConcluidas('4'),
  painelSessoesConcluidasRotulo('Sessões concluídas'),
  painelSequenciaDias('15 dias'),
  painelSequenciaRotulo('Sequência atual'),
  painelProgressoSemanal('Progresso Semanal'),
  painelProgressoHoras('08h 15m de 10h'),
  painelProgressoPercentual('83%'),
  painelIniciarSessao('Iniciar Sessão de Estudo'),
  painelTotalEstudado('38h'),
  painelTotalEstudadoRotulo('Total estudado'),
  painelMetas('3'),
  painelMetasRotulo('Metas'),
  painelMaterias('4'),
  painelMateriasRotulo('Matérias'),
  painelSessoes('10'),
  painelSessoesRotulo('Sessões'),
  painelProximaMeta('Próxima meta'),
  painelVer('Ver'),
  painelMetaTitulo('Concluir UX/UI'),
  painelMetaPrazo('Prazo: 31/03/2026');

  const StudyFlow(this.texto);
  final String texto;
}
