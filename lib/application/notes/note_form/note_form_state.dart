part of 'note_form_bloc.dart';

@freezed
 class NoteFormState with _$NoteFormState {
  const factory NoteFormState({
    ///represents all validated fields
    required Note note,
    required bool showErrorMessages,
    ///determine if we creating new note or updating existing one
    required bool isEditing,
    ///show progress of operation
    required bool isSaving,
    required Option<Either<NoteFailure, Unit>> saveFailureOrSuccessOption,
  }) = _NoteFormState;

  factory NoteFormState.initial() => NoteFormState(
    note: Note.empty(),
    showErrorMessages: false,
    isEditing: false,
    isSaving: false,
    saveFailureOrSuccessOption: none(),
  );
}
