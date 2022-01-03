import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_flutter/domain/notes/i_note_repository.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/note_failure.dart';

///register as INoteRepository type allows us to whenever request INoteReposiotory using injectable then retrieve NoteReposiotory
@LazySingleton(as : INoteRepository)
class NoteRepository implements INoteRepository{

  late final FirebaseFirestore _firestore;

  NoteRepository(this._firestore);
  @override
  Future<Either<NoteFailure, Unit>> create(Note note) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note
      ) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<NoteFailure, List<Note>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<NoteFailure, List<Note>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

}