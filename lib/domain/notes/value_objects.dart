import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_flutter/core/failures.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/core/value_transfromers.dart';
import 'package:todo_flutter/core/value_validators.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:kt_dart/kt.dart';


class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory NoteBody(String input) {
    return NoteBody._(
      validateNoteBody(input, maxLength),
    );
  }

  const NoteBody._(this.value);
}

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 30;

  factory TodoName(String input) {
    return TodoName._(
      validateNoteBody(input, maxLength),
    );
  }

  const TodoName._(this.value);
}

class NoteColor extends ValueObject<Color> {
  static const List<Color> predefinedColor = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // cream
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  factory NoteColor(Color input) {
    return NoteColor._(
      right(makeColorOpaque(input)),
    );
  }

  const NoteColor._(this.value);
}

class ListMaxSize3<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  factory ListMaxSize3(KtList<T> input) {
    return ListMaxSize3._(
      validateMaxListLength(input, maxLength),
    );
  }

  const ListMaxSize3._(this.value);

  int get length {
    return value.getOrElse(() => emptyList()).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
