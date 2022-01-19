import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/application/notes/note_form/note_form_bloc.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/presentation/notes/note_overview/notes_overview_page.dart';
import 'package:todo_flutter/presentation/widgets/global_snackbar.dart';

import '../../../injection.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editedNote;

  static String id = "note_form_page";

  const NoteFormPage({
    Key? key,
    this.editedNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteFormBloc>(
      create: (context) => getIt<NoteFormBloc>()
        ..add(NoteFormEvent.initialized(optionOf(editedNote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (p, c) =>
            p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,

        ///show snackbar
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () {},
            (either) {
              either.fold(
                (failure) {
                  GlobalSnackBar.show(
                    context,
                    failure.map(
                      insufficientPermission: (_) =>
                          'Insufficient permissions ❌',
                      unableToUpdate: (_) =>
                          "Couldn't update the note. Was it deleted from another device?",
                      unexpected: (_) =>
                          'Unexpected error occured, please contact support.',
                    ),
                  );
                },
                (_) {
                  Navigator.popUntil(context, (route) => route.settings.name == NotesOverviewPage.id );
                },
              );
            },
          );
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Container(),
              const NoteFormPageScaffold(),
               SavingInProgressOverlay(isSaving: state.isSaving)
            ],
          );
        },
      ),
   );
  }
}


class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(
                'Saving',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  const NoteFormPageScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (p, c) => p.isEditing != c.isEditing,
          builder: (context, state) {
            return Text(state.isEditing ? 'Edit a note' : 'Create a note');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              context.watch<NoteFormBloc>().add(const NoteFormEvent.saved());
            },
          )
        ],
      ),
      // body: BlocBuilder<NoteFormBloc, NoteFormState>(
      //   buildWhen: (p, c) => p.showErrorMessages != c.showErrorMessages,
      //   builder: (context, state) {
      //     return ChangeNotifierProvider(
      //       create: (_) => FormTodos(),
      //       child: Form(
      //         //autovalidate: state.showErrorMessages,
      //         child: SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               const BodyField(),
      //               const ColorField(),
      //               const TodoList(),
      //               const AddTodoTile(),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
