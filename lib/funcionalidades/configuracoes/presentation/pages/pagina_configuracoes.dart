import 'package:flutter/material.dart';
import 'package:study_flow/core/widgets/barra_navegacao.dart';
import '../../../../core/theme/cores_aplicacao.dart';
import '../widgets/cabecalho_configuracoes.dart';
import '../widgets/secao_conta.dart';
import '../widgets/secao_timer_pomodoro.dart';
import '../widgets/secao_notificacoes.dart';
import '../widgets/secao_meta_diaria.dart';
import '../widgets/secao_gerenciamento_dados.dart';


class PaginaConfiguracoes extends StatefulWidget {
  const PaginaConfiguracoes({super.key});

  @override
  State<PaginaConfiguracoes> createState() => _PaginaConfiguracoesState();
}

class _PaginaConfiguracoesState extends State<PaginaConfiguracoes> {
  
  int _duracaoFoco = 25;
  int _intervaloCurto = 5;
  int _intervaloLongo = 15;
  int _sessoesAntesIntervaloLongo = 4;

  bool _notificacoesAtivadas = true;
  bool _alertasSonoros = true;
  bool _lembretesMetas = false;

  int _metaDiariaMinutos = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoresAplicacao.fundo,
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: 4,
        aoTocar: (indice) => Navigator.pop(context),
        temNotificacoesNaoLidas: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const CabecalhoConfiguracoes(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    
                    SecaoConta(
                      nomeUsuario: 'Junior Moura',
                      emailUsuario: 'juniormoura@email.com',
                      avatarUrl: null,
                      onEditarPerfil: () {},
                      onAlterarSenha: () {},
                    ),
                    
                    const SizedBox(height: 24),
                    
                    SecaoTimerPomodoro(
                      duracaoFoco: _duracaoFoco,
                      intervaloCurto: _intervaloCurto,
                      intervaloLongo: _intervaloLongo,
                      sessoesAntesIntervaloLongo: _sessoesAntesIntervaloLongo,
                      onDuracaoFocoChanged: (valor) {
                        setState(() => _duracaoFoco = valor);
                      },
                      onIntervaloCurtoChanged: (valor) {
                        setState(() => _intervaloCurto = valor);
                      },
                      onIntervaloLongoChanged: (valor) {
                        setState(() => _intervaloLongo = valor);
                      },
                      onSessoesChanged: (valor) {
                        setState(() => _sessoesAntesIntervaloLongo = valor);
                      },
                    ),
                    
                    const SizedBox(height: 24),
          
                    SecaoNotificacoes(
                      notificacoesAtivadas: _notificacoesAtivadas,
                      alertasSonoros: _alertasSonoros,
                      lembretesMetas: _lembretesMetas,
                      onNotificacoesChanged: (valor) {
                        setState(() => _notificacoesAtivadas = valor);
                      },
                      onAlertasSonorosChanged: (valor) {
                        setState(() => _alertasSonoros = valor);
                      },
                      onLembretesMetasChanged: (valor) {
                        setState(() => _lembretesMetas = valor);
                      },
                    ),
                    
                    const SizedBox(height: 24),
        
                    SecaoMetaDiaria(
                      metaMinutos: _metaDiariaMinutos,
                      onMetaChanged: (valor) {
                        setState(() => _metaDiariaMinutos = valor);
                      },
                    ),
                    
                    const SizedBox(height: 24),
                  
                    SecaoGerenciamentoDados(
                      onGerenciarSessoes: () {},
                      onRestaurarConfiguracoes: () {
                        _mostrarDialogoRestaurar();
                      },
                      onApagarDados: () {
                        _mostrarDialogoApagar();
                      },
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoRestaurar() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.restore, color: Color(0xFF0088FF), size: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Restaurar configurações?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Isso irá restaurar todas as configurações para os valores padrão. Suas matérias, sessões e metas não serão afetadas.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: CoresAplicacao.bordaCartao),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _duracaoFoco = 25;
                          _intervaloCurto = 5;
                          _intervaloLongo = 15;
                          _sessoesAntesIntervaloLongo = 4;
                          _notificacoesAtivadas = true;
                          _alertasSonoros = true;
                          _lembretesMetas = false;
                          _metaDiariaMinutos = 120;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CoresAplicacao.laranja,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Restaurar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoApagar() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: CoresAplicacao.vermelho, size: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Restaurar configurações?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Esta ação é irreversível! Todos as suas matérias, sessões de estudo e metas serão permanentemente removidas.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: CoresAplicacao.bordaCartao),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CoresAplicacao.vermelho,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Apagar Tudo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}