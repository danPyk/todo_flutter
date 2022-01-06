part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  //not sure if user is authenticated or not
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated() = UnAuthenticated;
}
