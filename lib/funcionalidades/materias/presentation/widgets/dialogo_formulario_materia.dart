import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:study_flow/core/strings/textos_aplicacao.dart';
import 'package:study_flow/core/theme/cores_aplicacao.dart';
import 'package:study_flow/funcionalidades/materias/domain/materia.dart';

enum ModoDialogoMateria { nova, editar }

class ResultadoFormularioMateria {
  const ResultadoFormularioMateria({
    required this.nome,
    required this.progressoPercentual,
  });

  final String nome;
  final int progressoPercentual;
}

Future<ResultadoFormularioMateria?> mostrarDialogoFormularioMateria(
  BuildContext context, {
  required ModoDialogoMateria modo,
  Materia? materia,
}) {
  return showDialog<ResultadoFormularioMateria>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (contextoDialogo) {
      return DialogoFormularioMateria(modo: modo, materia: materia);
    },
  );
}

class DialogoFormularioMateria extends StatefulWidget {
  const DialogoFormularioMateria({
    super.key,
    required this.modo,
    this.materia,
  });

  final ModoDialogoMateria modo;
  final Materia? materia;

  @override
  State<DialogoFormularioMateria> createState() =>
      _DialogoFormularioMateriaEstado();
}

class _DialogoFormularioMateriaEstado extends State<DialogoFormularioMateria> {
  late final TextEditingController _controladorNome;
  late final TextEditingController _controladorProgresso;

  @override
  void initState() {
    super.initState();
    _controladorNome = TextEditingController(text: widget.materia?.nome ?? '');
    _controladorProgresso = TextEditingController(
      text: '${widget.materia?.progressoPercentual ?? 0}',
    );
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorProgresso.dispose();
    super.dispose();
  }

  void _confirmar() {
    final nome = _controladorNome.text.trim();
    if (nome.isEmpty) return;

    final progresso = int.tryParse(_controladorProgresso.text.trim()) ?? 0;
    final progressoLimitado = progresso.clamp(0, 100);

    Navigator.of(context).pop(
      ResultadoFormularioMateria(
        nome: nome,
        progressoPercentual: progressoLimitado,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);
    final titulo = widget.modo == ModoDialogoMateria.nova
        ? TextosAplicacao.materiasDialogoNova.texto
        : TextosAplicacao.materiasDialogoEditar.texto;
    final rotuloAcao = widget.modo == ModoDialogoMateria.nova
        ? TextosAplicacao.materiasAdicionar.texto
        : TextosAplicacao.materiasSalvar.texto;

    final estiloRotulo = temaTexto.labelLarge?.copyWith(
      color: CoresAplicacao.preto,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );
    final estiloCampo = temaTexto.bodyLarge?.copyWith(
      color: CoresAplicacao.preto,
      fontSize: 15,
    );

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: temaTexto.titleLarge?.copyWith(
                color: CoresAplicacao.preto,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              TextosAplicacao.materiasRotuloNome.texto,
              style: estiloRotulo,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controladorNome,
              style: estiloCampo,
              textCapitalization: TextCapitalization.sentences,
              decoration: _decoracaoCampo(
                dica: TextosAplicacao.materiasDicaNome.texto,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              TextosAplicacao.materiasRotuloProgresso.texto,
              style: estiloRotulo,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controladorProgresso,
              style: estiloCampo,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: _decoracaoCampo(),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: _BotaoDialogoSecundario(
                    rotulo: TextosAplicacao.materiasCancelar.texto,
                    temaTexto: temaTexto,
                    aoPressionar: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _BotaoDialogoPrimario(
                    rotulo: rotuloAcao,
                    temaTexto: temaTexto,
                    aoPressionar: _confirmar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoracaoCampo({String? dica}) {
    return InputDecoration(
      hintText: dica,
      hintStyle: TextStyle(
        color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.55),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: CoresAplicacao.preenchimentoCampo,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CoresAplicacao.laranja, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      isDense: true,
    );
  }
}

class _BotaoDialogoSecundario extends StatelessWidget {
  const _BotaoDialogoSecundario({
    required this.rotulo,
    required this.temaTexto,
    required this.aoPressionar,
  });

  final String rotulo;
  final TextTheme temaTexto;
  final VoidCallback aoPressionar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: aoPressionar,
        style: OutlinedButton.styleFrom(
          foregroundColor: CoresAplicacao.preto,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: CoresAplicacao.cinzaRotulo.withValues(alpha: 0.25),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: temaTexto.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        child: Text(rotulo),
      ),
    );
  }
}

class _BotaoDialogoPrimario extends StatelessWidget {
  const _BotaoDialogoPrimario({
    required this.rotulo,
    required this.temaTexto,
    required this.aoPressionar,
  });

  final String rotulo;
  final TextTheme temaTexto;
  final VoidCallback aoPressionar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: aoPressionar,
        style: FilledButton.styleFrom(
          backgroundColor: CoresAplicacao.laranja,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: temaTexto.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        child: Text(rotulo),
      ),
    );
  }
}
