import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/application/auth/auth_bloc.dart';
import 'package:todo_flutter/injection.dart';
import 'package:todo_flutter/presentation/notes/note_form/note_form_page.dart';
import 'package:todo_flutter/presentation/notes/note_overview/notes_overview_page.dart';
import 'package:todo_flutter/presentation/sign_in/sign_in_page.dart';
import 'package:todo_flutter/presentation/splash/splash_page.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //providing auth block as soon ass possible
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
        home: SplashPage(),
       // initialRoute: SplashPage.id,
        routes: {
          SignInPage.id: (context) => SignInPage(),
          SplashPage.id: (context) => SplashPage(),
          NotesOverviewPage.id: (context) =>  const NotesOverviewPage(),
          NoteFormPage.id: (context) =>     const NoteFormPage(),
        },
      ),
    );

  }
}
