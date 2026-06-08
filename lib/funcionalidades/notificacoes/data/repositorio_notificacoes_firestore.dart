import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';
import 'package:study_flow/core/firebase/email_usuario_logado.dart';
import 'package:study_flow/funcionalidades/notificacoes/domain/models/notificacao.dart';

class RepositorioNotificacoesFirestore {
  RepositorioNotificacoesFirestore({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _colecao =>
      _firestore.collection(colecaoNotificacoes);

  Stream<List<Notificacao>> observarNotificacoes() {
    final email = exigirEmailUsuarioLogado();
    return _colecao
        .where(campoCriadoPor, isEqualTo: email)
        .snapshots()
        .map(_mapearDocumentos);
  }

  Stream<bool> observarTemNaoLidas() {
    final email = exigirEmailUsuarioLogado();
    return _colecao
        .where(campoCriadoPor, isEqualTo: email)
        .where('lida', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  Future<void> criar(Notificacao notificacao) async {
    final email = exigirEmailUsuarioLogado();
    await _colecao.add({
      ...notificacao.toFirestore(),
      campoCriadoPor: email,
      campoCriadoEm: FieldValue.serverTimestamp(),
    });
  }

  Future<void> marcarComoLida(String id) async {
    await _colecao.doc(id).update({'lida': true});
  }

  Future<void> excluir(String id) async {
    await _colecao.doc(id).delete();
  }

  /// Remove documentos gravados pelo antigo sistema de seed (sem campo `tipo`
  /// ou com `tipo` vazio), pois não representam eventos reais do usuário.
  Future<void> limparNotificacoesMockadas() async {
    final email = exigirEmailUsuarioLogado();
    final snapshot = await _colecao
        .where(campoCriadoPor, isEqualTo: email)
        .get();

    final mockados = snapshot.docs.where((doc) {
      final tipo = doc.data()['tipo'];
      return tipo == null || (tipo as String).trim().isEmpty;
    }).toList();

    if (mockados.isEmpty) return;

    final batch = _firestore.batch();
    for (final doc in mockados) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  List<Notificacao> _mapearDocumentos(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final notificacoes = <Notificacao>[];
    for (final doc in snapshot.docs) {
      try {
        notificacoes.add(Notificacao.fromFirestore(doc.id, doc.data()));
      } on FormatException {
        // Ignora documentos com campos obrigatórios ausentes.
      }
    }
    notificacoes.sort((a, b) => b.criadoEm.compareTo(a.criadoEm));
    return notificacoes;
  }
}
