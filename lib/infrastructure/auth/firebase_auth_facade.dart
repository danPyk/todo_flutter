//in infrastrucutre, becouse of dealing with 3rd party

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:todo_flutter/core/errors.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/auth/auth_failure.dart';
import 'package:todo_flutter/domain/auth/i_auth_facade.dart';
import 'package:todo_flutter/domain/auth/user.dart' as auth_user;
import 'package:todo_flutter/domain/auth/value_objects.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    //extract value from ValueObject
    final emailAddressString =
        emailAddress.value.fold((l) => throw UnexpectedValueError(l), (r) => r);
    final passwordString =
        password.value.fold((l) => throw UnexpectedValueError(l), (r) => r);

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddressString, password: passwordString);

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == "email-already-in-use") {
        //converting errors to failures
        return left(const AuthFailure.emailAlreadyInUse());
      } else if (e.code == "invalid-email") {
        return left(const AuthFailure.invalidEmailAndPassword());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    //extract value from ValueObject
    final emailAddressString =
        emailAddress.value.fold((l) => throw UnexpectedValueError(l), (r) => r);
    final passwordString =
        password.value.fold((l) => throw UnexpectedValueError(l), (r) => r);

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddressString, password: passwordString);

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == "wrong-password" || e.code == "wrong-password") {
        //converting errors to failures
        return left(const AuthFailure.invalidEmailAndPassword());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken);

      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((value) => right(unit));
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

//todo added by myself
  @override
  Option<auth_user.User> getSignedInUser() {
    final currentUser = _firebaseAuth.currentUser?.uid;

    final logger = Logger();
    logger.d(currentUser);

    if (currentUser != null) {
      return optionOf(auth_user.User(id(UniqueId.fromString(currentUser))));
    } else {
      return optionOf(null);
    }
  }

  @override
  Future<void> signOut() {
    //wait is used just to wait for multiple methods finish
    return Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
}
