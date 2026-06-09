import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfiguracoesControle {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> salvarConfiguracoes({
    required int foco,
    required int intervaloCurto,
    required int intervaloLongo,
    required int sessoes,
    required bool ativarNotificacoes,
    required bool alertasSonoros,
    required bool lembretesMetas,
    required int metaDiaria,
  }) async {
    String? uidUsuario = _auth.currentUser?.uid;
    String? emailUsuario = _auth.currentUser?.email;

    if (uidUsuario == null) {
      print("Erro Técnico: Nenhum usuário autenticado no Firebase.");
      return;
    }

    try {
      await _firestore.collection('metas').doc(uidUsuario).set({
        'usuario_logado': emailUsuario,
        'atualizado_em': FieldValue.serverTimestamp(),
        'timer_pomodoro': {
          'foco_minutos': foco,
          'intervalo_curto': intervaloCurto,
          'intervalo_longo': intervaloLongo,
          'sessoes_antes_intervalo_longo': sessoes,
        },
        'notificacoes': {
          'ativar_notificacoes': ativarNotificacoes,
          'alertas_sonoros': alertasSonoros,
          'lembretes_de_metas': lembretesMetas,
        },
        'meta_diaria': {
          'horas_de_estudos_minutos': metaDiaria,
        }
      }, SetOptions(merge: true));
      
      print("Sucesso: Dados sincronizados com o Firestore!");
    } catch (e) {
      print("Erro ao salvar dados no Firestore: $e");
    }
  }

  Future<void> apagarTodosOsDados() async {
    String? uidUsuario = _auth.currentUser?.uid;
    if (uidUsuario == null) return;

    try {
      await _firestore.collection('metas').doc(uidUsuario).delete();
      print("Sucesso: Configurações deletadas do Firestore.");
    } catch (e) {
      print("Erro ao deletar documento do Firestore: $e");
    }
  }

  Stream<DocumentSnapshot> escutarConfiguracoes() {
    String? uidUsuario = _auth.currentUser?.uid;
    return _firestore.collection('metas').doc(uidUsuario).snapshots();
  }
}