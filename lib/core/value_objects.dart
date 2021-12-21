import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  Either<ValueFailure<T>, T> get value;

  const ValueObject();

  @override
  String toString() => 'ValueObjects($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
