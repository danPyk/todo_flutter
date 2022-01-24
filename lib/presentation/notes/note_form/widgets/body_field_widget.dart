import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_flutter/application/notes/note_form/note_form_bloc.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

class BodyField extends HookWidget {
  const BodyField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
///for putting edited text into TextFormField
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state) {
        textEditingController.text = state.note.noteBody.getOrCrash();
      },
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              labelText: 'Note',
             // counterText: '',
            ),
            maxLength: NoteBody.maxLength,
            maxLines: null,
            minLines: 5,
            onChanged: (value) => context
                .read<NoteFormBloc>()
                .add(NoteFormEvent.bodyChanged(value)),
            validator: (_) => context
                .read<NoteFormBloc>()
                .state
                .note
                .noteBody
                .value
                .fold(
                  (f) => f.maybeMap(
                    empty: (f) => 'Cannot be empty',
                    tooLongLength: (f) => 'Exceeding length, max: ${f.maxLength}',
                    orElse: () => null,
                  ),
                  (r) => null,
                ),
          )),
    );
  }
}
