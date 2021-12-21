//facade - design pattern, takes at least 2 classes and merge it into one
import 'package:dartz/dartz.dart';
import 'package:todo_flutter/domain/auth/auth_failure.dart';
import 'package:todo_flutter/domain/auth/value_objects.dart';

abstract class IAuthFacade{
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required EmailAddress emailAddress, required Password password });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required EmailAddress emailAddress, required Password password });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}

