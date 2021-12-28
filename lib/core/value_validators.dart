import 'package:dartz/dartz.dart';
import 'package:todo_flutter/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

/// NOTES VALIDATORS
//todo might
Either<ValueFailure<String>, String> validateNoteBody(
    String input, int maxLength) {
  return validateStringNotEmpty(input, maxLength)
      .andThen(validateMaxStringLength(input, maxLength)).andThen(validateIfSingleLine(input, maxLength));
}

Either<ValueFailure<String>, String> validateMaxStringLength(
    String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
        ValueFailure.tooLongLength(failedValue: input, maxLength: maxLength));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(
    String input, int maxLength) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateIfSingleLine(
    String input, int maxLength) {
  if (input.contains('/n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<List<T>>, List<T>> validateMaxListLength<T>(
    List<T> input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.listTooLong(failedValue: input, max: maxLength));
  }

}
