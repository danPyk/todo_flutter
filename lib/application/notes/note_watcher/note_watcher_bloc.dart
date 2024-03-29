import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:todo_flutter/domain/notes/i_note_repository.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/note_failure.dart';

part 'note_watcher_bloc.freezed.dart';
part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

///Watches notes from firestore
@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  //used to later inject repository implementation
  final INoteRepository iNoteRepository;

  ///used to switch between watchAll and watchUncompleted
  StreamSubscription<Either<NoteFailure, KtList<Note>>>? _streamSubscription;

  NoteWatcherBloc(this.iNoteRepository)
      : super(const NoteWatcherState.initial()) {
    on<NoteWatcherEvent>((event, emit) {
      event.map(watchAllStarted: (e) async {
        emit(const NoteWatcherState.loadInProgress());
        await _streamSubscription?.cancel();

        ///we need to emit state after gathering evey element of list
        _streamSubscription = iNoteRepository.watchAll().listen(
              (failureOrNotes) =>
                  add(NoteWatcherEvent.notesReceived(failureOrNotes)),
            );
      }, watchUncompletedStarted: (e) async {
        emit(const NoteWatcherState.loadInProgress());
        await _streamSubscription?.cancel();
        _streamSubscription = iNoteRepository.watchUncompleted().listen(
              (failureOrNotes) => add(
                NoteWatcherEvent.notesReceived(failureOrNotes),
              ),
            );
      }, notesReceived: (e) {
        emit(
          e.failureOrNotes.fold((l) => NoteWatcherState.loadFailure(l),
              (r) => NoteWatcherState.loadSuccess(r)),
        );
      });
    });
  }

  @override
  Future<void> close() async {
    ///making sure that bloc stream is closed
    await _streamSubscription?.cancel();
    return super.close();
  }
}
