part of 'sign_in_form_bloc.dart';

// @immutable
// abstract class SignInFormState {}
//
// class SignInFormInitial extends SignInFormState {}

@freezed
class SignInFormState with _$SignInFormState {
  //data class
  const factory SignInFormState({
    required EmailAddress emailAddress,
    required Password password,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccess,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
      emailAddress: EmailAddress(''),
      password: Password(''),
      showErrorMessages: false,
      isSubmitting: false,
      authFailureOrSuccess: none());
}
