import 'package:dartz/dartz.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/note_failure.dart';

abstract class INoteRepository {
  //watch  notes
  Stream<Either<NoteFailure, List<Note>>> watchAll();

  //watch uncompleted notes
  Stream<Either<NoteFailure, List<Note>>> watchUncompleted();

  //CUD. Why unit? Because CUD methods do not have return type
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
