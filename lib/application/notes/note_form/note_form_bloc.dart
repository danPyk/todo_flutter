import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_flutter/domain/notes/i_note_repository.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/note_failure.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';
import 'package:todo_flutter/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:kt_dart/collection.dart';

part 'note_form_bloc.freezed.dart';

part 'note_form_event.dart';

part 'note_form_state.dart';

///responsible of creating note
@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _iNoteRepository;

//todo might there was a problem with nullability, solved by adding ? to above NoteFormState
  NoteFormBloc(this._iNoteRepository) : super(NoteFormState.initial()) {
    on<NoteFormEvent>((event, emit) async {
      await event.map(initialized: (e) {
        ///if state is equal to previous state, emit previous state
        emit(e.initialNoteOption.fold(() => state,
            (initial) => state.copyWith(note: initial, isEditing: true)));
      }, bodyChanged: (e) {
        emit(state.copyWith(
            note: state.note.copyWith(noteBody: NoteBody(e.bodyString)),
            saveFailureOrSuccessOption: none()),);
      }, colorChanged: (e) {
        emit(state.copyWith(
            note: state.note.copyWith(noteColor: NoteColor(e.color)),
            saveFailureOrSuccessOption: none()),);
      }, todosChanged: (e) {
        emit(state.copyWith(
          //todo might
          note: state.note.copyWith(
            maxListSize3: ListMaxSize3(e.todosPrimitive
                .map((primitive) => primitive.toDomain())
                .toList()),
          ),
          saveFailureOrSuccessOption: none(),
        ));
      }, saved: (e) async {
        Either<NoteFailure, Unit>? failureOrSuccess;
        emit(
            state.copyWith(isSaving: true, saveFailureOrSuccessOption: none()));

        ///if there's no error, create note
        if (state.note.failureOption.isNone() != null) {
          failureOrSuccess = state.isEditing
              ? await _iNoteRepository.update(state.note)
              : await _iNoteRepository.create(state.note);
        }

        ///show error if occurs
        emit(state.copyWith(
            isSaving: false,
            showErrorMessages: true,
            saveFailureOrSuccessOption: optionOf(failureOrSuccess)));
      });
    });
  }
}
