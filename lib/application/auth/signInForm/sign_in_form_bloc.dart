import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_flutter/domain/auth/auth_failure.dart';
import 'package:todo_flutter/domain/auth/i_auth_facade.dart';
import 'package:todo_flutter/domain/auth/value_objects.dart';

part 'sign_in_form_bloc.freezed.dart';

part 'sign_in_form_event.dart';

part 'sign_in_form_state.dart';
@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _iAuthFacade;

  SignInFormBloc(this._iAuthFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) {
      event.map(emailChanged: (e) {
        emit(state.copyWith(
          emailAddress: EmailAddress(e.email),
          //we are resetting email
          authFailureOrSuccess: none(),
        ));
      }, passwordChanged: (e) {
        emit(state.copyWith(
          password: Password(e.password),
          //we are resetting email
          authFailureOrSuccess: none(),
        ));
      },
          //check if EmailAddress and Password are valid, if valid register by IAuthFacade nad emit Some<Right<Unit>> in authFailureOrSuccessOption
          registerWithEmailAndPasswordPressed: (e) async {
        Either<AuthFailure, Unit>? failureOrSuccess;

        if (state.emailAddress.isValid() && state.password.isValid()) {
          //show progress indicator
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccess: none(),
          ));
          //register the user
          failureOrSuccess = await _iAuthFacade.registerWithEmailAndPassword(
              emailAddress: state.emailAddress, password: state.password);
          //updating, when get response from server

        }
        //when password or email is invalid:
        emit(state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          //optionOf is equall to  failureOrSuccess == null ? none() : some(failureOrSuccess)
          authFailureOrSuccess: optionOf(failureOrSuccess),
        ));
      },
          //todo below block is diffrent by above by just one call -  await _iAuthFacade.signInWithEmailAndPassword, can be refatored to higher order function
          signInWithEmailAndPasswordPressed: (e) async {
        Either<AuthFailure, Unit>? failureOrSuccess;

        if (state.emailAddress.isValid() && state.password.isValid()) {
          //show progress indicator
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccess: none(),
          ));
          //register the user
          failureOrSuccess = await _iAuthFacade.signInWithEmailAndPassword(
              emailAddress: state.emailAddress, password: state.password);
          //updating, when get response from server

        }
        //when password or email is invalid:
        emit(state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          //optionOf is equal to  failureOrSuccess == null ? none() : some(failureOrSuccess)
          authFailureOrSuccess: optionOf(failureOrSuccess),
        ));
      }, signInWithGooglePressed: (e) async {
        emit(state.copyWith(
          isSubmitting: true,
          //we are resetting email
          authFailureOrSuccess: none(),
        ));
        final failureOrSuccess = await _iAuthFacade.signInWithGoogle();
        emit(state.copyWith(
          isSubmitting: false,
          authFailureOrSuccess: some(failureOrSuccess),
        ));
      });
    });
  }
}
