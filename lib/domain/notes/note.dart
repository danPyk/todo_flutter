import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:todo_flutter/core/failures.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  const Note._();

  const factory Note({
    required UniqueId id,
    required NoteBody noteBody,
    required NoteColor noteColor,
    required ListMaxSize3<TodoItem> maxListSize3,
  }) = _Note;

  factory Note.empty() => Note(
        id: UniqueId(),
        noteBody: NoteBody(''),
        noteColor: NoteColor(NoteColor.predefinedColor[0]),
        maxListSize3: ListMaxSize3(emptyList()),
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return noteBody.failureOrUnit
        .andThen(maxListSize3.failureOrUnit)
        .andThen(
      maxListSize3
          .getOrCrash()
      // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
          .map((todoItem) => todoItem.failureOption)
          .filter((o) => o.isSome())
      // If we can't get the 0th element, the list is empty. In such a case, it's valid.
          .getOrElse(0, (_) => none())
          .fold(() => right(unit), (f) => left(f)),
    )
        .fold((f) => some(f), (_) => none());
  }
}
