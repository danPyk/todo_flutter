import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/application/auth/signInForm/sign_in_form_bloc.dart';
import 'package:todo_flutter/injection.dart';
import 'package:todo_flutter/presentation/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {

  static String id = "sign_in_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: SignInForm(),
      ),
    );
  }
}