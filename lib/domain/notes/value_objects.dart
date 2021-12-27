import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_flutter/core/failures.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/core/value_transfromers.dart';
import 'package:todo_flutter/core/value_validators.dart';

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

class MaxListSize extends ValueObject<List> {
  static const maxLength = 3;

  @override
  final Either<ValueFailure<List>, List> value;

  int get length {
    //check if
    if (value.isRight()) {
      return value.length();
    } else {
      return 0;
    }
  }

  bool get isFull {
    return length == maxLength;
  }

  factory MaxListSize(List input) {
    return MaxListSize._(
      validateMaxListLength(input, maxLength),
    );
  }

  const MaxListSize._(this.value);
}
