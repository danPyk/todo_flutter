part of 'note_form_bloc.dart';

@freezed
class NoteFormEvent with _$NoteFormEvent{
  const factory NoteFormEvent.initialized(Option<Note> initialNoteOption) = _Initialized;

  const factory NoteFormEvent.bodyChanged(String bodyString) = _BodyChanged;
const factory NoteFormEvent.colorChanged(Color color) = _ColorChanged;
const factory NoteFormEvent.todosChanged(KtList<TodoItemPrimitive> todosPrimitive) = _TodosChanged;
  ///used when note already have content
const factory NoteFormEvent.saved() = _Saved;
}