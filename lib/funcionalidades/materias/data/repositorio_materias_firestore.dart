import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_flow/core/firebase/campos_firestore.dart';
import 'package:study_flow/core/firebase/email_usuario_logado.dart';
import 'package:study_flow/funcionalidades/materias/domain/materia.dart';

class RepositorioMateriasFirestore {
  RepositorioMateriasFirestore({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _colecao =>
      _firestore.collection(colecaoMaterias);

  Stream<List<Materia>> observarMaterias() {
    final email = exigirEmailUsuarioLogado();
    return _colecao
        .where(campoCriadoPor, isEqualTo: email)
        .snapshots()
        .map(_mapearDocumentos);
  }

  Future<void> criar(Materia materia) async {
    final email = exigirEmailUsuarioLogado();
    await _colecao.add({
      ...materia.toFirestore(),
      campoCriadoPor: email,
      campoCriadoEm: FieldValue.serverTimestamp(),
    });
  }

  Future<void> atualizar(Materia materia) async {
    await _colecao.doc(materia.id).update(materia.toFirestore());
  }

  Future<void> excluir(String id) async {
    await _colecao.doc(id).delete();
  }

  List<Materia> _mapearDocumentos(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final materias = <Materia>[];
    for (final doc in snapshot.docs) {
      try {
        materias.add(Materia.fromFirestore(doc.id, doc.data()));
      } on FormatException {
        // Ignora documentos sem campos obrigatórios.
      }
    }
    materias.sort(
      (a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()),
    );
    return materias;
  }
}
