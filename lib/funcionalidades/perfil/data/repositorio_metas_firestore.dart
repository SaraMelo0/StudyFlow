import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';
import 'package:study_flow/core/firebase/email_usuario_logado.dart';
import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';

class RepositorioMetasFirestore {
  RepositorioMetasFirestore({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _colecao =>
      _firestore.collection(colecaoMetas);

  Stream<List<MetaEstudo>> observarMetas() {
    final email = emailUsuarioLogadoOuNull();
    if (email == null) return Stream.value(const <MetaEstudo>[]);
    return _colecao
        .where(campoCriadoPor, isEqualTo: email)
        .snapshots()
        .map(_mapearDocumentos);
  }

  Future<void> criar(MetaEstudo meta) async {
    final email = exigirEmailUsuarioLogado();
    await _colecao.add({
      ...meta.toFirestore(),
      campoCriadoPor: email,
      campoCriadoEm: FieldValue.serverTimestamp(),
    });
  }

  Future<void> atualizar(MetaEstudo meta) async {
    await _colecao.doc(meta.id).update(meta.toFirestore());
  }

  Future<void> excluir(String id) async {
    await _colecao.doc(id).delete();
  }

  List<MetaEstudo> _mapearDocumentos(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final metas = <MetaEstudo>[];
    for (final doc in snapshot.docs) {
      try {
        metas.add(MetaEstudo.fromFirestore(doc.id, doc.data()));
      } on FormatException {
        // Ignora documentos sem campos obrigatórios.
      }
    }
    metas.sort((a, b) => a.prazo.compareTo(b.prazo));
    return metas;
  }
}
