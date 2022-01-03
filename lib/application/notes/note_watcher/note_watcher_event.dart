part of 'note_watcher_bloc.dart';

@freezed
 class NoteWatcherEvent with _$NoteWatcherEvent {
  const factory NoteWatcherEvent.watchAllStarted() = _WatchAllStarted;
  const factory NoteWatcherEvent.watchUncompletedStarted() =
  _WatchUncompletedStarted;
  ///this helpful state is only used inside bloc to add possibility to selecting all or completed notes
  const factory NoteWatcherEvent.notesReceived(
      Either<NoteFailure, List<Note>> failureOrNotes,
      ) = _NotesReceived;


}
