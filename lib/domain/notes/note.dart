import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/core/failures.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  const Note._();

  const factory Note(
      {required UniqueId id,
      required NoteBody noteBody,
      required NoteColor noteColor,
        required ListMaxSize3<TodoItem> maxListSize3,
 }) = _Note;

  factory Note.empty() => Note(
      id: UniqueId(),
      noteBody: NoteBody(''),
      noteColor: NoteColor(NoteColor.predefinedColor[0]),
      maxListSize3: List.empty() as ListMaxSize3<TodoItem> );

  /// validate whole Note
  /// //todo not finished  [13, 35 min]
  Option<ValueFailure<dynamic>> get failureOption{
    return noteBody.failureOrUnit.andThen(maxListSize3.failureOrUnit).fold((failure) => some(failure), (r) => none());
  }

}
