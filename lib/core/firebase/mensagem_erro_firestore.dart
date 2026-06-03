import 'package:cloud_firestore/cloud_firestore.dart';

String mensagemErroFirestore(Object erro) {
  if (erro is FirebaseException) {
    if (erro.code == 'permission-denied') {
      return 'Não foi possível concluir a ação. Entre novamente na sua conta.';
    }
    return erro.message ?? 'Algo deu errado. Tente novamente em instantes.';
  }
  if (erro is StateError) {
    return erro.message;
  }
  return 'Não foi possível salvar agora. Verifique sua conexão e tente novamente.';
}
