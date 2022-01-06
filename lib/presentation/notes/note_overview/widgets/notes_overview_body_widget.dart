import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:todo_flutter/application/notes/note_watcher/note_watcher_bloc.dart';

import 'critical_failure_display_widget.dart';
import 'error_note_card_widget.dart';

class NotesOverviewBody extends StatelessWidget {
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    //BlocBuilder is like StreamBuilder for bloc
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) {
            logger.d("loadInProgress");
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          loadSuccess: (state) {
            logger.d("loadSuccess");

            return ListView.builder(
              itemBuilder: (context, index) {
                final note = state.notes[index];
                if (note.failureOption.isSome()) {
                  return ErrorNoteCard(note: note);
                } else {
                  return ErrorNoteCard(note: note);
                }
              },
              itemCount: state.notes.length,
            );
          },

          ///triggered when gathering all of notes fail
          loadFailure: (state) {
            logger.d("loadFailure");
            return CriticalFailureDisplay(
              failure: state.noteFailure,
            );
          },
        );
      },
    );
  }
}
