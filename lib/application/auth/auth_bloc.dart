import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_flutter/domain/auth/i_auth_facade.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

//injectable will make sure that we can inject this bloc (find it with getIt) as factory, and check if constructor is proper
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //to not communicate directly with infrastructure implementation, we use facade;
  final IAuthFacade _iAuthFacade;

  AuthBloc(this._iAuthFacade) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(authCheckRequested: (e) async {

        final userLoggedStatus = await _iAuthFacade.getSignedInUser();
        emit(userLoggedStatus.fold(() => const AuthState.unauthenticated(),
            (_) => const AuthState.authenticated()));

      }, signedOut: (e) async {
        await _iAuthFacade.signOut();
        emit(const AuthState.unauthenticated());
      });
    });
  }
}
