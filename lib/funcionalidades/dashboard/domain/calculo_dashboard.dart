import 'package:study_flow/funcionalidades/perfil/model/meta_estudo.dart';

MetaEstudo? proximaMetaAtiva(List<MetaEstudo> metas) {
  final ativas = metas.where((m) => !m.concluida).toList();
  if (ativas.isEmpty) return null;
  ativas.sort((a, b) => a.prazo.compareTo(b.prazo));
  return ativas.first;
}

int contarMetasAtivas(List<MetaEstudo> metas) =>
    metas.where((m) => !m.concluida).length;
