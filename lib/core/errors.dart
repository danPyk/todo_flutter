//errors are return when app is gonna crash
import 'package:todo_flutter/core/failures.dart';

class UnexpectedValueError extends Error{
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    return Error.safeToString('Encountered a ValueFailure at unrecoverable point. Terminating. Faile was $valueFailure');
  }
}

class NotAuthenticatedError extends Error{
}