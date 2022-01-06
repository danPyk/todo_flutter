import 'package:bloc/bloc.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_flutter/domain/notes/i_note_repository.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/note_failure.dart';

part 'note_actor_bloc.freezed.dart';

part 'note_actor_event.dart';

part 'note_actor_state.dart';

///used for deleting notes
@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  late INoteRepository _iNoteRepository;

  NoteActorBloc() : super(const NoteActorState.initial()) {
    on<NoteActorEvent>((event, emit) async {
      emit(const NoteActorState.actionInProgress());
      //todo might need be awaited
      final possibleFailure = await _iNoteRepository.delete(event.note);

      emit(possibleFailure.fold((l) => NoteActorState.deleteFailure(l),
          (_) => const NoteActorState.deleteSuccess()));
    });
  }
}
