import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sessao.dart';

class SessaoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _colecao =>
      _db.collection('sessoes');

  String? get _emailUsuario => FirebaseAuth.instance.currentUser?.email;

  Stream<List<Sessao>> observarSessoes() {
    final email = _emailUsuario;
    return _colecao
        .where('criado_por', isEqualTo: email)
        .snapshots()
        .map((snap) {
      final lista = snap.docs
          .map((doc) => Sessao.fromMap(doc.data(), id: doc.id))
          .toList();
      lista.sort((a, b) => b.dataHora.compareTo(a.dataHora));
      return lista;
    });
  }

  Future<void> criar({
    required String materia,
    required int duracaoMinutos,
    required DateTime dataHora,
  }) async {
    final email = _emailUsuario;
    if (email == null) {
      throw Exception('Nenhum usuario logado.');
    }
    await _colecao.add({
      'materia': materia,
      'duracao_minutos': duracaoMinutos,
      'data_hora': dataHora.toIso8601String(),
      'criado_por': email,
    });
  }

  Future<void> atualizar(
    String id, {
    required String materia,
    required int duracaoMinutos,
  }) async {
    await _colecao.doc(id).update({
      'materia': materia,
      'duracao_minutos': duracaoMinutos,
    });
  }

  Future<void> deletar(String id) async {
    await _colecao.doc(id).delete();
  }
}
