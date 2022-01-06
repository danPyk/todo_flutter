import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_flutter/domain/notes/i_note_repository.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/note_failure.dart';
import 'package:todo_flutter/infrastructure/core/firestore_helpers.dart';
import 'package:todo_flutter/infrastructure/notes/note_dtos.dart';

///firebase structure
///users/{user ID}/notes/{note ID (todos as array ToDoo objects]

///register as INoteRepository type allows us to whenever request INoteReposiotory using injectable then retrieve NoteReposiotory
@LazySingleton(as: INoteRepository)
class NoteRepository implements INoteRepository {
  late final FirebaseFirestore _firestore;

  NoteRepository(this._firestore);

  @override
  Future<Either<NoteFailure, Unit>> create(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDto.fromDomain(note);

      ///set - Sets data on the document, overwriting any existing data.
      await userDoc.noteCollection.doc(noteDto.id).set(noteDto.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDto.fromDomain(note);

      await userDoc.noteCollection.doc(noteDto.id).update(noteDto.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (e.message!.contains('not_found')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteId = note.id.getOrCrash();

      await userDoc.noteCollection.doc(noteId).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (e.message!.contains('not_found')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  }

//todo might
  @override
  Stream<Either<NoteFailure, List<Note>>> watchAll() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        //todo .orderBy('serverTimeStamp', descending: true)
        .snapshots()

        ///we can safely return only right side of Either
        .map(
          (snapshot) => right<NoteFailure, List<Note>>(snapshot.docs
              .map((doc) => NoteDto.fromFirestore(doc).toDomain())
              .toList()),
        )
        .onErrorReturnWith((e, st) {

      if (e is FirebaseException && e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<NoteFailure, List<Note>>> watchUncompleted() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()

        ///map to Note
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => NoteDto.fromFirestore(doc).toDomain()),
        )

        ///filter results
        .map(
          (notes) => right<NoteFailure, List<Note>>(
            notes
                .where((note) => note.maxListSize3
                    .getOrCrash()
                    .any((todoItem) => !todoItem.done))
                .toList(),
          ),
        )
        .onErrorReturnWith((e, st) {
      if (e is FirebaseException && e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // log.error(e.toString());
        return left(const NoteFailure.unexpected());
      }
    });
  }
}
