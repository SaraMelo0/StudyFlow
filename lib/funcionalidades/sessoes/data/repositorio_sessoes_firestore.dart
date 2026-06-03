import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';
import 'package:study_flow/core/firebase/email_usuario_logado.dart';
import 'package:study_flow/funcionalidades/sessoes/domain/sessao_estudo.dart';

class RepositorioSessoesFirestore {
  RepositorioSessoesFirestore({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _colecao =>
      _firestore.collection(colecaoSessoesEstudo);

  Stream<List<SessaoEstudo>> observarSessoes() {
    final email = exigirEmailUsuarioLogado();
    return _colecao
        .where(campoCriadoPor, isEqualTo: email)
        .snapshots()
        .map(_mapearDocumentos);
  }

  /// Usado pelo timer ao concluir uma sessão (integração futura).
  Future<void> registrarSessaoConcluida({
    required int duracaoMin,
    DateTime? inicio,
  }) async {
    final email = exigirEmailUsuarioLogado();
    await _colecao.add({
      'inicio': Timestamp.fromDate(inicio ?? DateTime.now()),
      'duracao_min': duracaoMin,
      'concluida': true,
      campoCriadoPor: email,
      campoCriadoEm: FieldValue.serverTimestamp(),
    });
  }

  List<SessaoEstudo> _mapearDocumentos(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final sessoes = <SessaoEstudo>[];
    for (final doc in snapshot.docs) {
      try {
        sessoes.add(SessaoEstudo.fromFirestore(doc.id, doc.data()));
      } on FormatException {
        // Ignora documentos inválidos.
      }
    }
    sessoes.sort((a, b) => b.inicio.compareTo(a.inicio));
    return sessoes;
  }
}
